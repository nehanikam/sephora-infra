# Infrastructure Setup
The following deps are required to run this setup:
- Terraform installed on this machine
- An AWS IAM configured (preferablly with will Admin access)
- AWS access id and secret for the above IAM user
- A linux machine
- an AMI (we are using Ubuntu for ap-south-1 region: [http://cloud-images.ubuntu.com/locator/ec2/](http://cloud-images.ubuntu.com/locator/ec2/) )
- ssh keys on your system inside your home folder (using ssh-keygen)

## Setup overview:
The following infra will be created
  - An AWS ec2 instance (t2.micro)
  - An AWS RDS PostgreSQL instance (t2.micro)
  - SGs for instance and RDS
  - VPC and two subnets (public + private)
  - IG and route table association for the above

## Running this configuration:
- Go to [vars.tf](https://github.com/nehanikam/sephora-infra/blob/master/infrastructure/vars.tf) and edit your ssh public and pvt id_rsa key paths
- If looking to change the AMI type then do that under the lookup 'AMI' and change the corresponding 'INSTANCE_USERNAME'
- create a 'terraform.tfvars' file in this directory and add your IAM user credentials to this file(this is added in .gitignore):
   > AWS_ACCESS_KEY="XXXXXXXXXXXXXXX"
    AWS_SECRET_KEY="XXXXXXXXXXXXXXXXXXXXXXXX"
- Initialize terraform:
    > $: terraform init
- Plan out the configuration and look out for errors (the db pwd is not mentioned in the repo and has to be passed from command line, enter one if asked on the cmd line):
    > $: terraform plan -out myfirst.plan
- SPin the infra:
    > $: terraform apply myfirst.plan

Once this completes, the end point of the rds and the instance should be displayed on the final lines. This code also provisions and install script on the ec2 instance and installs postgresql-client on the machine.

## Check if they are working:
Head over to terminal and ssh into your machine:
> $: ssh ubuntu@xx.xx.xx.xx

Login to your remote psql client:
> $ ubuntu@machine: psql -h sephoradb.xxxxx.rds.com sephoradb --username=root 

and enter the password provided during tf run.

## Next steps:
Ensure your application is configured with the above RDS endpoint URL and auth params.
Provision the infra with a config tool like ansible.