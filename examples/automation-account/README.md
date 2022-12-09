# Module automation account usage example

## Quick start

To deploy an automation account :

1. Modify `main.tf` to add your Azure provider credentials, etc.
2. Modify `variables.tf` to customize resources.
3. Run `terraform init` (or `tfwrapper init` using Claranet's wrapper).
4. Run `terraform apply` (or `tfwrapper apply` using Claranet's wrapper).
5. Use the generated Automation Account
