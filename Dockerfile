FROM alpine:3.18.2 as build

ENV LUA_VERSION 5.4.4
ENV LUAROCKS_VERSION 3.9.2

RUN apk add --no-cache libc-dev readline readline-dev gcc make wget

# install lua
RUN cd /tmp \
    && wget https://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz \
    && tar zxf lua-${LUA_VERSION}.tar.gz \
    && cd lua-${LUA_VERSION} \
    && make linux install

# install luarocks
RUN cd /tmp \
    && wget https://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz \
    && tar zxf luarocks-${LUAROCKS_VERSION}.tar.gz \
    && cd luarocks-${LUAROCKS_VERSION} \
    && ./configure \
    && make build \
    && make install

RUN luarocks install luacheck

FROM alpine:3.18.2 as prod

LABEL repository="http://github.com/judaew/luacheck-action"
LABEL homepage="http://github.com/judaew/luacheck-action"
LABEL maintainer="Vadym-Valdis Yudaiev"

COPY --from=build /usr/local /usr/local
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
