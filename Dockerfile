FROM alpine:edge

RUN apk add --no-cache crystal shards openssl openssl-dev musl-dev libc6-compat zlib-dev sqlite-dev
RUN crystal -v >&2
COPY . /opt/app/
RUN cd /opt/app && \
	shards
ENV KEMAL_ENV test


RUN  cd /opt/app/ && crystal spec

ENV KEMAL_ENV production

RUN cd /opt/app/ && crystal build --mcpu $(gcc -march=native -Q --help=target|grep march|awk '{print $2}'|head -n 1) --release src/clinl-website.cr

CMD /opt/app/clinl-website