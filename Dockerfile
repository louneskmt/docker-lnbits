ARG VERSION=0.2.0

FROM python:3.9-slim-buster

ARG VERSION

WORKDIR /lnbits

ENV QUART_APP=lnbits.app:create_app()
ENV QUART_ENV=development
ENV QUART_DEBUG=true
ENV HOST=0.0.0.0
ENV PORT=5000

RUN apt-get update \
&&  apt-get install -y build-essential \
&&  curl -L https://github.com/lnbits/lnbits/archive/$VERSION.tar.gz | tar -xz --strip-components=1 \
&&  python3 -m venv venv \
&&  ./venv/bin/pip install --upgrade pip \
&&  ./venv/bin/pip install wheel setuptools \
&&  ./venv/bin/pip install -r requirements.txt \
&&  ./venv/bin/pip install purerpc lndgrpc

COPY entrypoint.sh /bin/entrypoint
RUN chmod +x /bin/entrypoint

EXPOSE ${PORT}

ENTRYPOINT ["/bin/entrypoint"]
