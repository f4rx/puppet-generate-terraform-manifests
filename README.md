# Генерация терраформ-манифестов через Puppet для двух окружений


```bash
docker run -ti \
    -v $(pwd)/terraform/puppet/:/tf \
    -v $(pwd)/terraform/prod/:/tf_mainfests \
    -e FACTER_env=prod \
    puppet/puppet-agent:6.11.1 \
    apply --modulepath=/tf/ /tf/main.pp --test


TF_DATA_DIR=terraform/prod/.terraform terraform init terraform/prod
TF_DATA_DIR=terraform/prod/.terraform terraform apply -var-file="terraform/prod/secrets.tfvars"  terraform/prod
```

```bash
docker run -ti \
    -v $(pwd)/terraform/puppet/:/tf \
    -v $(pwd)/terraform/stage/:/tf_mainfests \
    -e FACTER_env=stage \
    puppet/puppet-agent:6.11.1 \
    apply --modulepath=/tf/ /tf/main.pp --test


TF_DATA_DIR=terraform/stage/.terraform terraform init terraform/stage
TF_DATA_DIR=terraform/stage/.terraform terraform apply -var-file="terraform/prod/secrets.tfvars"  terraform/stage
```
