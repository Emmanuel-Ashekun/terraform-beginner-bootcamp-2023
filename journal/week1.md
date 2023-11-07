# Terraform Beginner Bootcamp 2023 - week 1

## Root Module Structure

Our root module structure is as follows:

```
    PROJECT_ROOT
│
├── variables.tf        - stores the structure of our input variables
├── main.tf             - Everything
├── providers.tf        - defines required providers and their configuration
├── outputs.tf          - stores our outputs
├── terraform.tfvars    - the data of variables we want to load into our terraform project
└── README.md           - required for root modules
```


[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

##

### Terraform Cloud Variables

In terraform we can set two kinds
- Environment- bash terminal
- Terraform - tfvars 

### Loading Terraform Variables

we can use the `-var` to set ann input variable or override a variable in the tfvar file

### var-file flah
- [TODO] : research this file

### terraform.tfvars

This is the default file to load in terraform variables in bulk

### auto.tfvars
- TODO: Document

### order of terraform variables
- TODO: Document which takes precedence