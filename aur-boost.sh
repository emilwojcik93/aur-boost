#!/bin/bash

# Check if script is executed with root privileges
if [[ ${EUID} -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Function to grep values in file
function findString() {
  if grep -q "${1}" ${2}; then
    return 0
  else
    return 1
  fi
}

if findString '\-march=x86-64 -mtune=generic' /etc/makepkg.conf; then
  sed -i 's#-march=x86-64 -mtune=generic#-march=native#g' /etc/makepkg.conf
  echo -e "Value successfuly replaced to: `grep "^CFLAGS" /etc/makepkg.conf`"
else
  echo -e "Can not find target value: \"-march=x86-64 -mtune=generic\"\nCurrent value: `grep "^CFLAGS" /etc/makepkg.conf`"
fi

if findString 'MAKEFLAGS="-j2"' /etc/makepkg.conf; then
  sed -i 's#MAKEFLAGS="-j2"#MAKEFLAGS="-j$(nproc)"#g' /etc/makepkg.conf
  echo -e "Value successfuly replaced to: `grep "^MAKEFLAGS" /etc/makepkg.conf`"
else
  echo -e "Can not find target value: MAKEFLAGS=\"-j2\"\nCurrent value: `grep "^MAKEFLAGS" /etc/makepkg.conf`"
fi

if findString 'COMPRESSZST=(zstd -c -z -q -)' /etc/makepkg.conf; then
  sudo sed -i 's#COMPRESSZST=(zstd -c -z -q -)#COMPRESSZST=(zstd -1 -c -z -q -)#g' /etc/makepkg.conf
  echo -e "Value successfuly replaced to: `grep "^COMPRESSZST" /etc/makepkg.conf`"
else
  echo -e "Can not find target value: \"COMPRESSZST=(zstd -c -z -q -)\"\nCurrent value: `grep "^COMPRESSZST" /etc/makepkg.conf`"
fi
