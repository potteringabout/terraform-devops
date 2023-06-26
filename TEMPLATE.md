## Variables

### Repository level variables

|Name|Description|Example|
|---|---|---|
|ENVIRONMENTS|Array of environment names.  These should match the environments defined in GitHub Environments|["dev01","test01","test02","prod01"]|
|TF_VERSION|Version of terraform used for the deployment|1.4.6|

### Environment level variables

|Name|Description|Example|
|---|---|---|
|TF_DYNAMO_TABLE|Terraform dynamo table for this account/environment||
|TF_STATE_BUCKET|Terraform state bucket for this account/environment||
|CONFIG|A json object all variables required for the environment deployment ( See below )||


#### CONFIG object

Variables contained in the CONFIG object will be passed to the terraform execution 
as a tfvars.json.  The following variables are mandatory

    {
      "account": "<account short name>",                            # Eg. dev
      "account_full": "<full name for the account>",                # Eg. DFE devlopment account
      "costcentre": "<cost centre>",                                # Eg. 123
      "deployment_mode": "<manual|auto>",                           # Eg. auto
      "deployment_repo": "<repo url containing deployment code>",   # Eg. https://github.com/Allwyn-UK/dfe-tf-infra.git
      "email": "<support contact email address>",                   # Eg. plateng@allwyn.co.uk
      "environment": "<environment short name>",                    # Eg. test01
      "environment_full": "<environment full name>",                # Eg. test01 - integration test
      "owner": "<team name of assets owner>",                       # Eg. Platform Engineering
      "project": "<project short name>",                            # Eg. DFE
      "project_full": "<project full name>"                         # Eg. Digital Front End
    }









## CODEOWNERS


## Pre-Commit Hooks


## CodeSpaces



