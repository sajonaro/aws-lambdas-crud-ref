# aws-lambdas-crud-ref
very basic but complete reference implementation of CRUD app using : 
- AWS API gateway
- AWS lambda
- DynamoDB,
- [terraform](https://www.terraform.io/ )
- [localstack](https://www.localstack.cloud/)



## To run (locally)

STEP 1 : define & deploy infrastructure

- run localstack container via docker compose

```
docker compose up
```
- then manage terraform (also referenced as a service defined in the same docker-compose file) as follows:

```
docker compose -f  docker-compose.yml run --rm terraform-container init

docker compose -f  docker-compose.yml run --rm terraform-container fmt

docker compose -f  docker-compose.yml run --rm terraform-container validate

docker compose -f  docker-compose.yml run --rm terraform-container plan -var-file terraform.tfvars 

docker compose -f  docker-compose.yml run --rm terraform-container apply -var-file terraform.tfvars -auto-approve 

```

STEP 2 : run the application