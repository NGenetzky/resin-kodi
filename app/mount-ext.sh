#!/bin/bash

mount_by_label() {
  local label="${1}"
  local devpath="/dev/disk/by-label/${label}"
  if [ -b "${devpath}" ] ; then
    findmnt ${devpath} > /dev/null; local is_mounted=$?
    if [ ${is_mounted} -ne 0 ] ; then
      mount "${devpath}"
      logger --stderr --tag 'mount-ext' \
        "Successfully mounted ${devpath}."
    fi
  fi
}

setup() {
  mount_by_label "EXT-DATA-0"
}
loop() {
  mount_by_label "EXT-DATA-0"
  sleep 1
}

setup
while true; do
  loop
done

