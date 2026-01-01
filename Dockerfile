FROM public.ecr.aws/lambda/python:3.11

COPY requirements.txt  ./
RUN pip install --no-cache-dir --default-timeout=1000 --only-binary=:all: -r requirements.txt -t "/var/task"

COPY src/ ./

CMD ["app.lambda_handler"]
