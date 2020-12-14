# ComputeStacks Cluster on Linode

Create a `terraform.tfvars` file and adjust the settings appropriatly. Specifically, you will:

* Need to generate an [API Key](https://www.linode.com/docs/guides/api-key/)
* Choose the appropriate package for your linode
  * _NOTE:_ The packages set as the default in the `terraform.tfvars.sample` meet our minimum requirements. We do not recommend going below those, as that may prevent ComputeStacks from booting.
* Specify how many nodes you want (we recommend 1, 3, or 5). If you need more resources, consider increasing the plan size, or creating multiple availability zones.
* Choose your region

## Setup Terraform

Before proceeding, ensure you have [terraform installed](https://learn.hashicorp.com/tutorials/terraform/install-cli), and then run:

```bash
terraform init
```

## Running Terraform

```bash
terraform apply
```

## Complete Your Cluster

Once the process is completed, you will find an `inventory.yml` file in this directory. This will be filled in with the servers that were just created, as well as a few other things like new random passwords.

However, you will still need to update all the other variables, such as:
* License Key
* Domain Names
* Floating IP _(if applicable)_
* Your company / brand identification

### Floating IP

If you're only deploying a single node, you do not need a floating IP. This is only useful when you have 3 nodes and would like automatic failover of the load balancer. 

To add a floating IP, you will need to open a support ticket with Linode from within your cloud manager, and ask them to allocate an additional IP. For justification, you can explain to them that you need a shared IP for your new cluster, in order to enable high availability.

Once you have been allocated an additional IP, you will need to:

1. Enable [IP Sharing](https://www.linode.com/docs/guides/remote-access#configuring-ip-sharing) on that IP Address with all of your nodes. 
2. Note the IP Address and the Network (e.g. /24, /21) and update the `inventory.yml` file with your newly created address (and network!).
3. Disable [Network Helper](https://www.linode.com/docs/guides/network-helper/)

To complete the setup, please run our [Ansible Script](https://github.com/ComputeStacks/ansible-install) using the newly generated `inventory.yml` file.