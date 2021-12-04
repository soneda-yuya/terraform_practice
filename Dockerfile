FROM hashicorp/terraform:1.0.11

RUN apk update && apk upgrade && apk add --update git bash openssh openssl-dev build-base libffi-dev curl unzip sudo alpine-sdk && apk add --no-cache python3 python3-dev && python3 --version

RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python3

RUN pip install cmake
RUN pip install dlib

RUN python3 -mpip install https://github.com/boto/botocore/archive/v2.tar.gz
RUN python3 -mpip install https://github.com/aws/aws-cli/archive/v2.tar.gz

WORKDIR /terraform