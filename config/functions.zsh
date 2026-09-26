# dotzsh — user-oriented helper functions

# Pick a running container by name and stop it.
docker_kill() {
  local container
  container=$(docker ps --format '{{.Names}}' | fzf) || return
  [[ -n "$container" ]] && docker kill "$container"
}

# Pick a container (including stopped containers) and remove it.
docker_rm() {
  local container
  container=$(docker ps -a --format '{{.Names}}' | fzf) || return
  [[ -n "$container" ]] && docker rm "$container"
}

docker_killall() {
  local -a containers
  containers=("${(@f)$(docker ps -q)}")
  (( ${#containers} )) && docker kill "${containers[@]}"
}

gitwip() {
  git commit -m "WIP $(date)" "$@"
}

change_default_browser() {
  local selected
  selected=$(printf '%s\n' \
    brave-browser.desktop \
    google-chrome.desktop \
    microsoft-edge.desktop \
    firefox-esr.desktop | fzf) || return
  [[ -n "$selected" ]] || return
  xdg-settings set default-web-browser "$selected" &&
    print "Navegador predeterminado cambiado a: $selected"
}

generate_pass() {
  local length=${1:-16}
  < /dev/urandom tr -dc '_A-Z-a-z-0-9%+-"!&/()=*{}' | head -c "$length"
}

# Download audio from YouTube. Usage: ytaudio <URL> [filename template]
ytaudio() {
  (( $# >= 1 )) || { print -u2 'Uso: ytaudio <URL> [nombre_opcional]'; return 2; }
  local url="$1"
  local name="${2:-%(title).60s}"
  local dir="${YT_AUDIO_DIR:-$PWD}"
  mkdir -p "$dir" || return
  yt-dlp -f bestaudio --restrict-filenames -o "$dir/${name}.%(ext)s" "$url"
}
