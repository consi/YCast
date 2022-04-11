FROM python:3.9-alpine as base
FROM base as builder

RUN mkdir /src
COPY . /src

RUN mkdir /install
WORKDIR /install

RUN pip install --prefix=/install /src/
FROM base
COPY --from=builder /install /usr/local
RUN mkdir /config/
COPY --from=builder /src/examples/stations.yml.example /config/stations.yml

EXPOSE 80/tcp
ENTRYPOINT ["python","-m","ycast","-c","/config/stations.yml"]
