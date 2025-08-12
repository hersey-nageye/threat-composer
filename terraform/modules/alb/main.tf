# ALB - This module creates an Application Load Balancer (ALB) with security groups and target groups.

data "aws_caller_identity" "this" {}

resource "aws_s3_bucket" "lb_logs" {
  bucket = "${var.project_name}-alb-logs-${data.aws_caller_identity.this.account_id}"
}

resource "aws_s3_bucket_public_access_block" "lb_logs" {
  bucket                  = aws_s3_bucket.lb_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "lb_logs" {
  bucket = aws_s3_bucket.lb_logs.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lb_logs" {
  bucket = aws_s3_bucket.lb_logs.id
  rule {
    id     = "expire-old-logs"
    status = "Enabled"

    filter {}

    expiration {
      days = 90
    }
  }
}

# Recommended modern policy (no regional ELB account IDs needed)
resource "aws_s3_bucket_policy" "lb_logs" {
  bucket = aws_s3_bucket.lb_logs.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AWSLogDeliveryWrite",
        Effect    = "Allow",
        Principal = { Service = "logdelivery.elasticloadbalancing.amazonaws.com" },
        Action    = ["s3:PutObject"],
        Resource  = "${aws_s3_bucket.lb_logs.arn}/AWSLogs/${data.aws_caller_identity.this.account_id}/*"
      },
      {
        Sid       = "AWSLogDeliveryCheck",
        Effect    = "Allow",
        Principal = { Service = "logdelivery.elasticloadbalancing.amazonaws.com" },
        Action    = ["s3:GetBucketAcl", "s3:ListBucket"],
        Resource  = aws_s3_bucket.lb_logs.arn
      }
    ]
  })
}


# AWS Security Group for ALB with ingress and egress rules
resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-alb-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.alb_sg.id

  cidr_ipv4   = var.cidr_ipv4
  description = "Allow HTTP traffic"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-alb-http-rule"
  })
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.alb_sg.id

  cidr_ipv4   = var.cidr_ipv4
  description = "Allow HTTPS traffic"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-alb-https-rule"
  })
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_alb" {
  security_group_id = aws_security_group.alb_sg.id
  description       = "Allow all outbound traffic from ALB"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Create the Application Load Balancer and its target group
resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = true
  drop_invalid_header_fields = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    enabled = true
    prefix  = "alb"
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-alb"
  })
}

resource "aws_lb_target_group" "app" {
  name        = var.target_group_name
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-app-target-group"
  })
}

# Create ALB listeners for HTTP and HTTPS traffic
resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_lb_listener" "web_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
