FROM python:3.6-alpine3.6 as devel

RUN apk add --no-cache \
  gcc \
  mariadb-dev \
  libc-dev \
  libldap \
  openldap-dev
RUN apk add --update --no-cache \
  gcc \
  linux-headers \
  make \
  musl-dev \
  python-dev \
  g++
RUN apk add --no-cache python3-dev

ENV PATH ${PATH}:/root/.local/bin
ENV SHELL /bin/sh

WORKDIR /app

# Install Python deps
RUN python3 -m ensurepip
RUN pip install --user pipenv
COPY Pipfile Pipfile.lock /app/
RUN pipenv run pip install pip
RUN pipenv install -d
RUN pipenv lock -r > requirements.txt

COPY . /app
# RUN pipenv run ./manage.py collectstatic --noinput

FROM python:3.6-alpine3.6
ENV PYTHONUNBUFFERED 1
RUN apk add --no-cache \
  gcc \
  mariadb-dev \
  libc-dev \
  libldap \
  openldap-dev
RUN python3 -m ensurepip

RUN apk add --update --no-cache \
  gcc \
  linux-headers \
  make \
  musl-dev \
  python-dev \
  g++
RUN apk add --no-cache python3-dev

WORKDIR /app
COPY --from=0 /app /app
COPY --from=0 /static /static
RUN cd /app && pip install -r requirements.txt
EXPOSE 8088
