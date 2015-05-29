RED='\e[1;31m'
GREEN='\e[1;32m'
BLUE='\e[1;34m'
CYAN='\e[1;36m'
NO_COLOR='\e[0m'

WHOAMI=`whoami`
OS=`uname -s`
HOSTNAME=`hostname`

CVSROOT=:ext:anault@rmncvs.rmnus.sen.symantec.com:/nbe/CVS; export CVSROOT
CVS_RSH=/usr/bin/ssh; export CVS_RSH
EXTSRCROOT=/net/code/extsrc; export EXTSRCROOT

alias home='cd ~anault'
alias trunk='cd ~anault/sandbox/trunk/src'
alias robinv='cd ~anault/sandbox/robInv/src'
alias log='cd ~anault/sandbox/logging/src'
alias la='ls -lA'
alias ll='ls -l'
alias ld='ls -ld'
alias cu='cvs update'
alias sandbox='cd ~anault/sandbox'
alias et='cd ~anault/et'
alias mkdir='mkdir -p'
alias sup='cd ~anault/sandbox/support/src'
alias branch='cd ~anault/sandbox/branch/src'
alias sb='cd ~anault/sandbox'

if [ "$WHOAMI" == "root" ]
    then	
	if [ -d /usr/openv/netbackup ]
    	    then
		source /usr/openv/db/vxdbms_env.sh
	fi
fi

PLATFORM=${OSTYPE//[0-9.]}
printf "Setting up for ${RED}$PLATFORM${NO_COLOR} platform\n"

function get_ip()
{
    if [ $PLATFORM == "linux" ]; then
	    return `hostname -i`
    elif [ $PLATFORM == "solaris" ]; then
	    return `ifconfig -a | grep inet | grep -v '127.0.0.1' | awk '{print $2}'`
	else
	    printf "PLATFORM is not linux or solaris\n"
	    exit
    fi
}

USR="/usr/bin:/usr/local/bin:/usr/local/lib:/usr/local/lib/python3.4:/usr/local/lib64:/usr/lib:/usr/ccs/bin:/usr/sbin:/usr/dt/bin:/usr/ucb:/usr/QE/current-te:/usr/QE/teperl/bin:/usr/include/glib-2.0"
NET='/net/code/ovsrc/int/tools/bin:/net/nbstore/vol/tools/bin:/net/nbstore/vol/tools/bin/CVS/bin/cvs'
NB='/usr/openv/db/bin:/usr/openv/netbackup/bin:/usr/openv/netbackup/bin/admincmd:/usr/openv/netbackup/bin/goodies:/usr/openv/volmgr/bin:/usr/openv/netbackup/bin/support'
ANAULT='/home/anault/scripts:/home/anault/scripts/nghtly_cmds:/home/anault/scripts/branch:/home/anault/opt/bin'
ROOT_PATHS='/bin:/etc:/sbin'
OPT='/opt/BullseyeCoverage/bin:/opt/SUNWspro/bin'
LD_LIBRARY_PATH='/home/anault/env/wxPython-src-3.0.0.0/wxpy-bld/lib:/usr/local/lib'
PYTHONPATH='/home/anault/env/wxPython-src-3.0.0.0/wxPython'

#export PATH="$USR:$NET:$NB:$ANAULT:$ROOT_PATHS:$OPT"
## Bullseye path
export PATH="$OPT:$USR:$NET:$NB:$ANAULT:$ROOT_PATHS"

export PS1="\u@\h \[${CYAN}\]\W\[$NO_COLOR\] > " 

# setup display
if [ "$HOSTNAME" == "essexvm1" ]
    then
        export DISPLAY=10.81.57.47:1.0 # essexvm1
elif [ "$HOSTNAME" == "essexvm2" ]
    then
        export DISPLAY=10.81.57.77:1.0 #essexvm2
else
    printf "DISPLAY not set\n"
fi

#export DISPLAY=10.81.16.42:1.0
#export TMOUT=86400
export TMOUT=0
printf "IP $DISPLAY\n"

case "$TERM" in
    xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
;;
*)
;;
esac

vxlv()
{
    vxlogview -d all -i $1 -G $2 > $3
}

nbblr()
{
     PLAT=linuxR_x86
     nbbuild --plat $PLAT $1 $2 $3 $4 $5 $6 2>&1 | tee ~/make_files/log-make-$PLAT 
}

nbbls()
{
     PLAT=linuxS_x86
     nbbuild --plat $PLAT $1 $2 $3 $4 $5 $6 2>&1 | tee ~/make_files/log-make-$PLAT
}

nbbhp()
{
     PLAT=hp_ux
     nbbuild --plat $PLAT $1 $2 $3 $4 $5 $6 2>&1 | tee ~/make_files/log-make-$PLAT 
}

nbbss()
{
     PLAT=solaris
     nbbuild --plat $PLAT $1 $2 $3 $4 $5 $6 2>&1 | tee ~/make_files/log-make-$PLAT 
}

nbbsx()
{
     PLAT=solaris_x86
     nbbuild --plat $PLAT $1 $2 $3 $4 $5 $6 2>&1 | tee ~/make_files/log-make-$PLAT 
}

nbbwx()
{
     PLAT=x86
     nbbuild --plat $PLAT $1 $2 $3 $4 $5 $6 2>&1 | tee ~/make_files/log-make-$PLAT 
}

nbbwa()
{
     PLAT=AMD64
     nbbuild --plat $PLAT $1 $2 $3 $4 $5 $6 2>&1 | tee ~/make_files/log-make-$PLAT 
}

nbbrs()
{
     PLAT=rs6000
     nbbuild --plat $PLAT $1 $2 $3 $4 $5 $6 2>&1 | tee ~/make_files/log-make-$PLAT 
}

nbbhi()
{
     PLAT=hpia64
     nbbuild --plat $PLAT $1 $2 $3 $4 $5 $6 2>&1 | tee ~/make_files/log-make-$PLAT 
}

cloblr()
{
     nbbuild --plat linuxR_x86 clobber
}
clobls()
{
     nbbuild --plat linuxS_x86 clobber
}
clobhp()
{
     nbbuild --plat hp_ux clobber
}
clobhi()
{
     nbbuild --plat hpia64 clobber
}
clobrs()
{
     nbbuild --plat rs6000 clobber
}
clobss()
{
     nbbuild --plat solaris clobber
}
clobsx()
{
     nbbuild --plat solaris_x86 clobber
}
clobwa()
{
     nbbuild --plat AMD64 clobber
}
clobwx()
{
     nbbuild --plat x86 clobber
}

fif()
{
     find . -type f -exec grep $1 {} +
}

ffn()
{
     find . -name "$1"
}

function create_policies()
{
    COUNT=$1

    for (( i=1; i<=$COUNT; i++ ))
    do
	bppolicynew policy$i
    done
}

function inactive_policies()
{
    for (( i=1; i<=25; i++ ))
    do
	bpplinfo policy$i -modify -inactive
    done	
}

function find-in-binaries()
{
    STRING="$*"
    
    LIST=`find . -type f -exec perl -e 'print (-B $_ ? "$_\n" : "") for @ARGV' {} +`
    
    # display list
    #for file in $LIST
    #    do
    #        echo $file
    #done

    # do the searching
    for binary in $LIST
    do
        # echo "Searching [$binary] for \"$STRING\""
        RETVAL=`strings $binary | grep "$STRING"`
        if [[ "$RETVAL" =~ "$STRING" ]]
        then
            echo "Found [$STRING] in [$binary]:"
            # so color formatting comes through in results from grep
            echo $RETVAL | grep "$STRING"
        fi
    done
}


function emc()
{
    BASENAME=`basename \`pwd\``
    if [ "$WHOAMI" == "root" ]; then
	ROOT=1
    fi
    # ROOT=0 # added to not call --user anault - not working on essexvm3
    if [ "$1" == "gdb" ]; then
	if [ $ROOT ]; then
	    emacs --eval "(gdb \"gdb -i=mi $*\")" --maximized --user anault --title="GDB"
	else
	    emacs --eval "(gdb \"gdb -i=mi $*\")" --maximized --title="GDB"
	fi
    elif [ $BASENAME == "src" ] ; then
	TITLE=`pwd | awk -F \/ '{print $5}'`
	TITLE=`echo $TITLE | tr "[a-z]" "[A-Z]"`
	if [ $ROOT ]; then
	    emacs --maximized --user anault --title="$TITLE"
	else
	    emacs --maximized --title="$TITLE"
	fi
    else 
	TITLE="$BASENAME"
	TITLE=`echo $TITLE | tr "[a-z]" "[A-Z]"`
	if [ $ROOT ]; then
	    emacs --maximized --user anault --title="$TITLE"	    
	else
	    emacs --maximized --title="$TITLE"
	fi
    fi
}
