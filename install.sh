#!/bin/bash

# Configuration
PLUGIN_NAME="zsh-assistant"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGIN_DEST="$ZSH_CUSTOM_DIR/plugins/$PLUGIN_NAME"

echo "Running installation for $PLUGIN_NAME..."

# 1. Dependency Checks
check_dep() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: $1 is not installed. Please install it to continue."
        exit 1
    fi
}

check_dep "ollama"
check_dep "jq"
check_dep "zsh"
check_dep "curl"

# 2. ZSH Custom Directory Check
if [ ! -d "$ZSH_CUSTOM_DIR" ]; then
    echo "Error: Could not find ZSH custom directory at $ZSH_CUSTOM_DIR"
    echo "Please ensure Oh My Zsh is installed."
    exit 1
fi

# 4. Handle Plugin Location
if [ "$PWD" != "$PLUGIN_DEST" ]; then
    echo "Copying plugin to $PLUGIN_DEST..."
    mkdir -p "$PLUGIN_DEST"
    cp -r ./* "$PLUGIN_DEST/"
    cd "$PLUGIN_DEST" || exit 1
fi

# 5. Ollama Setup
echo "Pulling gemma4:e2b..."
ollama pull gemma4:e2b

if [ -f "Modelfile" ]; then
    echo "Creating gemma-linux model..."
    ollama create gemma-linux -f ./Modelfile
else
    echo "Error: Modelfile not found in $(pwd). Model creation skipped."
    exit 1
fi

echo "-------------------------------------------------------"
echo "Installation successful."
echo "Add '$PLUGIN_NAME' to your plugins list in ~/.zshrc"
echo "Example: plugins=(git zsh-assistant)"
echo "-------------------------------------------------------"
