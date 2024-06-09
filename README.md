# DevOps Challenge

This Project demonstrates the required and Extras tasks for the devops challenge

## Project Structure

```plaintext
├───Environment
│   ├───Dev
│   │   └───App
│   │       ├───terraform.tfvars
│   │       └───terragrunt.hcl
│   └───Prod
│       ├───App
│       │   ├───terraform.tfvars
│       │   └───terragrunt.hcl
│       └───Domain
│           ├───terragrunt.hcl
│           └───terraform.tfvars
│
└───Modules
    ├───Domain
    │   ├───main.tf
    │   ├───outputs.tf
    │   ├───provider.tf
    │   ├───terraform.tfvars
    │   └───variables.tf
    └───Server
        ├───main.tf
        ├───outputs.tf
        ├───provider.tf
        ├───terraform.tfvars
        └───variables.tf
```


## Steps Applied

1. **Created Custom Terraform Modules**: Developed two custom modules, `Servers` and `Domain`.

2. **Domain Module Initialization**: Implemented the `Domain` module with Terragrunt, performing the following tasks:
    - Created a public DNS Zone for the domain.
    - Set up the Load Balancer.
    - Generated an SSL certificate for the Load Balancer to enable HTTPS.

4. **Update Nameservers**: Updated the nameservers for the domain to AWS Nameservers.


5. **Server Module Deployment**: Deployed the `Server` module to accomplish the following:
    - Deployed two servers in each environment, running the Docker image on port 80: [hashicorp/http-echo](https://hub.docker.com/r/hashicorp/http-echo/) (the echo text is securely fetched from AWS Secrets Manager).
    - Added DNS A records for the generated machines within the domain zone.
    - Attached the instances to the Load Balancer.
