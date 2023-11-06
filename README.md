# Terraform Beginner Bootcamp 2023

## Table of Content

- [Semantic Versioning](#semantic-versioning)
- [Install Terraform CLI](#install-terraform-cli)
    - [Considerations for Linux Distribution](#considerations-for-linux-distribution)
    - [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
- [Github Lifecycle (Before, Init, Command)](#github-lifecycle-before-init-command)
- [Working Env Var](#working-env-var)
    - [env command](#env-command)
    - [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
    - [Scoping of Env Vars](#scoping-of-env-vars)
    - [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
- [Terraform Basics](#terraform-basics)
    - [Terraform Registry](#terraform-registry)
    - [Terraform Console](#terraform-console)
- [Terraform statefile](#terraform-state-files)
    - [Terrform lock file](#terraform-lock-file)
    - [Terraform Directory](#terraform-directory)
- [Terraform Cloud](#terraform-cloud)










## Semantic Versioning 

This project is going to utilize semantic versioning for its tagging.

https://semver.org

The general format:

**MAJOR.MINOR.PATCH**, EG `1.0.1` 
Given a version number MAJOR.MINOR.PATCH, increment the:

- MAJOR version when you make incompatible API changes
- MINOR version when you add functionality in a backward compatible manner
- PATCH version when you make backward compatible bug fixes
- Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install Terraform CLI
Installation instruction has been updated. So we needed to refer to the latest Install CLI instructions via Terraform Documentation to change the scripting for install

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntu... 
Check to see if there are any dependencies relating to your distribution

Example:

```
$ cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the terraform cli, we notice that bash scripts step have a lot more code. So we decided to create a bash script to install the Terraform CLI

This bash script is located here : [./bin/install_terraform_cli](./bin/install_terraform_cli)
- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) Tidy
- This allows easier debugging and execution
- Better portablity for projects that need to install terraform cli.
https://en.wikipedia.org/wiki/Shebang_(Unix)
https://en.wikipedia.org/wiki/Chmod
https://www.gitpod.io/docs/configure/workspaces/workspace-lifecycle

### Github Lifecycle (Before, Init, Command)

We need to be careful when using Init because it will not rerun if we restart an existing workspace

https://www.gitpod.io/docs/configure/workspaces/tasks


### Working Env Var

#### env command

We can list out all environment varibles (Env vars) using thr `env` command.

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal, we can set using `export HELLO= 'world'`

In the terminal, we can unset using `unset HELLO`

We can set an env var temporarily when running a command eg

```sh
HELLO= 'world' ./bin/print_message
```
Within a bash script we can set env var without writing export eg.

```sh
#!/usr/bin/env bash
HELLO='world'

echo $HELLO
```

## PRinting Vars
using echo eg. `echo $HElLO`

#### Scoping of Env Vars

When you open new terminals in vs code, it will not be aware of env var in previous terminal.

If you want env vars to persist, you need to set env vars in bash profile. eg `.bash_profile`


#### Persisting Env Vars in Gitpod

We can persist env vars in gitpod by storing them in Gitpod Secrets Storage

```sh
gp env HELLO='world'
```
All future workspaces will set the new env vars for all bash tertminals opened in the workspaces

you can also set env vars in the `.gitpod.yml` but this can only contain non sensitive env vars for security purposes.

Need to generate aws iam users to generate user cred



## Terraform Basics

### Terraform Registry

Trraform sources their providers and modules from the terraform registry which is located at [registry.terraform.io](https://registry.terraform.io)

- **Provider** is an interface/Plugin to interact with the API or cloud provider eg. `AWS`

- **Modules** are a way to make large ammount of terraform code modular, break it into portable parts that can be shared and easily edited

### Terraform Console

We can see a list of all the terraform commands by simply typing `terraform`

#### Terraform Init

At the start of a new project, we run `terraform init` to download the related binary for the provider that will be used for the project

['Random' Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)

#### Terraform Plan

`terraform plan` will
Generate a changeset, about the current state and the changes that will be made to the infrastructure

#### Terraform Apply

`terraform apply` will apply said changes in the plan to the resource/infrastructure. To automate, 

`terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`
This will destroy resources.

`terraform destroy --auto-approve` will destroy without confirmation 

## Terraform lock File

`.terraform.lock.hcl` contains the configuration/ versioning for the providers or modules that should be used in the project

The terraform lockn file should be committed to your version control system (VSC) eg. Github

### Terraform State Files

`.terraform.tfstate` contains the current state of your infrastructure.

This file should not be **committed** to your VSC

This file containss sensitive data. If you loose this file, you loose knowing the state of your infrastructure

`.terraform.tfstate.backup` is the previous state file before the current

### Terraform Directory
`.terraform` directory contains binaries of terraform providers.

## TERRAFORM CLOUD

We have automated the process of manual token for terraform cloud implementation using the bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)
