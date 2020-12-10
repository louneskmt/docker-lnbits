ARG VERSION=0.2.0

FROM python:3.9-alpine

ARG VERSION

WORKDIR /

RUN apk add --no-cache --update git linux-headers alpine-sdk make \
&& git clone --branch $VERSION https://github.com/lnbits/lnbits.git 

WORKDIR /lnbits

ENV QUART_APP=lnbits.app:create_app()
ENV QUART_ENV=development
ENV QUART_DEBUG=true
ENV HOST=127.0.0.1
ENV PORT=5000

RUN python3 -m venv venv \
&& ./venv/bin/pip install wheel\
&& ./venv/bin/pip install -r requirements.txt \
&& ./venv/bin/pip install lndgrpc purerpc

COPY entrypoint.sh /bin/entrypoint
RUN chmod +x /bin/entrypoint

EXPOSE 5000

ENTRYPOINT ["/bin/entrypoint"]
