FROM public.ecr.aws/lambda/python:3.11

# Update system packages including glib2 to fix CVE-2025-13601
RUN yum update -y glib2 && \
    yum clean all

COPY requirements.txt  ./
RUN pip install --no-cache-dir --default-timeout=1000 --only-binary=:all: -r requirements.txt -t "/var/task" && \
    # Force reinstall urllib3 to ensure the correct version is used
    pip install --no-cache-dir --default-timeout=1000 --only-binary=:all: --force-reinstall --no-deps urllib3==2.6.2 -t "/var/task" && \
    # Remove old urllib3 from system packages to avoid security scan issues
    rm -rf /var/lang/lib/python3.11/site-packages/urllib3*

COPY src/ ./

CMD ["app.lambda_handler"]