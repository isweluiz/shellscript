#!/usr/bin/env python3
# This python script creates Jira issues using the Jira REST API.
# The script reads a JSON file containing the issue details and creates the issues in Jira.
# The usage of the script is as follows:
# python create-jira-issues.py --input <input_file> --url <jira_url> --user_email <user_email> --api_token <api_token> --variables <variable>

import argparse
import os
import json
import base64
import requests
from github_action_utils import set_output


def parse_args():
    """
    Parse command-line arguments.
    """
    parser = argparse.ArgumentParser(description="Create Jira issues")
    parser.add_argument("--input", type=str, help="Input file (JSON)", required=True)
    parser.add_argument("--url", type=str, help="URL to Jira instance", required=True)
    parser.add_argument("--user_email", type=str, help="User email", required=True)
    parser.add_argument("--api_token", type=str, help="API token", required=True)
    parser.add_argument("--variables", type=str, help="Single variable in the form key=value", required=False)
    return parser.parse_args()


def replace_placeholder(json_data, variable):
    """
    Replace a single placeholder in the JSON file with the provided variable.
    """
    if not variable:
        return json_data

    key, value = variable.split("=", 1)
    placeholder = f"{{{{ {key} }}}}"  # Matches syntax like {{ VARIABLE }}
    json_str = json.dumps(json_data)
    json_str = json_str.replace(placeholder, value)
    return json.loads(json_str)


def main():
    # Parse arguments
    args = parse_args()

    # Create authentication token
    token = base64.b64encode(f"{args.user_email}:{args.api_token}".encode("utf-8")).decode("utf-8")

    # Read and process the JSON file
    with open(args.input, "r") as file:
        json_data = json.load(file)

    # Replace placeholder if variable is provided
    if args.variables:
        json_data = replace_placeholder(json_data, args.variables)

    # Jira API endpoint
    jira_url = f"{args.url}/rest/api/2/issue"
    headers = {"Content-Type": "application/json", "Authorization": f"Basic {token}"}

    # Create Jira issues
    issues = []
    for issue in json_data["issue"]:
        payload = json.dumps(issue)
        response = requests.post(jira_url, headers=headers, data=payload)
        if response.status_code == 201:
            issue_key = response.json()["key"]
            issues.append(issue_key)
            print(f"Jira issue {issue_key} created successfully!")
        else:
            print(f"Failed to create Jira issue. Status code: {response.status_code}")
            error_messages = response.json().get("errorMessages")
            if error_messages:
                for error_message in error_messages:
                    print(error_message)

    # Output created issues
    issue_list = ",".join(issues)
    if "GITHUB_OUTPUT" in os.environ:
        set_output("issues", issue_list)
    else:
        print(issue_list)


if __name__ == "__main__":
    main()
