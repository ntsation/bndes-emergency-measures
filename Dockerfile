FROM public.ecr.aws/lambda/python:3.11

RUN yum update -y glib2 && \
    yum clean all

COPY requirements.txt  ./
RUN pip install --no-cache-dir --default-timeout=1000 --only-binary=:all: -r requirements.txt -t "/var/task" && \
    pip install --no-cache-dir --default-timeout=1000 --only-binary=:all: --force-reinstall --no-deps urllib3==2.6.2 -t "/var/task"

COPY src/ ./

CMD ["app.lambda_handler"]