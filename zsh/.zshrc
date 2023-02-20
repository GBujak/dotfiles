# Environment

export PATH=/home/gbujak/bin:$PATH

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export CARGO_TARGET_DIR=~/.cargo/build_cache/

# Aliases

if ! type "exa" > /dev/null; then
    alias ls="ls"
    alias ll="ls -lh"
    alias la="ls -a"
    alias lla="ls -lha"
    alias lt="tree -sh"
    alias lta="tree -sha"
else 
    alias ls="exa"
    alias lm="exa -s modified"
    alias ll="exa -l"
    alias llm="exa -l -s modified"
    alias la="exa -a"
    alias lla="exa -la"
    alias lt="exa -T"
    alias lta="exa -Ta"
    alias llt="exa -lT"
    alias llta="exa -lTa"
fi

alias ga="git add"
alias gc="git commit"
alias gst="git status"
alias gco="git checkout"
alias gsh="git stash"
alias gb="git branch"
alias gp="git push"
alias gl="git pull"
alias glg="git log --oneline --graph"

function take() { mkdir -p $1 && cd $1 }

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob # nomatch
bindkey -v
bindkey "^?" backward-delete-char
export KEYTIMEOUT=1
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/gbujak/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Completion
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on branch %b'
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%B%1~ > %b'
RPROMPT=\$vcs_info_msg_0_

# autoload -U promptinit && promptinit
# prompt redhat

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# source /usr/share/fzf/completion.zsh
# source /usr/share/fzf/key-bindings.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="$(yarn global bin):$PATH"

export DENO_INSTALL="/home/gbujak/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
