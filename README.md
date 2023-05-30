# Terrform project template



## Terragrunt

## Repository Structure

* terraform.yml



## Config vs Code


## Shared actions / re-usable workflows

### Dev vs Test/Prod Deployments


GitHub Repo id

Can eb  found with script

```bash
#!/bin/bash
OWNER='your github username or organization name'
REPO_NAME='your repository name'    
echo $(gh api -H "Accept: application/vnd.github+json" repos/$OWNER/$REPO_NAME) | jq .id
```
## Secrets

https://docs.github.com/en/rest/actions/secrets?apiVersion=2022-11-28



# GitHub CLI api
# https://cli.github.com/manual/gh_api

gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repositories/REPOSITORY_ID/environments/ENVIRONMENT/secrets

gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repositories/625481833/environments/prod/secrets




curl -L \
  -X PUT \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <YOUR-TOKEN>"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/potteringabout/terraform-devops/actions/oidc/customization/sub \
  -d '{"use_default":false,"include_claim_keys":["repo","context", "repository_visibility", "ref", "ref_type" ]}'