alias python='/usr/bin/python3'
alias pip='pip3'
alias python2='/usr/bin/python'
# alias plex='ssh pwt@192.168.4.113'
alias terra='ssh pwt@192.168.4.207'

fox() {
  firefox $1 > /dev/null 2>&1 & disown firefox
}

qute() {
  qutebrowser $1 > /dev/null 2>&1 & disown qutebrowser
}

pass() {
  op list users > /dev/null
  if [[ $? -eq 1 ]]
  then
    eval $(op signin my)
  fi
  JSON=$(op list items |\
	  jq ".[] | select(.overview.title | contains(\"$1\")) | .uuid" |\
	  xargs -I % sh -c 'op get item % --fields username,password | jq "." | sed -e "s/\\\\\\\/\\\/g"')
  echo $JSON | jq -r ".password" | xclip -sel clip
  UNAME=$(echo $JSON | jq -r ".username")
  printf "Username: %s\n" "$UNAME"
  echo 'Password copied to clipboard'
}