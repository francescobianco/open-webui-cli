
##
# Call CURL POST request to GitLab API.
##
ci_curl_get() {
    #ci_curl_init

    local url="${GITLAB_PROJECTS_API_URL}/${CI_CURRENT_PROJECT_SLUG}/$1"

    #[[ -n "${debug}" ]] && [[ "$2" != "NODEBUG" ]] && echo " --> GET ${url}"

    curl -XGET -fsSL ${url} \
         -H "Content-Type: application/json" \
         -H "PRIVATE-TOKEN: ${GITLAB_PRIVATE_TOKEN}" 2> CI_CURL_ERROR_MESSAGE && true

    ci_curl_catch $?
}

##
# Call CURL POST request to GitLab API.
##
ci_curl_post() {
    #ci_curl_init

    local url

    url="${GITLAB_PROJECTS_API_URL}/${CI_CURRENT_PROJECT_SLUG}/$1"

    #if [[ -n "${debug}" ]]; then
    #    echo " --> POST ${url}"
    #    echo "     $2"
    #fi

    curl -XPOST -fsSL ${url} \
         -H "Content-Type: application/json" \
         -H "PRIVATE-TOKEN: ${GITLAB_PRIVATE_TOKEN}" \
         --data "$2" 2> CI_CURL_ERROR_MESSAGE && true

    ci_curl_catch $?
}

##
# Call CURL POST request to GitLab API.
##
ci_curl_put() {
    ci_curl_init

    local url="${GITLAB_PROJECTS_API_URL}/${CI_CURRENT_PROJECT_SLUG}/$1"

    if [[ -n "${debug}" ]]; then
        echo " --> PUT ${url}"
        echo "     $2"
    fi

    curl -XPUT -fsSL ${url} \
         -H "Content-Type: application/json" \
         -H "PRIVATE-TOKEN: ${GITLAB_PRIVATE_TOKEN}" \
         --data "$2" 2> CI_CURL_ERROR_MESSAGE && true

    ci_curl_catch $?
}

##
#
##
ci_curl_catch() {
    CI_CURL_EXIT_CODE=$1

    case "$1" in
        0)
            ci_curl_catch_success
            ;;
        22)
            ci_curl_catch_status $1
            ;;
        *)
            ci_curl_error
            ;;
    esac
}