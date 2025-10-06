## 🔹 Overview
This Terraform project provisions a minimal AWS infrastructure consisting of:
- **VPC** with public and private subnets.  
- **Application Load Balancer (ALB)** exposing HTTPS (443), access restricted by IP CIDR (`allowed_client_cidrs`).  
- **ECS Fargate service** running a containerized app on port `8080`.  
- **RDS PostgreSQL** instance in private subnets.  
- **AWS Secrets Manager** for storing DB credentials and injecting them into the container.  
- **Route53 Alias record** pointing a custom domain to the ALB.  

---

## 🔹 Prerequisites (manual steps before `terraform apply`)

### 1. Build and push a Docker image to ECR
```bash
AWS_REGION=eu-central-1
REPO_NAME=demo-app

# 1) Create repository (once)
aws ecr create-repository --repository-name $REPO_NAME --region $AWS_REGION

# 2) Build the image (if using Mac M1/M2 add --platform=linux/amd64)
docker build -t $REPO_NAME:v1 .

# 3) Authenticate Docker to ECR
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
aws ecr get-login-password --region $AWS_REGION \
  | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# 4) Tag and push
ECR_URI=$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME
docker tag $REPO_NAME:v1 $ECR_URI:v1
docker push $ECR_URI:v1