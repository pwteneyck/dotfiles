alias terra='ssh pwt@192.168.4.207'
alias pdash="firefox 'http://192.168.4.207:32400/web/index.html#!/settings/server/6c06304aedfbac70505e735f240155f895c1efc5/status/server-dashboard' > /dev/null 2>%1 &"
alias python='/usr/bin/python3'
alias pip='pip3'
alias python2='/usr/bin/python'
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
