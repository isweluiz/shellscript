#!/bin/bash
# This can avoid the need to delete and recreate resources when deploying the helm chart

# Prerequisites:
# - jq
# - oc client
# - Openshift login
# - component label defined

# IF conditional to check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <namespace> <release_name> <component>"
    echo "Example: ./helm_import.sh namespace helm-release label"
    exit 1
fi

NAMESPACE=$1
RELEASE_NAME=$2
COMPONENT=$3

# Function to annotate and label resources
annotate_and_label() {
  local namespace=$1
  local resource_type=$2
  local resource_name=$3
  local release_name=$4

  oc label --overwrite -n $namespace $resource_type/$resource_name app.kubernetes.io/managed-by=Helm
  oc annotate --overwrite -n $namespace $resource_type/$resource_name meta.helm.sh/release-name=$release_name
  oc annotate --overwrite -n $namespace $resource_type/$resource_name meta.helm.sh/release-namespace=$namespace
}

# Function to get labels and annotations for all components
function_get_labels_annotations(){
  local namespace=$1
  local resource_type=$2
  local resource_name=$3
  
  echo "----------------------------------------------------------------------------------------------------------------"
  echo "Getting labels and annotations for $resource_type $resource_name in $namespace namespace"
  echo "----------------------------------------------------------------------------------------------------------------"

  oc get $resource_type $resource_name -n $namespace -o jsonpath='{.metadata.labels}' | jq
  oc get $resource_type $resource_name -n $namespace -o jsonpath='{.metadata.annotations}' | jq
}

echo "----------------------------------------------------------------------------------------------------------------"
echo "Importing resources for $COMPONENT in $NAMESPACE namespace with the release name $RELEASE_NAME"
echo "----------------------------------------------------------------------------------------------------------------"

# List of resource types
# Add more resource types if needed
# The script will loop through all resources of the resource types defined below
RESOURCE_TYPES=("secrets" "configmaps" "routes" "services" "deployments")

# Loop through resource types and resources
for resource_type in "${RESOURCE_TYPES[@]}"; do
  resources=$(oc get $resource_type -n $NAMESPACE -l component=$COMPONENT --no-headers -o custom-columns=NAME:.metadata.name)
  for resource in $resources; do
    annotate_and_label $NAMESPACE $resource_type $resource $RELEASE_NAME # Annotate and label resources
    function_get_labels_annotations $NAMESPACE $resource_type $resource  # Get labels and annotations for resources
  done
done
