# Create VPC
# terraform aws create vpc
resource "aws_vpc" "paul-vpc" {
  cidr_block              = "10.0.0.0/16"
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "paul vpc"
  }
}

# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "paul-igw" {
  vpc_id    =  aws_vpc.paul-vpc.id

  tags      = {
    Name    = "paul igw"
  }
}


# Create Public Subnet 1
# terraform aws create subnet
resource "aws_subnet" "paul-public_subnet_1" {
  vpc_id                  =  aws_vpc.paul-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "paul public subnet az1"
  }
}

# Create Public Subnet 2
# terraform aws create subnet
resource "aws_subnet" "paul-public_subnet_2" {
  vpc_id                  = aws_vpc.paul-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "paul public subnet az2"
  }
}

# Create Route Table and Add Public Route
# terraform aws create route table
resource "aws_route_table" "paul-public-route-table" {
  vpc_id       =  aws_vpc.paul-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.paul-igw.id 
  }

  tags       = {
    Name     = "paul public route table"
  }
}

# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "paul-public-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.paul-public_subnet_1.id
  route_table_id      = aws_route_table.paul-public-route-table.id
}

# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-2-route-table-association" {
 # Associate Public Subnet 2 to "Public Route Table"
 subnet_id           =aws_subnet.paul-public_subnet_2.id
  route_table_id      = aws_route_table.paul-public-route-table.id

}


# Create Private Subnet 1
# terraform aws create subnet
resource "aws_subnet" "paul-private_subnet_1" {
  vpc_id                  =  aws_vpc.paul-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "paul private subnet az1"
  }
}


# Create Private Subnet 2
# terraform aws create subnet
resource "aws_subnet" "paul-private_subnet_2" {
  vpc_id                  = aws_vpc.paul-vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "paul private subnet az2"
  }
}


# Create Route Table and Add Privae Route
# terraform aws create route table
resource "aws_route_table" "paul-private-route-table" {
  vpc_id       =  aws_vpc.paul-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.paul-igw.id 
  }

  tags       = {
    Name     = "paul private route table"
  }
}


# Associate Private Subnet 1 to "Privte Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "paul-private-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.paul-private_subnet_1.id
  route_table_id      = aws_route_table.paul-private-route-table.id
}

# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-2-route-table-association" {
 # Associate Private Subnet 2 to "Public Route Table"
 subnet_id           =aws_subnet.paul-private_subnet_2.id
  route_table_id      = aws_route_table.paul-private-route-table.id

}














 