terraform {
    source = "../../..//Modules/Server"

    extra_arguments "custom_vars" {
    commands = [
      "init",
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]
    required_var_files = ["terraform.tfvars"]
    }
}

# Cross Module Dependency to take the outputs of the Domain Module inside the Server Module

dependency "Domain" {
  config_path = "../Domain"
}

inputs = {
  lb_name = dependency.Domain.outputs.LB_NAME
  }