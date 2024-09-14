
# Assume policy created for codebuild service
data "aws_iam_policy_document" "codebuild_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codebuild-role" {
  name ="${var.application}-codebuild-role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role_policy.json
  tags =   {
    application = var.application
    environment = var.environment
  }
  inline_policy {
    
  }
  managed_policy_arns = []
}
data "aws_iam_policy_document" "codebuild-role-policy" {
    statement {
      effect = "Allow"
      resources = ["*"]
      actions = ["s3:*"]
    }
}
resource "aws_iam_policy" "aws_codebuild_role_policy" {
    policy = data.aws_iam_policy_document.codebuild-role-policy.json
    name = "${var.application}-codebuild-role-policy-${var.environment}"
}
resource "aws_iam_role_policy_attachment" "aws_iam_attachment" {
    policy_arn = aws_iam_policy.aws_codebuild_role_policy.arn
    role = aws_iam_role.codebuild-role.name
}
# resource "aws_iam_policy" "codebuild-role-policy" {
#     name = var.application+"-codebuild-role-policy-"+var.environment
#     description ="codebuild customer policy to handle build phases"
#     policy = jsondecode(``)
# }

/* 
  Adding learning details 
  Assume role can be defined directly in assume_role_policy or use data resource to create through policy document
*/
