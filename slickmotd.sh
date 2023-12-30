#!/usr/bin/env bash
# slickmotd generates a slick looking motd
# it requires figlet, git, and https://github.com/xero/figlet-fonts

set -euo pipefail

# enable color output by default
COLOR_ENABLED=1

# utilize cyan and lightgray
CYAN="\e[36m"
LIGHTGRAY="\e[37m"
RESETCOLOR="\e[0m"

UPTIME=0
HELP=0
SIGNATURE="enjoy your stay"
declare -i TERM_COLS=80
declare -i TERM_ROWS=25

FONTDIR='/tmp/figlet-fonts'
FONTREPO='https://github.com/xero/figlet-fonts.git'

show_help() {
    echo "slickmotd - generate a slick looking motd"
    echo ""
    echo "Options:"
    echo "      --help          print usage"
    echo "  -c, --color         enable color output     (default: enabled)"
    echo "  -n, --no-color      disable color output"
    echo "  -u, --uptime        enable uptime output    (default: disabled)"
    echo "  -s, --signature     set signature quote     (default: \"enjoy your stay\")"
    echo "  -h, --hostname      set short hostname      (default: autodetect)"
    echo "  -d, --domain        set domain              (default: autodetect)"
    echo "  -x, --width         set width in columns    (default: 80)"
    echo "  -y, --height        set height in rows      (default: 25)"
    echo ""
    echo "Generate a custom motd:"
    echo " slickmotd -u --hostname \"euclid\" --domain \"theore.ms\" --signature \"q is prime\""
    echo ""
}

# bail if git not available
if ! type "git" >/dev/null 2>/dev/null;
then
    echo "git not present, exiting"
    exit 1
fi

# bail if figlet not available
if ! type "figlet" >/dev/null 2>/dev/null;
then
    echo "figlet not present, exiting"
    exit 1
else
    FIGLET=$(command -v "figlet")
fi

# if font directory doesn't exist we need to clone it
if [ ! -d "${FONTDIR}" ];
then
    echo "FONTDIR:${FONTDIR} does not exist. cloning repo ${FONTREPO}!"
    git clone ${FONTREPO} ${FONTDIR}
fi

# if the font directory *still* doesn't exist we have to bail
if [ ! -d "${FONTDIR}" ];
then
    exit 1
fi

getspace() { # NUM
# Returns string of NUM space chars
#
	C=0 ; out=""
    while [[ $C -lt $1 ]];do out+=" "; (( C++));done
	printf "%s" "$out"
}

function vcenter { # TEXT
# Returns a vertically centered set of text
    text=$*
    text_length=$(echo -e "${text}" | wc -l)
    half_of_text_length=$(( text_length / 2))

    center=$((( TERM_ROWS / 2 ) - half_of_text_length))
    lines=""
    
    for ((i=0; i < center; i++)) {
        lines+="\n"
    }

    printf "%b%b%b" "$lines" "$text" "$lines"
    [[ $(( (TERM_ROWS - text_length) % 2 )) -ne 0 ]]
    printf "\n"
}

function hcenter { # TEXT FILLER(optional)
# Returns a centered string of TEXT using optional character FILLER
# this ignores ANSI color escape sequences to ensure accurate spacing
     [[ $# == 0 ]] && return 1

     str=$(echo "${1}" | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g")
     declare -i str_len=${#str}
     [[ $str_len -ge $TERM_COLS ]] && {
          echo "$1";
          return 0;
     }

     declare -i filler_len="$(( (TERM_COLS - str_len) / 2 ))"
     [[ $# -ge 2 ]] && ch="${2:0:1}" || ch=" "
     filler=""
     for (( i = 0; i < filler_len; i++ )); do
          filler="${filler}${ch}"
     done

     printf "%s%s%s" "$filler" "$1" "$filler"
     [[ $(( (TERM_COLS - str_len) % 2 )) -ne 0 ]] && printf "%s" "${ch}"
     printf "\n"

     return 0
}

TEMP=$(getopt -o cnus:h:d:x:y: --long help,color,no-color,uptime,signature:,hostname:,domain:,width:,height: -- "$@")

eval set -- "$TEMP"
while true; do
    case "$1" in
        --help ) HELP=1; shift;;
        -c | --color ) COLOR_ENABLED=1; shift;;
        -n | --no-color ) COLOR_ENABLED=0; shift;;
        -u | --uptime ) UPTIME=1; shift;;
        -s | --signature ) SIGNATURE="$2"; shift 2;;
        -h | --hostname ) hostname="$2"; shift 2;;
        -d | --domain ) domain="$2"; shift 2;;
        -x | --width ) TERM_COLS="$2"; shift 2;;
        -y | --height ) TERM_ROWS="$2"; shift 2;;
        == ) shift; break ;;
        * ) break ;;
    esac
done

# begin options validation
if [ "${HELP}" -eq "1" ];
then
    show_help
    exit 0
fi

if [[ $TERM_COLS -lt 80 ]];
then
    echo "cannot specify less than 80 columns"
    exit 1
fi

if [ -z ${hostname+x} ];
then
	hostname=$(hostname)
fi

if [ -z ${domain+x} ];
then
    domain=$(hostname -d)
fi
# end options validation

# generate hostname art
hostnameart=$(${FIGLET} -d /${FONTDIR} -w "${TERM_COLS}" -c -s -f Bloody "${hostname}")

# find out how many vertical lines the hostname art would take by default
lines=$(echo "${hostnameart}" | wc -l)

# if the hostname art is too long vertically, truncate it
if [ "$lines" -gt 10 ];
then
    found=0;
    tmplength=$(echo -n "$hostname" | wc -c);
    while [[ $tmplength -gt 0 && $found -eq 0 ]];
    do
        tmplength="$((tmplength-1))"
        short_host="${hostname:0:${tmplength}}";
        hostnameart=$(${FIGLET} -d /${FONTDIR} -w 80 -c -s -f Bloody "${short_host}")
        shortlines=$(echo "${hostnameart}" | wc -l)
        if [ "$shortlines" -lt 20 ];
        then
            found=1;
        fi
    done
fi

# BEGIN prettify hostname section
# the pretty output should be a colorized version of below:
#                          ┌                         ┐
#      · ··  ·  · ·· ──────┤ hostname.somedomain.com ├────── ·· ·  ·  ·· ·
#                          └                         ┘

hostname_pretty=$(echo -e -n "${CYAN}${hostname}${LIGHTGRAY}.${domain}${RESETCOLOR}")

#header: · ··  ·  · ·· ──────┤
#footer: ├────── ·· ·  ·  ·· ·
header="·[36m ·[1;37m·[0;36m  [37m·[36m  · [1m·[37m·[0;36m [1m─[0;36m──[1;37m─[0;36m─[1m─┤[0m"
footer="[1;36m├─[0;36m─[1;37m─[0;36m──[1m─[0;36m [1;37m·[36m·[0;36m ·  [37m·[36m  [1;37m·[0;36m· [37m·"

#topheader: ┌
#topfooter: ┐
topheader="[36m┌[37m"
topfooter="[36m┐[37m"

#bottomheader: └
#bottomfooter: ┘
bottomheader="[36m└[37m"
bottomfooter="[36m┘[37m"

# get the length of the prettified hostname (without color codes)
tmpstr=$(echo -E "${hostname_pretty}" | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g")
spaces=$(getspace ${#tmpstr})
top_centered=$(hcenter "${topheader} ${spaces} ${topfooter}")
hostname_centered=$(hcenter "${header} ${hostname_pretty} ${footer}")
bottom_centered=$(hcenter "${bottomheader} ${spaces} ${bottomfooter}")
# end prettified hostname

# if the user wants uptime, drop it in, otherwise just use the signature
signature_centered=$(hcenter "${SIGNATURE}")

if [ "${UPTIME}" -eq "1" ];
then
    uptime_centered=$(hcenter "$(uptime)")
    motd_tail="${uptime_centered}\n\n${signature_centered}"
else
    motd_tail="${signature_centered}\n\n"
fi

# the final formatted string with color
formattedstring="${CYAN}${hostnameart}

${top_centered}
${hostname_centered}
${bottom_centered}
${motd_tail}${RESETCOLOR}"

# print color or non-color output
if [ "${COLOR_ENABLED}" -eq "1" ];
then
    vcenter "${formattedstring}"
else
    # sed to remove all the ANSI color escape sequences
    formattedstring=$(printf "%b" "${formattedstring}" | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g")
    vcenter "${formattedstring}"
fi


