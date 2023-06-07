# Terrform project template

Sample project for deploying AWS infrastructure using Terraform

## Terragrunt

Terragrunt has various benefits around dependency management, variables
managament etc.  We will use it as a terraform wrapper.

## Repository Structure

### Components

Code is broken down into `components`.  A component is a container for a
discreet piece of functionality.
__Should we have components for iam and security groups__  

### Terraform version

Project includes `terraform.yml` file to allow us to control the version of
terraform used in the deployment.
Note: we can maybe do this in terragrunt but I think tfswitch provides us with a
better way to manage this.

## Config vs Code

Config will be stored in GitHub environments in yaml.
We will have the ability to pass in on the command-line for deployments to dev.

eg.  

    accountid: 123456789012
    tags:
      project: web
      account: dev
      environment: dev01
      owner: dave
      email: dave@test.com

## Shared actions / re-usable workflows

This repository contains local GitHub actions.  These will be centralised/shared
going forward.

### Dev vs Test/Prod Deployments

How do we provide command-line access to deploy to dev?

## Notes

### Finding the GitHub Repository ID

Can be found with script

    #!/bin/bash
    OWNER='your github username or organization name'
    REPO_NAME='your repository name'    
    echo $(gh api -H "Accept: application/vnd.github+json" repos/$OWNER/$REPO_NAME) | jq .id

### GitHub OIDC subject

The OIDC subject passed to AWS by default contains the repository name and the context.
That might be

    repo: xxxx
    environment: dev01 - the GitHub environment.

We can customise at the repository level or org level what we gets passed in the token.

To see what gets passed...

    gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repositories/REPOSITORY_ID/environments/ENVIRONMENT/secrets

    gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repositories/625481833/environments/prod/secrets

We need to use curl ( or something similar ) to update the subject.

    curl -L \
      -X PUT \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer <YOUR-TOKEN>"\
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/repos/<org>/<repo>/actions/oidc/customization/sub \
      -d '{"use_default":false,"include_claim_keys":["repo","context", "repository_visibility", "ref", "ref_type" ]}'
