# BNDES Emergency Measures - Production AWS Architecture

This project implements a production-ready system for fetching, processing, and storing BNDES emergency measures data on AWS using serverless technologies.

## 🚀 Features

- **Automated Data Pipeline**: Daily execution via CloudWatch Events
- **Serverless Architecture**: Lambda with Docker containers in ECR
- **Data Persistence**: Processed data stored in S3 as Parquet files
- **Comprehensive Monitoring**: CloudWatch logs, metrics, alarms, and dashboards
- **Alert System**: SNS notifications for failures and errors
- **Error Handling**: Dead Letter Queue (SQS) for failed executions
- **CI/CD Pipeline**: Automated testing, building, and deployment via GitHub Actions
- **Security**: KMS encryption, least-privilege IAM policies, versioned state
- **Infrastructure as Code**: Complete Terraform configuration

## 📊 Architecture Overview

```
┌─────────────┐
│  CloudWatch │
│   Events    │ (Daily trigger at 03:00 UTC)
└──────┬──────┘
       │
       ▼
┌─────────────┐     ┌──────────┐     ┌─────────┐
│   Lambda    │────▶│    S3    │     │   ECR   │
│  Function   │     │  Bucket  │     │   Repo  │
│  (Docker)   │     │(Parquet) │     │         │
└──────┬──────┘     └──────────┘     └─────────┘
       │
       ▼ (failures)
┌─────────────┐
│  SQS DLQ    │
└──────┬──────┘
       │
       ▼
┌─────────────┐     ┌─────────────┐
│ CloudWatch │────▶│    SNS      │
│  + Alarms  │     │ (Email)     │
└─────────────┘     └─────────────┘
```

## 📁 Project Structure

```
bndes-emergency-measures/
├── src/                        # Source code
│   ├── app.py                  # Lambda entrypoint with S3 upload
│   ├── fetch_data.py           # BNDES API data fetching
│   └── process_data.py         # Data processing and transformation
├── Dockerfile                  # Docker image for Lambda
├── requirements.txt            # Python dependencies
├── notebooks/
│   └── bndes_analysis.ipynb    # Jupyter notebook for analysis
├── terraform/                  # Infrastructure as Code
│   ├── main.tf                 # Main Terraform configuration (modules)
│   ├── providers.tf            # Provider and backend configuration
│   ├── variables.tf            # Input variables
│   ├── outputs.tf              # Output values
│   └── modules/                # Reusable modules
│       ├── ecr/                # ECR repository
│       ├── lambda/             # Lambda function with DLQ
│       ├── s3/                 # S3 bucket with KMS
│       ├── monitoring/         # CloudWatch + SNS
│       └── schedule/           # CloudWatch Events
├── tests/                      # Unit tests
├── scripts/                    # Utility scripts
│   └── setup-terraform-backend.sh
├── .github/
│   └── workflows/              # GitHub Actions pipelines
│       ├── 01-lint-check.yml
│       ├── 02-unit-tests.yml
│       ├── 03-security-scan.yml
│       ├── 04-docker-build-test.yml
│       ├── 05-terraform-plan.yml
│       └── 06-deploy.yml
└── README.md                   # This file
```

## 🚦 Quick Start

### Prerequisites
- AWS Account with appropriate permissions
- AWS CLI configured
- Docker installed
- Terraform >= 1.5.0
- Python 3.11
- GitHub account (for CI/CD)

### 1. Set Up Terraform Backend

```bash
chmod +x scripts/setup-terraform-backend.sh
./scripts/setup-terraform-backend.sh
```

### 2. Deploy Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 3. Verify Deployment

```bash
terraform output
```

## 🔧 Configuration

Key configuration variables in `terraform/main.tf`:

| Variable | Default | Description |
|-----------|---------|-------------|
| `aws_region` | `us-east-1` | AWS region |
| `project_name` | `bndes-emergency-measures` | Resource prefix |
| `lambda_timeout` | `900` | Lambda timeout (seconds) |
| `lambda_memory_size` | `1024` | Lambda memory (MB) |
| `alarm_email` | `""` | Email for alerts |
| `log_retention_days` | `30` | CloudWatch logs retention |

## 📈 Monitoring

### CloudWatch Dashboard
Access the monitoring dashboard:
```bash
terraform output dashboard_url
```

Or navigate to: `CloudWatch > Dashboards > bndes-emergency-measures-dashboard`

### View Logs
```bash
LOG_GROUP=$(terraform output log_group_name)
aws logs tail $LOG_GROUP --follow
```

### Check Alarms
```bash
aws cloudwatch describe-alarms --alarm-name-prefix bndes-emergency-measures
```

## 🔄 CI/CD Pipeline

The project includes a complete CI/CD pipeline using GitHub Actions, split into modular workflows:

1. **Lint Check**: Checks code style and quality.
2. **Unit Tests**: Runs pytest with coverage.
3. **Security Scan**: Scans code and dependencies for vulnerabilities.
4. **Docker Build**: Builds and tests the Docker image.
5. **Terraform Plan**: Generates an infrastructure plan (on pull requests).
6. **Deploy**: Applies infrastructure changes (on push to main).

## 💰 Cost Estimate

Monthly costs (us-east-1):
- Lambda: ~$0.20
- ECR: ~$0.10
- S3: ~$0.05
- CloudWatch Logs: ~$0.10
- SQS DLQ: ~$0.00
- SNS: ~$0.00 (1000 free emails/month)
- KMS: ~$0.03

**Total: ~$0.48/month**

## 🔒 Security Features

- ✅ KMS encryption for S3 data
- ✅ Least-privilege IAM policies
- ✅ S3 bucket blocks public access
- ✅ No hardcoded credentials
- ✅ Lambda environment variables encrypted
- ✅ ECR image scanning enabled
- ✅ Terraform state versioned and encrypted

## 🧪 Testing

Run tests locally:
```bash
export PYTHONPATH=$PYTHONPATH:$(pwd)/src
pytest tests/ -v
```

## 📊 Data Flow

1. **CloudWatch Events** triggers Lambda daily at 03:00 UTC
2. **Lambda** fetches data from BNDES API
3. **process_data.py** converts text-based numeric values
4. **S3** stores processed data as Parquet files with date partitioning
5. **CloudWatch** logs all operations and monitors metrics
6. **SNS** sends email alerts on failures

## 📖 Documentation

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## 🛠️ Troubleshooting

### Lambda Timeout
- Increase `lambda_timeout` in Terraform
- Check `lambda_memory_size`
- Review BNDES API response time

### S3 Permission Errors
- Verify IAM policies
- Check Lambda execution role

### Terraform State Lock
```bash
terraform force-unlock <LOCK_ID>
```

For more troubleshooting tips, see [DEPLOYMENT.md](DEPLOYMENT.md).

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

MIT License

## 📞 Support

For issues and questions:
- Open an issue on GitHub
- Check CloudWatch logs for Lambda errors
- Review Terraform state with `terraform show`

---

**Built with ❤️ using AWS Serverless technologies**