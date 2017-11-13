#   -------------------------------
#   1. ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Change Prompt
#   ------------------------------------------------------------
#     prompt output
#       [username]@[short hostname]:[working dir] (working git branch if any)$

#   parse_git_branch: pasrse current git branch checkout out in working dir
#   -----------------------------------------------------
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
  export PS1="\[\033[38;5;248m\]\u@\h:\[$(tput sgr0)\]\[\033[38;5;45m\][\w]\[\033[32m\]\$(parse_git_branch)\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ \[$(tput sgr0)\]"

#   git auto complete
#   -----------------------------------------------------
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
#   -----------------------------
#   2. MAKE TERMINAL BETTER
#   -----------------------------
  alias ll='ls -FGlAhp'                       # Preferred 'll' implementation
  alias ls="ls -G"                            # Preferred 'ls' implementation
  alias ~="cd ~"                              # ~:            Go Home
  alias workspace="cd ~/code"                 # workspace:    Go to ~/code (workspace)
  mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
  title() { echo -e "\033]0;${1:?please specify a title}\007" ; } # tabTitle: sets title of current tab

#   Ocado Specific
#   -----------------------------------------------------
alias getmodules="ssh git@git-repo"

#   tab_title: get last dir in current path
#   -----------------------------------------------------
function tab_title {
  echo -n -e "\033]0;${PWD##*/}\007"
}
PROMPT_COMMAND="tab_title ;"                      # Sets title of current tab to current dir

#   ---------------------------
#   3. PROCESS MANAGEMENT - https://gist.github.com/natelandau/10654137
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
  findPid () { lsof -t -c "$@" ; }

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#     Taken from this macosxhints article
#     http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
  alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
  my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }

#   ---------------------------
#   4. NETWORKING - https://gist.github.com/natelandau/10654137
#   ---------------------------
  alias myip='curl ip.appspot.com'                    # myip: Public facing IP Address

#   ---------------------------------------
#   5. SYSTEMS OPERATIONS & INFORMATION - https://gist.github.com/natelandau/10654137
#   ---------------------------------------
  alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"  #  Recursively delete .DS_Store files

#   ---------------------------------------
#   6. DEV ENV SETUP
#   ---------------------------------------

export "JAVA_HOME=\$(/usr/libexec/java_home)" >> ~/.bash_profile
#export PATH="/usr/local/opt/python/libexec/bin:$PATH"