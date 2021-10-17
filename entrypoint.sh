#! /usr/bin/env sh

set -e

REPOSITORY="$(pwd)"

luacheck --config "${REPOSITORY}/.luacheckrc" "${REPOSITORY}"
