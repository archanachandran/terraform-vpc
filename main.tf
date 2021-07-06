resource "aws_vpc" "app" {
  provider = aws.east
  cidr_block = "10.0.0.0/16"
}

resource "aws-vpc" "db" {
    provider = aws.east
    name = "${var.AWS_REGION_US_EAST}-vpc-db"
    cidr_block = "10.0.0.0/16"
}

resource "aws-vpc" "ec2" {
    provider = aws.east
    cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "app" {
  provider = aws.west
  cidr_block = "10.0.0.0/16"
}

resource "aws-vpc" "db" {
    provider = aws.west
    cidr_block = "10.0.0.0/16"
}

resource "aws-vpc" "ec2" {
    provider = aws.west
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "app-subnet-public" {
    vpc_id = "${aws_vpc.app.id}"
    cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "app-subnet-private" {
    vpc_id = "${aws_vpc.app.id}"
    cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "db-subnet-public" {
    vpc_id = "${aws_vpc.db.id}"
    cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "db-subnet-private" {
    vpc_id = "${aws_vpc.db.id}"
    cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "ec2-subnet-public" {
    vpc_id = "${aws_vpc.ec2.id}"
    cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "ec2-subnet-private" {
    vpc_id = "${aws_vpc.ec2.id}"
    cidr_block = "10.0.2.0/24"
}

resource "aws_internet_gateway" "app-igw" {
    vpc_id = "${aws_vpc.app.id}"
}

resource "aws_internet_gateway" "db-igw" {
    vpc_id = "${aws_vpc.db.id}"
}

resource "aws_internet_gateway" "ec2-igw" {
    vpc_id = "${aws_vpc.ec2.id}"
}

resource "aws_route_table" "app-public-crt" {
    vpc_id = "${aws_vpc.app.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.app-igw.id}" 
    }
}

resource "aws_route_table" "db-public-crt" {
    vpc_id = "${aws_vpc.db.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.db-igw.id}" 
    }
}

resource "aws_route_table" "ec2-public-crt" {
    vpc_id = "${aws_vpc.ec2.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.ec2-igw.id}" 
    }
}

resource "aws_route_table_association" "app-crta-public-subnet"{
    subnet_id = "${aws_subnet.app-subnet-public.id}"
    route_table_id = "${aws_route_table.app-public-crt.id}"
}

resource "aws_route_table_association" "db-crta-public-subnet"{
    subnet_id = "${aws_subnet.db-subnet-public.id}"
    route_table_id = "${aws_route_table.db-public-crt.id}"
}

resource "aws_route_table_association" "ec2-crta-public-subnet"{
    subnet_id = "${aws_subnet.ec2-subnet-public.id}"
    route_table_id = "${aws_route_table.ec2-public-crt.id}"
}