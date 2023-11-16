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


## Dealing with configuration Drift

### Terraform Import

If you loose your statefile, you most likely have to tear down all your infrastructure manually. You can use terraform import, but it wont work with all resources. You need to check terraform providers documentation for which resources support terraform import
### Fix Missing Resources With Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket.html#import)
### Fix Manual Configuration

If someone deletes or modifies cloud resources manually through clickops,

If we run terraform plan it will attempt to put our infrastructure back to the expected state fixing Configuration Drift.

### Fix terraform using Terraform Refresh
```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

It is reccomended to place modules in a modules directory when developing modules, but you can place it where you like

### Passing Imput Variables

We can pass input variables to our module.
the module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  }
```

### Module Sources

Using the source we can import the module from diffrent places eg:
- locally,
- github, 
- terraform registry
```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  }
```

[module sources](https://developer.hashicorp.com/terraform/language/modules/sources#github)
