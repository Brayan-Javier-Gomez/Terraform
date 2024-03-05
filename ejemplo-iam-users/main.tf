provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "user1" {
  name = "user1"
}


resource "aws_iam_policy" "policy" {
  name = "ejemplo_plitica_IAM"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "s3:ListAllMyBuckets"
          ],
          "Effect" : "Allow",
          "Resource" : "*"
        }
      ]
    }
  )
}

resource "aws_iam_user_policy_attachment" "policy_attachment1" {
  user = aws_iam_user.user1.name
  policy_arn = aws_iam_policy.policy.arn
  
}