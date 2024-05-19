### What are we building here:
We build hello world php application and deploy as AWS Lambda via custom runtime using bref (https://bref.sh/) project 

### How can I deploy and run it ?

 - build and publish php container runtime with php application bundled inside
 
 ```
  ./publish-to-ecr.sh

 ```

 - update .tfvars file to include real values (secret_key, secret_key_id)
 
- use terraform (via docker compose)

```
docker compose  run --rm tf init

docker compose  run --rm tf fmt

docker compose  run --rm tf validate

docker compose  run --rm tf plan -var-file .tfvars 

docker compose  run --rm tf apply -var-file .tfvars -auto-approve 
```
 - use Func URL to access php-app


