ARG VERSION=0.2.0

FROM louneskmt/python:3.9-slim-buster-with-lndgrpc-purerpc

ARG VERSION

WORKDIR /

RUN apt-get update \
&&  apt-get install -y git build-essential gcc make \
&&  git clone --branch $VERSION https://github.com/lnbits/lnbits.git 

WORKDIR /lnbits

ENV QUART_APP=lnbits.app:create_app()
ENV QUART_ENV=development
ENV QUART_DEBUG=true
ENV HOST=127.0.0.1
ENV PORT=5000

RUN cp -r -f /opt/venv ./venv \
&&  python3 -m venv venv \
&&  ./venv/bin/pip install --upgrade pip \
&&  ./venv/bin/pip install wheel setuptools \
&&  ./venv/bin/pip install -r requirements.txt

COPY entrypoint.sh /bin/entrypoint
RUN chmod +x /bin/entrypoint

EXPOSE 5000

ENTRYPOINT ["/bin/entrypoint"]
