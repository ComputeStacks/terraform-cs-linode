# ComputeStacks Cluster on Linode

Create a `terraform.tfvars` file and adjust the settings appropriately. Specifically, you will:

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

## Using Linode DNS Manager
If you choose to have terraform configure your domain in Linode's DNS manager:

1. Set `use_linode_ns` to `true`
2. Create the zone with Linode and take note of the domain ID in the URL.
3. Set `linode_zone_id` with the domain ID.

## Running Terraform

```bash
terraform apply
```

After terraform runs, you will see 2 newly created files under the `result/` directory.

1. `dns_settings.txt` | If you did not configure DNS to be automatically configured, you will need to manually apply these settings in your DNS manager.
2. `inventory.yml` | You will need this later when configuring Ansible.

**Note:** Once your nodes perform their initial boot sequence, and before running ansible: Disable the [Linode Network Helper](https://www.linode.com/docs/guides/network-helper/).

### Floating IP

If you're only deploying a single node, you do not need a floating IP. This is only useful when you have 3 or more nodes and would like automatic failover of the load balancer. 

To add a floating IP, you will need to open a support ticket with Linode from within your cloud manager, and ask them to allocate an additional IP. For justification, you can explain to them that you need a shared IP for your new cluster, in order to enable high availability.

Once you have been allocated an additional IP, you will need to:

1. Enable [IP Sharing](https://www.linode.com/docs/guides/remote-access#configuring-ip-sharing) on that IP Address with all of your nodes. 
2. Update your `inventory.yml` file with the new ip. 
3. Ensure the Linode Network Helper is disabled for the nodes.

To complete the setup, please run our [Ansible Script](https://github.com/ComputeStacks/ansible-install) using the newly generated `inventory.yml` file.
