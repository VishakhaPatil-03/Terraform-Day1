provider "aws" {
    region = "ap-southeast-1"

}


terraform {
    backend "s3" {
        bucket = "terraform-state-management-pra"
        region = "ap-southeast-1"
        use_lockfile = true
        key = "terraform.tfstate"
        shared_credentials_files = ["/home/ubuntu/.aws/credentials"]
    }
}