variable "project" {
  type    = string
  default = "ecs-rest-demo"
}
variable "region" {
  type    = string
  default = "eu-central-1"
}


variable "container_image" {
  type = string
}
variable "container_port" {
  type    = number
  default = 8080
}
variable "desired_count" {
  type    = number
  default = 1
}


variable "acm_certificate_arn" {
  type = string
}

variable "public_hostname" {
  type        = string
  default     = "api.demo.local"
  description = "Displayed hostname"
}

variable "db_name" {
  type    = string
  default = "appdb"
}
variable "db_username" {
  type    = string
  default = "appuser"
}

variable "allowed_client_cidrs" {
  type        = list(string)
  default     = ["75.2.60.0/24"]
  description = "Who can reach ALB:443"
}

variable "azs" {
  type    = list(string)
  default = ["eu-central-1a", "eu-central-1b"]
}

variable "health_check_path" {
  type    = string
  default = "/health"
}


variable "hosted_zone_id" {
  type        = string
  default     = ""
  description = "Route53 Hosted Zone"
}

variable "record_name" {
  type        = string
  default     = ""
  description = "DNS"
}

