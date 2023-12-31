# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

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
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

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
plugins=(
	git 
	nvm
	dotbare
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
  # replace vim with nvim
  alias vim=nvim
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"


# setup config fileshare alias
if type dotbare &> /dev/null; then
	alias dots='dotbare'
	# bind ctrl-g to 'dots fedit'
	bindkey -s '^g' "dotbare fedit"^j
else
	echo "missing dependancy: dotbare"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Installed curl from homebrew, add to PATH 
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# Use 'fd' for faster searches
#export FZF_DEFAULT_COMMAND="fd -H --ignore --type f"
# export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
if type fd &> /dev/null; then
	export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow"
	# export FZF_DEFAULT_OPTS="--preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
	export FZF_DEFAULT_OPTS="
		--height 60%
		--layout=reverse
		--preview 'bat -n --color=always {}'
		--border
		--multi
		--bind 'ctrl-p:change-preview-window(down|hidden|)'"
	# Preview file content using bat (https://github.com/sharkdp/bat)
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
	export FZF_CTRL_T_OPTS="
		--preview 'bat -n --color=always {}'
		--bind 'ctrl-p:change-preview-window(down|hidden|)'"
	# Print tree structure in the preview window
	export FZF_ALT_C_COMMAND="fd --type d --hidden"
	export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
else
	echo "missing dependancy: fd"
fi

# used to source keybinds related to fzf
# source /usr/share/fzf/keybinds.zsh
# source /usr/share/fzf/completion.zsh

# function to specify day suffix
DaySuffix() {
	case `date +%-d` in
		1|21|31) echo "st";;
		2|22)    echo "nd";;
		3|23)    echo "rd";;
		*)       echo "th";;
	esac
}

# function to generate/edit today's note file
#notes() {
#	local year=$(date +"%Y")
#	local month=$(date +"%m")
#	local day=$(date +"%d")
#	local file=$year-$month-$day
#	local file_path=$HOME/notes/journal/$year/$month/$file.md

#	if [ ! -d "$HOME/notes/journal/$year/" ]; then
#		mkdir $HOME/notes/journal/$year/
#	fi
#	if [ ! -d "$HOME/notes/journal/$year/$month" ]; then
#		mkdir $HOME/notes/journal/$year/$month
#	fi
#	if [ ! -f "$file_path" ]; then
#		date +"# %A %B %-d`DaySuffix`, %Y%n%n" > $file_path
#	fi

#	vim $file_path +3 --cmd "cd ~/notes"
#}

## function to convert the last 5 journal entries into a pdf
#jreport() {
#	local journal_path=$HOME/notes/journal
#	local current_path=$(pwd)

#	# cd for rg to work
#	cd $journal_path

#	# populate txt file with YAML data
#	cat pandoc.yaml > report.txt

#	# ripgrep all journal files, compiling the 5 most recent ones
#	rg -t md --files | sort | tail -5 | \
#	xargs -I{} sh -c "cat {}; echo ''" >> $journal_path/report.txt

#	#return to previous wd
#	cd $current_path

#	# create pdf and delete txt file
#	pandoc $journal_path/report.txt -s -o $journal_path/report.pdf
#	rm $journal_path/report.txt

#	# requires wsl-open if using WSL2
#	xdg-open $journal_path/report.pdf
#}

## function to generate/edit today's meditation file
#meditations() {
#	local file_path=$HOME/notes/meditations/

#	vim $file_path/ --cmd "cd ~/notes"
#}
