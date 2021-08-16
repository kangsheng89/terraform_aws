# terraform_aws
example on implemantation of Terraform for 3 tier AWS architecture

NodeJS-ExpressJS-MySQL Create-Read-Update-Delete (CRUD) application at https://github.com/kangsheng89/nodejs-mysql-crud

Example: http://kswong-stag-myelb-2123514043.us-east-1.elb.amazonaws.com/


![architecture](https://user-images.githubusercontent.com/12370490/129519534-4acb66a7-eea8-42a2-bc82-14701e1d5708.png)

Instruction to launce this architecture:
    
    terraform init
    terraform validate
    terraform plan -var-file "secrets.tfvars"  -auto-approve
    terraform apply -var-file "secrets.tfvars"  -auto-approve
    
    
 Explaination:
 
 The archichture is setup into 3 diff subnet:
 1. public subnet
 2. private subnet (apps)
 3. private subnet (db)




