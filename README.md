effected by bug: https://github.com/hashicorp/terraform-provider-aws/issues/12923


you can use this for workarounds: https://devops.stackexchange.com/questions/8409/how-to-forcibly-remove-the-resource-created-by-the-broken-module

(yes, you will maybe have to manually edit the terraform.tfstate and probably remove entries which represent the concurrency config)

