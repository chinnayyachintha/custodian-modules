#--------------------------------------
# Cloud Custodian Lambda Execution Role
#---------------------------------------
resource "aws_iam_role" "cloudcustodian_lambda_role" {
  name = var.CloudCustodianLambdaRole

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.cloudcustodian_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#-----------------------------------------------
# Inline Policy – Lambda Remediation + SQS Mailer
#-----------------------------------------------
resource "aws_iam_role_policy" "lambda_remediation_policy" {
  name = var.remediation_policy_name
  role = aws_iam_role.cloudcustodian_lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowLambdaLogging"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:${data.aws_partition.current.partition}:logs:*:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/*"
      },
      {
        Sid    = "SecurityGroupRemediation"
        Effect = "Allow"
        Action = [
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:DescribeSecurityGroups",
          "iam:ListAccountAliases"
        ]
        Resource = "*"
      },
      {
        Sid    = "AllowSendMessageToMailerQueue"
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:GetQueueUrl"
        ]
        Resource = "arn:${data.aws_partition.current.partition}:sqs:${var.mailer_queue_region}:${var.mailer_queue_account_id}:${var.mailer_queue_name}"
      }
    ]
  })
}

#--------------------------------
# Cloud Custodian Deployment Role
#--------------------------------
resource "aws_iam_role" "cloudcustodian_deployment_role" {
  name = var.cloudcustodian_deployment_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = var.cloudcustodian_admin_role_arn
      }
      Action = "sts:AssumeRole"
    }]
  })
}

#-------------------------------------------------
# Inline Policy – Lambda & EventBridge Deployment
#-------------------------------------------------
resource "aws_iam_role_policy" "deployment_policy" {
  name = "AllowDeploymentOfCloudCustodianLambda"
  role = aws_iam_role.cloudcustodian_deployment_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "lambda:CreateFunction",
          "lambda:DeleteFunction",
          "lambda:UpdateFunctionCode",
          "lambda:UpdateFunctionConfiguration",
          "lambda:AddPermission",
          "lambda:GetFunction",
          "lambda:GetFunctionConfiguration",
          "lambda:GetPolicy",
          "lambda:TagResource"
        ]
        Resource = "arn:${data.aws_partition.current.partition}:lambda:*:${data.aws_caller_identity.current.account_id}:function:custodian-*"
      },
      {
        Effect   = "Allow"
        Action   = "lambda:ListFunctions"
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "events:DescribeRule",
          "events:PutRule",
          "events:DeleteRule",
          "events:PutTargets",
          "events:RemoveTargets",
          "events:EnableRule",
          "events:TagResource",
          "events:ListTargetsByRule"
        ]
        Resource = "arn:${data.aws_partition.current.partition}:events:*:${data.aws_caller_identity.current.account_id}:rule/custodian-*"
      },
      {
        Effect   = "Allow"
        Action   = "iam:PassRole"
        Resource = aws_iam_role.cloudcustodian_lambda_role.arn
      }
    ]
  })
}


