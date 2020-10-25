#!/bin/bash
function f_maintain {
  # configure permission
  file=("/etc/passwd"  "/etc/group" "/etc/passwd-" "/etc/group-")
  for i in "${file[@]}";
  do
    if [[ $(stat -c "%U %G" $i) == "root root" ]]; then
      echo "$i permission configured"
    else
      sudo chown root:root $i
      sudo chmod 644 $i
      sudo chmod u-x,go-wx $i
    fi
  done

  shadow=("/etc/gshadow-" "/etc/shadow" "/etc/gshadow" "/etc/shadow-")
  for i in "${shadow[@]}";
  do
    if [[ $(stat -c "%U %G" $i) == "root root" ]]; then
      echo "$i permission configured"
    else
      sudo chown root:root $i
      sudo chmod 640 $i
      sudo chmod u-x,g-wx,o-rwx $i
    fi
  done
  
  # world writable file
  if [[ $(sudo find / -xdev -type f -perm -0002) == "" ]]; then
    echo "no world writable file found"
  else
    sudo chmod o-w $(sudo find / -xdev -type f -perm -0002)
  fi
  
  # check accounts do not have a password
  sudo awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow

  # ensure only root have uid 0
  if [ $(sudo awk -F: '($3 == 0) { print $1 }' /etc/passwd) == "root" ]; then
    echo "only root have uid 0"
  else
    echo "unprivileged accounts"
    sudo awk -F: '($3 == 0) { print $1 }' /etc/passwd | grep -v root
  fi
}
f_maintain