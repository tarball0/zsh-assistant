_ollama_api_call() {
  if ! curl -s http://localhost:11434/api/tags > /dev/null; then
    echo "Error: Ollama is not running."
    echo "Please start the Ollama service or run 'ollama serve' in another terminal."
    return 1
  fi

  local text="$1"
  jq -n --arg p "$text" \
    '{model: "gemma-linux", prompt: $p, stream: false, think: false}' | \
    curl -s -X POST http://localhost:11434/api/generate \
    -H "Content-Type: application/json" \
    -d @- | jq -r '.response'
}

_inference() {
  # removing leading and trailing whitespace
  local input="${BUFFER#"${BUFFER%%[![:space:]]*}"}"
  input="${input%"${input##*[![:space:]]}"}"

  [[ -z "$BUFFER" ]] && return

  zle -I
  #echo -n "thinking..."
  
  local response
  response=$(_ollama_api_call "$input")

  #echo -ne "\r\e[K"
  if [[ -n "$response" ]]; then
    echo -e "$response\n"
  else
    echo "error"
  fi
  BUFFER=""

  zle redisplay
}

zle -N zsh_assist_widget _inference
bindkey -r '^ '
bindkey '^ ' zsh_assist_widget
