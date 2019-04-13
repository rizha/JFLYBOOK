FROM python:3.7-alpine

ENV PYTHONBUFFERED 1
ENV C_FORCE_ROOT true
STOPSIGNAL SIGTERM

RUN apk add --virtual build-deps gcc python3-dev musl-dev zeromq-dev

WORKDIR /app

RUN pip install -U pip --no-cache-dir
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

EXPOSE 8888

CMD jupyter notebook --no-browser --port 8888 --ip 0.0.0.0 --allow-root