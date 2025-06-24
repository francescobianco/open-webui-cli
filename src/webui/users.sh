

webui_users_list() {
  local webui_config
  local webui_token

  webui_config="$1"
  webui_token="$2"

  webui_curl_get "$webui_config" "$webui_token" "/api/v1/users/all"
}

