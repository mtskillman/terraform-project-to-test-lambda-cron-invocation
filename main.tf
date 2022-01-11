module "iam-resources" {
  source = "./modules/shared"

  providers = {
    aws = aws.us-east-1
  }
}

module "us-east-1-logic" {
  source = "./modules/regional"
  function_role_arn = module.iam-resources.lambda_function_role_arn

  providers = {
    aws = aws.us-east-1
  }
}

module "us-west-2-logic" {
  source = "./modules/regional"
  function_role_arn = module.iam-resources.lambda_function_role_arn

  providers = {
    aws = aws.us-west-2
  }
}

module "eu-west-1-logic" {
  source = "./modules/regional"
  function_role_arn = module.iam-resources.lambda_function_role_arn

  providers = {
    aws = aws.eu-west-1
  }
}

module "eu-central-1-logic" {
  source = "./modules/regional"
  function_role_arn = module.iam-resources.lambda_function_role_arn

  providers = {
    aws = aws.eu-central-1
  }
}

module "ap-northeast-1-logic" {
  source = "./modules/regional"
  function_role_arn = module.iam-resources.lambda_function_role_arn

  providers = {
    aws = aws.ap-northeast-1
  }
}
