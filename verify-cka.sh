#!/bin/bash
echo -e "Checking Objectives..."
OBJECTIVE_NUM=0
function printresult {
  ((OBJECTIVE_NUM+=1))
  echo -e "\n----- Checking Objective $OBJECTIVE_NUM -----"
  echo -e "----- $1"
  if [ $2 -eq 0 ]; then
      echo -e "      \033[0;32m[COMPLETE]\033[0m Congrats! This objective is complete!"
  else
      echo -e "      \033[0;31m[INCOMPLETE]\033[0m This objective is not yet completed!"
  fi
}

expected='2'
actual=$(cat /k8s/0001/count.txt 2>/dev/null)
[[ "$actual" = "$expected" ]]
printresult "Count the number of nodes that are ready to run normal workloads." $?

expected='[ERROR] Could not process record 006c27
[ERROR] Could not process record 01a45c'
actual=$(cat /k8s/0002/errors.txt 2>/dev/null)
[[ "$actual" = "$expected" ]]
printresult "Retrieve error messages from a container log." $?

expected='auth-web'
actual=$(cat /k8s/0003/cpu-pod.txt 2>/dev/null)
[[ "$actual" = "$expected" ]]
printresult "Find the Pod that is utilizing the most CPU within a Namespace." $?
