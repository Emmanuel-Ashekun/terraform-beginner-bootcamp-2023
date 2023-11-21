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

```t
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  }
```

### Module Sources

Using the source we can import the module from diffrent places eg:
- locally,
- github, 
- terraform registry
```t
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  }
```

## Working with files in Terraform

### Fileexists function

[fileexist_documentation](https://developer.hashicorp.com/terraform/language/functions/fileexists)

This is a built in terraform function to check the existence of a file. e.g:
```t
  validation {
    condition     = fileexists(var.index_html_filepath)
  }
```

### Path Variable

In Terraform, there is a special variable called path that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)


```t
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/modules/punlic/index.html"
}
   ```


### Terraform Data Sources

This allows us to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

e.g
```t
data "aws_ami" "example" {
  most_recent = true

  owners = ["self"]
  tags = {
    Name   = "app-server"
    Tested = "true"
  }
}
```

### Terraform Locals values

Locals allow us to define local variables.
It can be very useful when we want to transfer data into another format an have ot referenced as a variable

[locals values](https://developer.hashicorp.com/terraform/language/values/locals)

```t
locals {
  s3_origin_id = "Mys3origin"
}
```
### Working with JSON

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode) 

we use the jsonencode to create json policy inline in the hcl (terraform language is hcl)

```t
> jsonencode({"hello"="world"})
{"hello":"world"}

```


[module sources](https://developer.hashicorp.com/terraform/language/modules/sources#github)


### Changing the Lifecycle of Resources

[Meta Argument Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

### Terraform Data

The terraform_data implements the standard resource lifecycle, but does not directly take any other actions. You can use the terraform_data resource without requiring or configuring a provider. It is always available through a built-in provider with the source address terraform.io/builtin/terraform.

The terraform_data resource is useful for storing values which need to follow a manage resource lifecycle, and for triggering provisioners when there is no other logical managed resource in which to place them.



[Terraform data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)
## Provisioners
Provisioners allow you to execute commands on compute instances e.g a AWS CLI command

They are not recommended for use by hashicorp because configuration managment tools like ansible are a better fit, but the functionality exists.

### Local-exec

```t
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

this will execute a command on the machine running the terraform command eg. plan apply

### Remote-exec

```t
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```

This will execute commands on a machine which you target. You will need to provide credenitials such as ssh to get into the machine

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)