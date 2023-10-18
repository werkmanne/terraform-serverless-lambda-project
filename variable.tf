# environmental viraibles

variable "region" {
    description = "region to create the resources"
    type        = string
}

variable "project_name" {
    description = "project name"
    type        = string
}

variable "environment" {
    description = "environment"
    type        = string
}


# vpc variables

variable "vpc_cidr" {
    description = "vpc cidr block"
    type        = string
}

variable "public_subnet_az1_cidr" {
    description = "public subnet az1 cidr block"
    type        = string
}

variable "public_subnet_az2_cidr" {
    description = "public subnet az2 cidr block"
    type        = string
}

variable "private_subnet_az1_cidr" {
    description = "private subnet az1 cidr block"
    type        = string
}

variable "private_subnet_az2_cidr" {
    description = "private subnet az2 cidr block"
    type        = string
}



# Security Group variables

variable "ssh_location" {
    description = "ip address location allowed to ssh"
    type        = string
}


#rds variables

variable "engine_type" {
    description = "engine type to run for the database"
    type        = string
}

variable "engine_type_version" {
    description = "engine type version to run for the database"
    type        = string
}

variable "multi_az_deployment" {
    description = "multi availabilty zone deployment"
    type        = bool
}

variable "database_cluster_name" {
    description = "multi availabilty zone deployment"
    type        = string
}

variable "master_username" {
    description = "master username of database cluster"
    type        = string
}

variable "master_password" {
    description = "master password of database cluster"
    type        = string
}

variable "initial_database_name" {
    description = "initial database name"
    type        = string
}

variable "instance_class_type" {
    description = "instance type name"
    type        = string
}