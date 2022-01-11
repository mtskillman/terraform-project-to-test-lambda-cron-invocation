<img src="time.jpg" alt="clock image" width="500"/>
<hr>
project to demonstrate lag time for AWS Lambda cron invocations:
<pre>{
  "time-actual": {
    "S": "2022-01-11T17:10:00Z"
  },
  "time-system": {
    "S": "2022-01-11T17:10:10Z"
  }
}</pre>
^ here we can see that it took 10 seconds for Lambda to start
<hr>
run `make bundle` before you do the `terraform apply`. 

this project is affected by bug: https://github.com/hashicorp/terraform-provider-aws/issues/12923


you can use this for workarounds to the bug: https://devops.stackexchange.com/questions/8409/how-to-forcibly-remove-the-resource-created-by-the-broken-module

(yes, you will maybe have to manually edit the terraform.tfstate and probably remove entries which represent the concurrency config)

<hr>

inspired by https://www.trek10.com/blog/lambda-cron/

images sourced from https://www.freeimages.com/
