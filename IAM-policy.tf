resource "aws_iam_policy" "db_access" {
  name = "db_access"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "rds:*",
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile_with_db_access"
  role = aws_iam_role.instance_role.name
}

resource "aws_iam_role" "instance_role" {
  name = "role_with_db_access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Sid    = "",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "instance_role_attachment" {
  policy_arn = aws_iam_policy.db_access.arn
  role       = aws_iam_role.instance_role.name
}

