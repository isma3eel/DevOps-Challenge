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

