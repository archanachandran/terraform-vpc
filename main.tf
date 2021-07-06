resource "aws_vpc" "app-east" {
  provider = aws.east
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "db-east" {
    provider = aws.east
    name = "${var.AWS_REGION_US_EAST}-vpc-db"
    cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "ec2-east" {
    provider = aws.east
    cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "app-west" {
  provider = aws.west
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "db-west" {
    provider = aws.west
    cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "ec2-west" {
    provider = aws.west
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "app-east-subnet-public" {
    vpc_id = "${aws_vpc.app-east.id}"
    cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "app-east-subnet-private" {
    vpc_id = "${aws_vpc.app-east.id}"
    cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "db-east-subnet-public" {
    vpc_id = "${aws_vpc.db-east.id}"
    cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "db-east-subnet-private" {
    vpc_id = "${aws_vpc.db-east.id}"
    cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "ec2-east-subnet-public" {
    vpc_id = "${aws_vpc.ec2-east.id}"
    cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "ec2-east-subnet-private" {
    vpc_id = "${aws_vpc.ec2-east.id}"
    cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "app-west-subnet-public" {
    vpc_id = "${aws_vpc.app-west.id}"
    cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "app-west-subnet-private" {
    vpc_id = "${aws_vpc.app-west.id}"
    cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "db-west-subnet-public" {
    vpc_id = "${aws_vpc.db-west.id}"
    cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "db-west-subnet-private" {
    vpc_id = "${aws_vpc.db-west.id}"
    cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "ec2-west-subnet-public" {
    vpc_id = "${aws_vpc.ec2-west.id}"
    cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "ec2-west-subnet-private" {
    vpc_id = "${aws_vpc.ec2-west.id}"
    cidr_block = "10.0.2.0/24"
}

resource "aws_internet_gateway" "app-east-igw" {
    vpc_id = "${aws_vpc.app-east.id}"
}

resource "aws_internet_gateway" "db-east-igw" {
    vpc_id = "${aws_vpc.db-east.id}"
}

resource "aws_internet_gateway" "ec2-east-igw" {
    vpc_id = "${aws_vpc.ec2-east.id}"
}

resource "aws_internet_gateway" "app-west-igw" {
    vpc_id = "${aws_vpc.app-west.id}"
}

resource "aws_internet_gateway" "db-west-igw" {
    vpc_id = "${aws_vpc.db-west.id}"
}

resource "aws_internet_gateway" "ec2-west-igw" {
    vpc_id = "${aws_vpc.ec2-west.id}"
}

resource "aws_route_table" "app-east-public-crt" {
    vpc_id = "${aws_vpc.app-east.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.app-east-igw.id}" 
    }
}

resource "aws_route_table" "db-east-public-crt" {
    vpc_id = "${aws_vpc.db-east.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.db-east-igw.id}" 
    }
}

resource "aws_route_table" "ec2-east-public-crt" {
    vpc_id = "${aws_vpc.ec2-east.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.ec2-east-igw.id}" 
    }
}

resource "aws_route_table" "app-west-public-crt" {
    vpc_id = "${aws_vpc.app-west.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.app-west-igw.id}" 
    }
}

resource "aws_route_table" "db-west-public-crt" {
    vpc_id = "${aws_vpc.db-west.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.db-west-igw.id}" 
    }
}

resource "aws_route_table" "ec2-west-public-crt" {
    vpc_id = "${aws_vpc.ec2-west.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.ec2-west-igw.id}" 
    }
}

resource "aws_route_table_association" "app-east-crta-public-subnet"{
    subnet_id = "${aws_subnet.app-east-subnet-public.id}"
    route_table_id = "${aws_route_table.app-east-public-crt.id}"
}

resource "aws_route_table_association" "db-east-crta-public-subnet"{
    subnet_id = "${aws_subnet.db-east-subnet-public.id}"
    route_table_id = "${aws_route_table.db-east-public-crt.id}"
}

resource "aws_route_table_association" "ec2-east-crta-public-subnet"{
    subnet_id = "${aws_subnet.ec2-east-subnet-public.id}"
    route_table_id = "${aws_route_table.ec2-east-public-crt.id}"
}

resource "aws_route_table_association" "app-west-crta-public-subnet"{
    subnet_id = "${aws_subnet.app-west-subnet-public.id}"
    route_table_id = "${aws_route_table.app-west-public-crt.id}"
}

resource "aws_route_table_association" "db-west-crta-public-subnet"{
    subnet_id = "${aws_subnet.db-west-subnet-public.id}"
    route_table_id = "${aws_route_table.db-west-public-crt.id}"
}

resource "aws_route_table_association" "ec2-west-crta-public-subnet"{
    subnet_id = "${aws_subnet.ec2-west-subnet-public.id}"
    route_table_id = "${aws_route_table.ec2-west-public-crt.id}"
}
