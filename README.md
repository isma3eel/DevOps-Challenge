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
    - Deployed two servers in each environment, running the Docker image on port 80: [hashicorp/http-echo](https://hub.docker.com/r/hashicorp/http-echo/)(the echo text is securely fetched from AWS Secrets Manager).
    - Added DNS A records for the generated machines within the domain zone.
    - Attached the instances to the Load Balancer.
    - Updaetd CNAME DNS Records for the Load Balancer generated certificiates in the DNS Zone.
    - Attached the Load Balancer Certificate to the load balancer

## Images

You can find images of the applied tasks under the `/Images` directory:

- `1-instances.PNG` : The Instaces that were created
- `2-secrets.PNG` : The generated secret for the output of the docker container
- `3-dns-records.PNG` : Updated DNS A Records in the domain zone for the Prod and Dev environmnets 
- `4-dev-http.PNG` : Accessing the Dev environment
- `5-prod-http.PNG` : Accessing the Prod environment
- `6-secure-dnsrecords.PNG` : Updating zone with the CNAME records of the load balancer certificates
- `7-https.PNG` : HTTPS access after certificate valiation