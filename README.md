# `zsh-assistant`
This is an oh-my-zsh plugin that gives short snappy responses to basic questions and terminal commands. If you ever forget how a command works, you can now just ask.

## Running
1. Ensure the dependancies are installed
    ```bash
    sudo pacman -S curl ollama jq
    ```
    or
    ```bash
    sudo apt install curl ollama jq
    ```
    check the ollama documentation for your distribution for specifics on running it on your gpu. installing ollama alone limits inference to cpu only.

2. Have ollama running by either enabling the systemd service or through `ollama serve`

3. Clone this repository into `$ZSH_CUSTOM/plugins` (by default `~/.oh-my-zsh/custom/plugins`)

    ```sh
    git clone https://github.com/tarball0/zsh-assistant ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-assistant
    ```
4. Add the plugin to the list of plugins for Oh My Zsh to load (inside `~/.zshrc`):

    ```sh
    plugins=( 
        # other plugins...
        zsh-assistant
    )
    ```

5. Run the install script `install.sh`

6. Start a new terminal session

## Usage
To use, simply type in anything you want to ask, and hit `Ctrl+Space`
