ARG VERSION=0.2.0

FROM python:3.9-alpine

ARG VERSION

WORKDIR /

RUN apk add --no-cache --update git alpine-sdk make \
&& git clone --branch $VERSION https://github.com/lnbits/lnbits.git 

WORKDIR /lnbits

ENV QUART_APP=lnbits.app:create_app()
ENV QUART_ENV=development
ENV QUART_DEBUG=true

RUN python3 -m venv venv \
&& ./venv/bin/pip install -r requirements.txt \
&& ./venv/bin/quart assets \
&& ./venv/bin/quart migrate

ENV HOST=127.0.0.1
ENV PORT=5000

CMD [ "./venv/bin/hypercorn", "-k", "trio", "--bind", "0.0.0.0:${PORT}", "'lnbits.app:create_app()'" ]
