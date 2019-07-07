# Overview
Creates an EKS cluster using terraform with below features:

* VPC with 3 subnets 
    * gateway
    * public/internal (only egress to internet)
    * private (no ingress/egress from/to internet)
* A secondary subnet for pubic/internal subnet to extend ip addresses
* Cluster Autoscaler configuration for IAM
* ALB with Route53 configuration (certificate needs to be pre-created)

This project is heavily inspired by:

* [Terraform AWS EKS Introduction](https://learn.hashicorp.com/terraform/aws/eks-intro) 
* [building-a-kubernetes-cluster-on-aws-eks-using-terraform](https://www.esentri.com/building-a-kubernetes-cluster-on-aws-eks-using-terraform/)


## Steps
1. Create a file with aws credentials:
```
[default]
aws_access_key_id = ACCESSKEYID
aws_secret_access_key = SECRET
```
2. Populate `variables.tfvars`
3. Check the plan 
```bash
terraform init
terraform plan -var-file=variables.tfvars
 ```
4. Apply if everything is okay (it takes approx 15mins to create the cluster)
```bash
terraform apply -var-file=variables.tfvars
```

5. After the cluster is created, use the kubeconfig from the output to connect to the cluster using kubectl
```bash
terraform output eks_kubeconfig
```
6. To route traffic from the ALB to the cluster, create a [traefik](https://traefik.io/) ingress controller service pointing to `nodePort: 3172`. [Example here]()
7. For cluster autoscaling create a [cluster-autoscaler]() deployment pointing to the autoscaling group created by terraform. [Example here]()
```yaml
...
command:
  - ./cluster-autoscaler
  - --v=4
  - --stderrthreshold=info
  - --cloud-provider=aws
  - --skip-nodes-with-local-storage=false
  - --nodes=MIN_NUMBER_OF_NODES:MAX_NUMBER_OF_NODES:ASG_CREATED_BY_TERRAFORM
...
```
