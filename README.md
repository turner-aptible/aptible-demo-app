# Aptible Deploy Demo App

This repo is meant to show you how to deploy a test application for Aptible to get you up and running in a few minutes.

## Requirements

- [Aptible Account](https://aptible.com)

- [Aptible CLI Installed and Logged In](https://deploy-docs.aptible.com/docs/cli)

- [Terraform Version > 0.13](https://learn.hashicorp.com/tutorials/terraform/install-cli)

- [Aptible Environment Set-up](https://deploy-docs.aptible.com/docs/environments)

## Instructions

1. Download this repo to your local machine.

2. `cd` into this repo.

```console
cd ~/aptible-demo-app
```

3. Initialize Terraform within the directory.

```console
terraform init
```

4. Create a `terraform.tfvars` file in the directory and update with name of the environment you'd like to use in [Aptible](https://aptible.com) and save. Example contents:

```hcl
aptible_environment = "change-me"
```

5. Run `terraform plan` to validate changes.

```console
terraform plan
```

6. Run `terraform apply` and deploy app.

```console
terraform apply
```

7. Copy the app endpoint address in the terminal and see the app website deployed.

    > _*NOTE:*_  If you are using a legacy system that doesn't support the Ed25519 algorithm, use:
    
    > ```shell
    > ssh-keygen -t rsa -b 4096 -C "you@example.com"
    > ```