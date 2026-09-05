module "vpc" {
    source = "./module/vpc"
    vpc_cidr = "10.0.0.0/16"
    public_subnet_cidr = "10.0.0.0/22"
    private_subnet_cidr =  "10.0.4.0/22"
    public_subnet_az = "ap-southeast-1a"
    private_subnet_az = "ap-southeast-1b"
    sg_name = "my-sg"
    http_port = 80
    ssh_port = 22
}

module "ec2"{
    source = "./module/ec2"
    ami = "ami-0532913178263be1"
    instance_type = "t3.micro"
    key_name = "kapishh"
    sg_id = module.vpc.vpc_id
    private_subnet_id = module.vpc.private_subnet_id
    public_subnet_id = module.vpc.public_subnet_id

}