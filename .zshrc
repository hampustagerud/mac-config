# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/Hampus/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git mix sudo yarn wd)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
LANG="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='nvim'
else
	export EDITOR='nvim'
fi

setopt prompt_subst

prompt_context()
{
	PENGUIN_COLOR=green
	if [ ${RETVAL} -gt 0 ]; then
		PENGUIN_COLOR=red
	fi

	prompt_segment ${PENGUIN_COLOR} default "🐧"
}

prompt_dir()
{
	DIR_NAME=$(basename $(pwd))
	prompt_segment blue $CURRENT_FG ${DIR_NAME}
	# prompt_segment blue $CURRENT_FG "%~"
}

prompt_git()
{
	ls .git > /dev/null 2>&1
	HAS_GIT=${?}

	if [ "$(pwd)" = "${HOME}" ] || [ ${HAS_GIT} -ne 0 ]; then
		return
	fi

	GIT_ROOT=$(git rev-parse --git-dir 2> /dev/null)

	if [ "${GIT_ROOT}" = "${HOME}/.git" ]; then
		return
	fi

	BRANCH_ICON=$'\uf1d3'
	DIRTY=$(parse_git_dirty)

	if [ -n ${DIRTY} ]; then
		BACKGROUND=green
	else
		BACKGROUND=yellow
	fi

	STATS=$(git diff origin/master --shortstat 2> /dev/null  | awk '{ print "(" $1 ")" " " $4 "+" " " $6 "-" }' || echo '')

	prompt_segment ${BACKGROUND} ${CURRENT_FG} "${BRANCH_ICON} ${STATS}"
}

build_prompt()
{
	RETVAL=$?
	prompt_context
	prompt_dir
	prompt_git
	prompt_end
}

alias vim=nvim

export PATH="/usr/local/opt/postgresql@9.6/bin:$HOME/.cargo/bin:$PATH:$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/platform-tools:$HOME/Library/Android/sdk/tools/bin"
export SHELL="/bin/zsh"

zstyle ':completion:*' special-dirs true
expand-or-complete-special-dot() {
	if [[ $BUFFER == "." ]]; then
		LBUFFER="./"
	fi

	zle expand-or-complete
}

zle -N expand-or-complete-special-dot
bindkey "^I" expand-or-complete-special-dot
setopt COMPLETE_ALIASES

# OPAM configuration
. /Users/Hampus/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

function realpath()
{
	perl -e 'use File::Spec; print File::Spec->abs2rel(@ARGV) . "\n"' $1 $2
}

function who-is-using-my-port()
{
	sudo lsof -i tcp:$1
}

function dir()
{
	echo ${PWD}
}
