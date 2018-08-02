FROM tarantool/tarantool:1.7

ENV CONF /opt/tarantool/conf.lua
ENV FG 0

WORKDIR /opt/tarantool

RUN set -x \
  && apk add --no-cache --virtual .build-deps \
     build-base \
     cmake \
     lua-dev \
     git


COPY ./.luarocks /root/.luarocks
COPY meta.yaml /opt/tarantool

RUN luarocks install tarantoolapp && tarantoolapp dep

COPY . /opt/tarantool

EXPOSE 12345

CMD ["tarantool", "/opt/tarantool/demo-app.lua"]