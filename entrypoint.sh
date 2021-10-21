#! /usr/bin/env bash

set -e

parse_args() {
    local opts=""
    while (( "$#" )); do
        case "${1}" in
            -g|--no-global)
                opts="${opts} -g"
                shift
                ;;
            -u|--no-unused)
                opts="${opts} -u"
                shift
                ;;
            -r|--no-redefined)
                opts="${opts} -r"
                shift
                ;;
            -a|--no-unused-args)
                opts="${opts} -a"
                shift
                ;;
            -s|--no-unused-secondaries)
                opts="${opts} -s"
                shift
                ;;
            --no-self)
                opts="${opts} --no-self"
                shift
                ;;
            --std)
                opts="${opts} --std ${2}"
                shift
                ;;
            --globals)
                opts="${opts} --globals ${2}"
                shift
                ;;
            --read-globals)
                opts="${opts} --read-globals ${2}"
                shift
                ;;
            --new-globals)
                opts="${opts} --new-globals ${2}"
                shift
                ;;
            --new-read-globals)
                opts="${opts} --new-read-globals ${2}"
                shift
                ;;
            --not-globals)
                opts="${opts} --not-globals ${2}"
                shift
                ;;
            -c|--compat)
                opts="${opts} -c"
                shift
                ;;
            -d|--allow-defined)
                opts="${opts} -d"
                shift
                ;;
            -t|--allow-defined-top)
                opts="${opts} -t"
                shift
                ;;
            -m|--module)
                opts="${opts} -m"
                shift
                ;;
            --max-line-length)
                opts="${opts} --max-line-length ${2}"
                shift
                ;;
            --no-max-line-length)
                opts="${opts} -no-max-line-length"
                shift
                ;;
            --max-code-line-length)
                opts="${opts} --max-code-line-length ${2}"
                shift
                ;;
            --no-max-code-line-length)
                opts="${opts} --no-max-code-line-length"
                shift
                ;;
            --max-string-line-length)
                opts="${opts} --max-string-line-length ${2}"
                shift
                ;;
            --no-max-string-line-length)
                opts="${opts} --no-max-string-line-length"
                shift
                ;;
            --max-comment-line-length)
                opts="${opts} --max-comment-line-length ${2}"
                shift
                ;;
            --no-max-comment-line-length)
                opts="${opts} --no-max-comment-line-length"
                shift
                ;;
            --max-cyclomatic-complexity)
                opts="${opts} --max-cyclomatic-complexity ${2}"
                shift
                ;;
            --no-max-cyclomatic-complexity)
                opts="${opts} --no-max-cyclomatic-complexity"
                shift
                ;;
            -i|--ignore)
                opts="${opts} -i ${2}"
                shift
                ;;
            -e|--enable)
                opts="${opts} -e ${2}"
                shift
                ;;
            -o|--only)
                opts="${opts} -o ${2}"
                shift
                ;;
            --config)
                opts="${opts} --config ${2}"
                shift
                ;;
            --no-config)
                opts="${opts} --no-config"
                shift
                ;;
            --filename)
                opts="${opts} --filename ${2}"
                shift
                ;;
            --exclude-files)
                opts="${opts} --exclude-files ${2}"
                shift
                ;;
            --include-files)
                opts="${opts} --include-files ${2}"
                shift
                ;;
            -j|--jobs)
                opts="${opts} -j ${2}"
                shift
                ;;
            -q|--quiet)
                opts="${opts} -q"
                shift
                ;;
            -qq)
                opts="${opts} -qq"
                shift
                ;;
            -qqq)
                opts="${opts} -qqq"
                shift
                ;;
            --codes)
                opts="${opts} --codes"
                shift
                ;;
            --ranges)
                opts="${opts} --ranges"
                shift
                ;;
            -*)
                >&2 echo "ERROR: Unsupported flag for action: '${1}'"
                exit 1
                ;;
            *)
                # ignore all other args
                shift
                ;;
        esac
    done

    eval set -- "$opts"
    echo "${opts/ /}"
    return 0
}

luacheck_init() {
    : "${GITHUB_WORKSPACE?GITHUB_WORKSPACE has to be set. Did you use the actions/checkout action?}"
    pushd "${GITHUB_WORKSPACE}"

    local opts
    opts=$(parse_args ${@} || exit 1)

    # Enable recursive glob patterns, such as '**/*.lua'.
    shopt -s globstar
    luacheck ${opts} "${TARGETS}"
}

args=("${@}")

if [ "$0" = "${BASH_SOURCE[*]}" ] ; then
    >&2 echo -E "Running Luacheck Linter..."
    luacheck_init "${args[@]}"
fi
