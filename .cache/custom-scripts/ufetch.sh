#!/bin/sh
#
# ufetch-manjaro - tiny system info for manjaro
# slightly modified script from https://gitlab.com/jschx/ufetch/-/blob/master/ufetch-manjaro

## INFO

# user is already defined
host="$(hostname)"
os='Manjaro'
kernel="$(uname -sr)"
uptime="$(uptime -p | sed 's/up //')"
packages="$(pacman -Q | wc -l)"
shell="$(basename "$SHELL")"

## UI DETECTION
# changed DE to WM for XDG_CURRENT_DESKTOP and DESKTOP_SESSION

if [ -n "${DE}" ]; then
	ui="${DE}"
	uitype='DE'
elif [ -n "${WM}" ]; then
	ui="${WM}"
	uitype='WM'
elif [ -n "${XDG_CURRENT_DESKTOP}" ]; then
	ui="${XDG_CURRENT_DESKTOP}"
	uitype='WM'
elif [ -n "${DESKTOP_SESSION}" ]; then
	ui="${DESKTOP_SESSION}"
	uitype='WM'
elif [ -f "${HOME}/.xinitrc" ]; then
	ui="$(tail -n 1 "${HOME}/.xinitrc" | cut -d ' ' -f 2)"
	uitype='WM'
elif [ -f "${HOME}/.xsession" ]; then
	ui="$(tail -n 1 "${HOME}/.xsession" | cut -d ' ' -f 2)"
	uitype='WM'
else
	ui='unknown'
	uitype='UI'
fi

## DEFINE COLORS

# probably don't change these
if [ -x "$(command -v tput)" ]; then
	bold="$(tput bold)"
	black="$(tput setaf 0)"
	red="$(tput setaf 1)"
	green="$(tput setaf 2)"
	yellow="$(tput setaf 3)"
	blue="$(tput setaf 4)"
	magenta="$(tput setaf 5)"
	cyan="$(tput setaf 6)"
	white="$(tput setaf 7)"
        red2="$(tput setaf 9)"
        orange="$(tput setaf 173)"
        darker_orange="$(tput setaf 137)"
	reset="$(tput sgr0)"
fi

# you can change these
lc="${reset}${bold}${orange}"        # labels
nc="${reset}${bold}${orange}"        # user
hc="${reset}${bold}${red2}"          # hostname
ic="${reset}${white}"                # info
c0="${reset}${darker_orange}"        # first color

## OUTPUT

cat <<EOF

${c0}  ||||||||| ||||  ${nc}${USER}${ic}@${hc}${host}${reset}
${c0}  ||||||||| ||||  ${lc}OS:        ${ic}${os}${reset}
${c0}  ||||      ||||  ${lc}Kernel:    ${ic}${kernel}${reset}
${c0}  |||| |||| ||||  ${lc}Uptime:    ${ic}${uptime}${reset}
${c0}  |||| |||| ||||  ${lc}Packages:  ${ic}${packages}${reset}
${c0}  |||| |||| ||||  ${lc}Shell:     ${ic}${shell}${reset}
${c0}  |||| |||| ||||  ${lc}${uitype}:        ${ic}${ui}${reset}

EOF
