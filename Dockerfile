FROM alpine:3.14.2

LABEL "repository"="http://github.com/judaew/luacheck-action"
LABEL "homepage"="http://github.com/judaew/luacheck-action"
LABEL "maintainer"="Vadim-Valdis Yudaev"

LABEL "com.github.actions.name"="luacheck"
LABEL "com.github.actions.description"="Run Luacheck Lint"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="gray-dark"

RUN apk add --no-cache luarocks luacheck
RUN sh -s luarocks install lanes

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
