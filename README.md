# Web application architecture on cloud
An architecture for web application with consideration of cloud security, high availability and scalability.

[View hosted application](http://kswong-stag-myelb-2123514043.us-east-1.elb.amazonaws.com/)

## Technology stack
1. Web framework: NodeJS - ExpressJS framework ([link to source code](https://github.com/kangsheng89/nodejs-mysql-crud))
2. Database: MySQL hosted on AWS RDS managed service
3. Deployment: 
- Terraform as Provision automation tool: Terraform is outstanding amongst provision tool thanks to its cross-cloud capability and state management. 
- Jenkins as CI/CD tool: A traditional way of doing CI/CD. With our current architecture, Jenkins machine sits inside the private subnet, it allows flexibility for reaching different services inside the private subnets, better ensuring the application security than CI/CD cloud service. 
4. Cloud: AWS (VPC, NLB, ASG, S3, EC2, RDS, etc.)

## Architecture


![architecture](https://user-images.githubusercontent.com/12370490/129519534-4acb66a7-eea8-42a2-bc82-14701e1d5708.png)

    
Explanation:
 
**1. AWS Cloud:**
The application is hosted on AWS.

**2. VPS:**
All the resources are resides inside a Virtual Private Cloud (VPC).

**3. Subnets:**
There are 4 subnets to ensure high availability.
- 2 public subnets
- 2 private subnets

**4. Web tier:**
- Web tier server is hosted on EC2 with the capability to scale using Auto-Scaling Group (ASG). Currently ASG increases/reduces the number of instances if CPU usage is over/less 50%.
- Web tier is also hosted on 2 private subnets for high availability.
- Regarding security group: inbound rules only allow port 22 for bastion server and port 80 for Load Balancer.

**5. DB tier:**
- DB tier is hosted inside 02 private subnets to ensure high availability.
- In the meantime, one DB will act as read replica to enhance DB performance.
- Regarding security group, inbound rules only allow port 3306 for web tier.

**6. Internet:**
- Internet Gateway to communicate with the public internet, we can increase the number of Internet Gateway for high availability
- NAT Gateway allows resources inside private subnets can trigger the communication with the public internet

**7. Load Balancer:**
Due to the requirement of using Layer 4 and Layer 7, Classic Load Balancer (CLB) is used.
Load balancer points to ASG for scalability.
Currently, the NodeJS - Express application only uses Layer 7, there is no need of Layer 4 yet, hence we can use Application Load Balancer (ALB) as well in this case.

**8. Bastion Server:**
In order to troubleshoot the servers, bastion server is playing the role of a bridge between work stations and servers. Security groups of bastion server should limit to the work stations' IPs only.

**9. Deployment Server:**
Jenkins deployment server is placed in the private subnet and expose port 8080 (Jenkins Console) to Bastion server. Developer can access Jenkins using bastion server.


## Instruction to launch this architecture:
   
### Launch the architecture:
Terraform is used to provide and manage the resources.
 
 ```bash
    terraform init
    terraform validate
    terraform plan -var-file "secrets.tfvars" 
    terraform apply -var-file "secrets.tfvars"  -auto-approve
```




