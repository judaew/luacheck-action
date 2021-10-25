FROM alpine:3.14.2

LABEL repository="http://github.com/judaew/luacheck-action"
LABEL homepage="http://github.com/judaew/luacheck-action"
LABEL maintainer="Vadim-Valdis Yudaev"

RUN apk add --no-cache bash luarocks luacheck
RUN sh -s luarocks install lanes

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
