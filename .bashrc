# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

###############################
# CALOCOU BASH PROFILE 
###############################
HISTCONTROL=ignoredups
EDITOR=vim

##############################
# COMPLETETIONS
##############################

# Make directory commands see only directories
complete -d cd mkdir rmdir pushd jd

# Make file commands see only files
complete -f cat less more chown ln strip nedit vim

# Application completes
complete -f -X '!*.@(zip|ZIP|jar|JAR|exe|EXE|pk3|war|wsz|ear|zargo|xpi)' unzip zipinfo unzip
complete -f -X '*.Z' compress
complete -f -X '!*.@(Z|gz|tgz|Gz|dz)' gunzip zcmp zdiff zcat zegrep zfgrep zgrep zless zmore
complete -f -X '!*.Z' uncompress
complete -f -X '!*.@(gif|jp?(e)g|tif?(f)|pn[gm]|p[bgp]m|bmp|xpm|ico|xwd|tga|pcx|GIF|JP?(E)G|TIF?(F)|PN[GM]|P[BGP]M|BMP|XPM|ICO|XWD|TGA|PCX)' ee display
complete -f -X '!*.@(gif|jp?(e)g|tif?(f)|png|p[bgp]m|bmp|x[bp]m|rle|rgb|pcx|fits|pm|GIF|JPG|JP?(E)G|TIF?(F)|PNG|P[BGP]M|BMP|X[BP]M|RLE|RGB|PCX|FITS|PM)' xv qiv
complete -f -X '!*.@(ps|PS)' gv ggv
complete -f -X '!*.@(ps|PS|pdf|PDF)' fmerge
complete -f -X '!*.@(dvi|DVI)?(.@(gz|Z|bz2))' xdvi
complete -f -X '!*.@(dvi|DVI)' dvips dviselect dvitype
complete -f -X '!*.@(pdf|PDF)' acroread gpdf xpdf
complete -f -X '!*.texi*' makeinfo texi2html
complete -f -X '!*.@(?(la)tex|?(LA)TEX|texi|TEXI|dtx|DTX|ins|INS)' tex latex slitex jadetex pdfjadetex pdftex pdflatex texi2dvi
complete -f -X '!*.fig' xfig
complete -f -X '!*.@(?([xX]|[sS])[hH][tT][mM]?([lL]))' netscape mozilla lynx appletviewer hotjava
complete -f -X '!*.tar' tar
complete -f -X '!*.java' javac
complete -f -X '!*.idl' idl idlj

##############################
# ALIASES 
##############################

# General aliases
alias reload_bashrc="source ~/.bashrc"
alias disable_system_beep="xset b 0 0"

# Movements
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Commands
alias ll="ls -altr --color"
alias ls="ls --color"
alias lr="ll -R "
alias cp="cp -rv "
alias grep='grep --color=auto'
alias h='history'
alias df="df -h"
alias mkcd='_(){ mkdir -pv $1; cd $1; }; _'

# tmux 256-colors
alias tmux="tmux -2"

# Mercurial aliases
alias log="hg log -l 8 -G"
alias commit="hg crecord"
alias reset="hg update -C"
alias stats="hg stat"

# Make aliases
alias conf_debug="./configure CFLAGS='-g -Wall -Wextra -O0 -Werror'"
alias conf_debug_migsp="./configure CFLAGS='-g -Wall -Wextra -O0 -DL_ENDIAN -DSTANDALONE'"
alias conf_debug_fence="./configure CFLAGS='-g -Wall -Wextra -O0 -lefence'"
alias conf_release="./configure CFLAGS='-DNDEBUG -O2 -s'"
alias remake="make clean && autoheader && automake && autoconf && conf_debug && make"
alias reconf="autoheader && automake && autoconf && conf_debug"
alias reconf_migsp="autoheader && automake && autoconf && conf_debug_ez"

# Valgrind aliases
alias valg="valgrind --tool=memcheck --leak-check=yes --show-reachable=yes --track-fds=yes"

# Coda definitions
export CODA_DEFINITION="/mnt/work/ACMF/AcmfC/etc/AEOLUS-20150429.codadef"

##############################
# FUNCTIONS
##############################

OpenAllMatchingFilesInVim() {
    find . -name "$1" -exec vim {} +
}
alias openall=OpenAllMatchingFilesInVim

#display directory tree structure
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
