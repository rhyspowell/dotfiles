# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change the frequency the auto-updater is run (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line to set how old an update must be before it's applied, manually or via the auto-updater (in days).
# zstyle ':omz:update' cooldown 10

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git oc)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Directory for all-things ZSH config
zsh_dir=${${ZDOTDIR}:-$HOME/.config/zsh}
utils_dir="${XDG_CONFIG_HOME}/utils"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Import utility functions (if present)
# Helper function to safely source files
function _safe_source() {
  [[ -f "$1" ]] && source "$1"
}

if [[ -d $utils_dir ]]; then
  _safe_source "${utils_dir}/transfer.sh"
  _safe_source "${utils_dir}/matrix.sh"
  _safe_source "${utils_dir}/hr.sh"
  _safe_source "${utils_dir}/web-search.sh"
  _safe_source "${utils_dir}/am-i-online.sh"
  _safe_source "${utils_dir}/welcome-banner.sh"
  _safe_source "${utils_dir}/color-map.sh"
fi

# MacOS-specific services
if [ "$(uname -s)" = "Darwin" ]; then
  # Add Brew to path, if it's installed
  if [[ -d /opt/homebrew/bin ]]; then
    export PATH=/opt/homebrew/bin:$PATH
  fi

  # If using iTerm, import the shell integration if availible
  if [[ -f "${XDG_CONFIG_HOME}/zsh/.iterm2_shell_integration.zsh" ]]; then
    source "${XDG_CONFIG_HOME}/zsh/.iterm2_shell_integration.zsh"
  fi

  # Append the Android SDK locations to path
  if [[ -d "${HOME}/Library/Android/" ]]; then
    export PATH="${HOME}/Library/Android/sdk/emulator:${PATH}"
    export ANDROID_HOME="${HOME}/Library/Android/sdk"
    export ANDROID_SDK_ROOT="${HOME}/Library/Android/sdk"
    export ANDROID_AVD_HOME="${ANDROID_SDK_ROOT}/tools/emulator"
    export NODE_BINARY="/usr/local/bin/node"
  fi
fi


# Source all ZSH config files (if present)
if [[ -d $zsh_dir ]]; then
  # Import alias files
  _safe_source "${zsh_dir}/aliases/general.zsh"
  _safe_source "${zsh_dir}/aliases/git.zsh"
  _safe_source "${zsh_dir}/aliases/node-js.zsh"
  _safe_source "${zsh_dir}/aliases/rust.zsh"
  _safe_source "${zsh_dir}/aliases/flutter.zsh"
  _safe_source "${zsh_dir}/aliases/tmux.zsh"
  _safe_source "${zsh_dir}/aliases/alias-tips.zsh"

  # Setup Antigen, and import plugins
  _safe_source "${zsh_dir}/helpers/setup-antigen.zsh"
  _safe_source "${zsh_dir}/helpers/import-plugins.zsh"
  _safe_source "${zsh_dir}/helpers/misc-stuff.zsh"

  # Configure ZSH stuff
  _safe_source "${zsh_dir}/lib/colors.zsh"
  _safe_source "${zsh_dir}/lib/cursor.zsh"
  _safe_source "${zsh_dir}/lib/history.zsh"
  _safe_source "${zsh_dir}/lib/surround.zsh"
  _safe_source "${zsh_dir}/lib/completion.zsh"
  _safe_source "${zsh_dir}/lib/term-title.zsh"
  _safe_source "${zsh_dir}/lib/navigation.zsh"
  _safe_source "${zsh_dir}/lib/expansions.zsh"
  _safe_source "${zsh_dir}/lib/key-bindings.zsh"
fi

# If using Pyenv, import the shell integration if availible
if [[ -d "$PYENV_ROOT" ]] && \
  command -v pyenv >/dev/null 2>&1 && \
  command -v pyenv-virtualenv-init >/dev/null; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi


# Add local bin to PATH (if directory exists)
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# Add Zoxide (for cd, quick jump) to shell
if hash zoxide 2> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# If not running in nested shell, then show welcome message :)
if [[ "${SHLVL}" -lt 2 ]] && \
  { [[ -z "$SKIP_WELCOME" ]] || [[ "$SKIP_WELCOME" == "false" ]]; }; then
  welcome
fi


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Setup oc completion
if [ $commands[oc] ]; then
  source <(oc completion zsh)
  compdef _oc oc
fi