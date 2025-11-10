# 🚀 Terraform Nginx Web Server on AWS

[![Terraform](https://img.shields.io/badge/Terraform-v1.0+-623CE4?style=flat&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?style=flat&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Nginx](https://img.shields.io/badge/Nginx-Web%20Server-009639?style=flat&logo=nginx&logoColor=white)](https://nginx.org/)

A complete Infrastructure as Code (IaC) project that automates the deployment of an Nginx web server on AWS using Terraform. This project demonstrates cloud infrastructure provisioning, networking configuration, and security best practices.

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Project Structure](#-project-structure)
- [Infrastructure Components](#-infrastructure-components)
- [Getting Started](#-getting-started)
- [Usage](#-usage)
- [Outputs](#-outputs)
- [Security Considerations](#-security-considerations)
- [Cleanup](#-cleanup)
- [Troubleshooting](#-troubleshooting)
- [Author](#-author)

---

## 🎯 Overview

This project provisions a fully functional AWS infrastructure to host an Nginx web server. It creates a custom VPC, configures networking components, sets up security groups, and launches an EC2 instance with Nginx automatically installed and configured.

**Use Cases:**
- Learning Terraform and AWS infrastructure automation
- Setting up a quick web server for testing or development
- Understanding AWS networking concepts (VPC, Subnets, Internet Gateway, Route Tables)
- Demonstrating DevOps practices with Infrastructure as Code

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────┐
│                  AWS Cloud                      │
│                                                 │
│  ┌─────────────────────────────────────────┐   │
│  │         VPC (10.0.0.0/16)               │   │
│  │                                         │   │
│  │  ┌──────────────────────────────────┐  │   │
│  │  │   Public Subnet (10.0.1.0/24)    │  │   │
│  │  │                                  │  │   │
│  │  │  ┌────────────────────────┐     │  │   │
│  │  │  │  EC2 Instance          │     │  │   │
│  │  │  │  - t3.large            │     │  │   │
│  │  │  │  - Amazon Linux 2023   │     │  │   │
│  │  │  │  - Nginx Web Server    │     │  │   │
│  │  │  │  - Public IP           │     │  │   │
│  │  │  └────────────────────────┘     │  │   │
│  │  │                                  │  │   │
│  │  └──────────────────────────────────┘  │   │
│  │                                         │   │
│  │  ┌──────────────────────────────────┐  │   │
│  │  │  Private Subnet (10.0.2.0/24)    │  │   │
│  │  │  (Reserved for future use)       │  │   │
│  │  └──────────────────────────────────┘  │   │
│  │                                         │   │
│  │  Internet Gateway                       │   │
│  │  Route Table (Public Routes)            │   │
│  │  Security Group (HTTP Port 80)          │   │
│  └─────────────────────────────────────────┘   │
└─────────────────────────────────────────────────┘
```

---

## ✨ Features

- **✅ Automated Infrastructure Deployment** - One-command deployment of entire infrastructure
- **✅ Custom VPC Setup** - Isolated network environment with public and private subnets
- **✅ Internet Gateway Configuration** - Enables internet connectivity for public resources
- **✅ Route Table Management** - Automatic routing configuration for public subnet
- **✅ Security Group Rules** - HTTP (port 80) access from anywhere, unrestricted egress
- **✅ EC2 Instance Provisioning** - Launches t3.large instance with Amazon Linux 2023
- **✅ Automated Nginx Installation** - User data script installs and starts Nginx automatically
- **✅ Public IP Assignment** - Automatic public IP for web server access
- **✅ Infrastructure Outputs** - Displays web server URL and public IP after deployment

---

## 📦 Prerequisites

Before you begin, ensure you have the following installed and configured:

### Required Software
- **Terraform** (v1.0 or later) - [Download](https://www.terraform.io/downloads)
- **AWS CLI** (v2.0 or later) - [Download](https://aws.amazon.com/cli/)
- **Git** - [Download](https://git-scm.com/downloads)

### AWS Account Requirements
- Active AWS account with appropriate permissions
- IAM user with programmatic access (Access Key ID and Secret Access Key)
- Permissions required:
  - EC2 (Full Access)
  - VPC (Full Access)
  - Security Groups (Create/Modify)

### AWS CLI Configuration
Configure your AWS credentials:
```bash
aws configure
```
Enter your:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g., `us-east-1`)
- Output format (e.g., `json`)

---

## 📁 Project Structure

```
Terraform-Nginx-Webserver/
│
├── ec2.tf                    # EC2 instance configuration with user data script
├── vpc.tf                    # VPC, subnets, internet gateway, and route tables
├── security-groups.tf        # Security group rules for Nginx server
├── providers.tf              # AWS provider configuration
├── main.tf                   # Terraform version and provider requirements
├── output.tf                 # Output values (public IP, web URL)
├── .gitignore                # Git ignore file for Terraform artifacts
└── README.md                 # Project documentation (this file)
```

### File Descriptions

| File | Purpose |
|------|---------|
| `ec2.tf` | Defines the EC2 instance resource, AMI, instance type, and user data script for Nginx installation |
| `vpc.tf` | Creates VPC, public/private subnets, internet gateway, route table, and associations |
| `security-groups.tf` | Configures security group with ingress (HTTP) and egress rules |
| `providers.tf` | Specifies AWS as the provider and sets the region |
| `main.tf` | Declares Terraform version and required providers |
| `output.tf` | Defines output variables to display after deployment |
| `.gitignore` | Excludes Terraform state files and provider binaries from version control |

---

## 🛠️ Infrastructure Components

### 1. **VPC (Virtual Private Cloud)**
- **CIDR Block:** `10.0.0.0/16`
- **Purpose:** Provides isolated network environment for resources
- **Name:** `my-vpc`

### 2. **Subnets**
- **Public Subnet:** `10.0.1.0/24` - Hosts the EC2 instance with internet access
- **Private Subnet:** `10.0.2.0/24` - Reserved for future use (databases, internal services)

### 3. **Internet Gateway**
- **Name:** `my-igw`
- **Purpose:** Allows communication between VPC and the internet

### 4. **Route Table**
- **Name:** `public-rt`
- **Route:** `0.0.0.0/0` → Internet Gateway
- **Association:** Linked to public subnet for internet routing

### 5. **Security Group**
- **Name:** `nginx-sg`
- **Inbound Rules:**
  - Protocol: TCP
  - Port: 80 (HTTP)
  - Source: `0.0.0.0/0` (public access)
- **Outbound Rules:**
  - All traffic allowed (for package installation and updates)

### 6. **EC2 Instance**
- **AMI:** `ami-0157af9aea2eef346` (Amazon Linux 2023)
- **Instance Type:** `t3.large`
- **Storage:** Default EBS volume
- **User Data:** Bash script to install and start Nginx
- **Public IP:** Automatically assigned
- **Name:** `nginx_server`

---

## 🚀 Getting Started

### Step 1: Clone the Repository
```bash
git clone https://github.com/SaikiranAsamwar/Terraform-Nginx-Webserver.git
cd Terraform-Nginx-Webserver
```

### Step 2: Initialize Terraform
Download required providers and modules:
```bash
terraform init
```

### Step 3: Review the Execution Plan
Preview the infrastructure changes:
```bash
terraform plan
```

### Step 4: Deploy the Infrastructure
Apply the configuration and create resources:
```bash
terraform apply
```
Type `yes` when prompted to confirm.

### Step 5: Access Your Web Server
After deployment completes, Terraform will display the web server URL. Open it in your browser:
```
Webserver-URL = http://<PUBLIC_IP>
```

---

## 💻 Usage

### Basic Commands

```bash
# Initialize Terraform (first time only)
terraform init

# Validate configuration syntax
terraform validate

# Format Terraform files
terraform fmt

# Preview changes
terraform plan

# Apply changes (with auto-approval)
terraform apply --auto-approve

# View current infrastructure state
terraform show

# List all resources managed by Terraform
terraform state list

# Destroy all resources
terraform destroy
```

### Modifying the Configuration

**Change Instance Type:**
Edit `ec2.tf`:
```hcl
instance_type = "t2.micro"  # Change from t3.large
```

**Change AWS Region:**
Edit `providers.tf`:
```hcl
provider "aws" {
  region = "us-west-2"  # Change from us-east-1
}
```

**Update AMI:**
Find the latest AMI ID for your region and update `ec2.tf`:
```bash
aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=al2023-ami-*" \
  --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' \
  --output text
```

---

## 📤 Outputs

After successful deployment, Terraform displays:

```
Outputs:

Webserver-URL = "http://54.123.45.67"
instanc_public_ip = "54.123.45.67"
```

**Output Variables:**
- `Webserver-URL` - Direct link to access the Nginx web server
- `instanc_public_ip` - Public IP address of the EC2 instance

You can retrieve outputs anytime:
```bash
terraform output
```

---

## 🔒 Security Considerations

### Current Configuration
⚠️ **This setup is designed for testing and learning purposes.**

**Security Limitations:**
- HTTP only (no HTTPS/TLS encryption)
- Port 80 open to `0.0.0.0/0` (entire internet)
- No SSH key pair configured (no direct instance access)
- Default security group rules

### Production Recommendations

For production deployments, consider:

1. **Enable HTTPS:**
   - Use AWS Certificate Manager (ACM) for SSL/TLS certificates
   - Configure Nginx with SSL
   - Add port 443 to security group

2. **Restrict Access:**
   ```hcl
   cidr_blocks = ["YOUR_IP_ADDRESS/32"]  # Replace with your IP
   ```

3. **Add SSH Access:**
   - Create an EC2 key pair
   - Add SSH (port 22) to security group
   - Restrict SSH to specific IPs

4. **Enable Logging:**
   - Configure VPC Flow Logs
   - Enable CloudWatch logging for EC2
   - Set up CloudTrail for API logging

5. **Use Terraform Backend:**
   ```hcl
   terraform {
     backend "s3" {
       bucket = "my-terraform-state"
       key    = "nginx-webserver/terraform.tfstate"
       region = "us-east-1"
     }
   }
   ```

6. **Implement IAM Roles:**
   - Use IAM instance profiles instead of hardcoded credentials
   - Follow principle of least privilege

---

## 🧹 Cleanup

To avoid AWS charges, destroy all resources when done:

```bash
# Review what will be destroyed
terraform plan -destroy

# Destroy all resources
terraform destroy

# Auto-approve destruction (use with caution)
terraform destroy --auto-approve
```

**Cost Considerations:**
- t3.large instance: ~$0.0832/hour (~$60/month if running 24/7)
- Data transfer: First 1 GB/month free, then $0.09/GB
- VPC components: Free tier eligible

---

## 🐛 Troubleshooting

### Issue: `terraform apply` fails with authentication error
**Solution:** Verify AWS credentials are configured correctly:
```bash
aws sts get-caller-identity
```

### Issue: AMI not found in your region
**Error:** `InvalidAMIID.NotFound`

**Solution:** The AMI ID is region-specific. Find the correct AMI for your region:
```bash
aws ec2 describe-images \
  --region your-region \
  --owners amazon \
  --filters "Name=name,Values=al2023-ami-*" \
  --query 'Images[0].ImageId' \
  --output text
```
Update the AMI in `ec2.tf`.

### Issue: Nginx not starting
**Solution:** Check user data execution:
```bash
# SSH into instance (if key pair configured)
sudo systemctl status nginx
sudo journalctl -u nginx
```

### Issue: Can't access web server
**Checklist:**
1. ✅ EC2 instance is running
2. ✅ Security group allows port 80 from your IP
3. ✅ Public IP is assigned
4. ✅ Route table is properly configured
5. ✅ Nginx service is running

### Issue: State file conflicts
**Solution:** 
```bash
# Remove lock
terraform force-unlock <LOCK_ID>

# If state is corrupted, restore from backup
cp terraform.tfstate.backup terraform.tfstate
```

### Issue: Resource already exists
**Error:** `AlreadyExists`

**Solution:** Import existing resource or destroy manually:
```bash
# Import existing VPC
terraform import aws_vpc.my-vpc vpc-xxxxx

# Or destroy via AWS Console/CLI
aws ec2 delete-vpc --vpc-id vpc-xxxxx
```

---

## 📚 Learning Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS VPC User Guide](https://docs.aws.amazon.com/vpc/)
- [AWS EC2 User Guide](https://docs.aws.amazon.com/ec2/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

---

## 🔄 Future Enhancements

Potential improvements for this project:

- [ ] Add Auto Scaling Group for high availability
- [ ] Implement Application Load Balancer
- [ ] Configure HTTPS with ACM certificate
- [ ] Add RDS database in private subnet
- [ ] Implement multi-AZ deployment
- [ ] Add CloudWatch monitoring and alarms
- [ ] Create Terraform modules for reusability
- [ ] Add CI/CD pipeline with GitHub Actions
- [ ] Implement backup and disaster recovery
- [ ] Add AWS WAF for web application firewall

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 👨‍💻 Author

**Saikiran Rajesh Asamwar**  
Full Stack MERN Developer | Certified AWS Cloud Engineer | Aspiring DevOps Engineer

- 🌐 GitHub: [@SaikiranAsamwar](https://github.com/SaikiranAsamwar)
- 💼 LinkedIn: [Saikiran Asamwar](https://www.linkedin.com/in/saikiran-asamwar/)
- 📧 Email: saikiranasamwar@gmail.com

---

## 🙏 Acknowledgments

- HashiCorp for Terraform
- AWS for comprehensive cloud services
- Nginx open-source community
- DevOps community for best practices and guidance

---

## ⭐ Show Your Support

If you found this project helpful, please give it a ⭐️ on GitHub!

---

**Made with ❤️ by Saikiran Asamwar**