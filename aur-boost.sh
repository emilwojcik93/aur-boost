#!/bin/bash

#
# AUR Booster
#
# script to boost AUR building time
#

# [debbug mode] enable a mode of the shell where all executed commands are printed to the terminal
#set -x

OPTION1=${1}

#Color for print
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if script is executed with root privileges
if [[ ${EUID} -ne 0 ]]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

function findStringfn() {
  # grep values in file
  if grep -q "${1}" ${2}; then
    return 0
  else
    return 1
  fi
}

function rewriteConfigfn() {
  # static rewrite for file: "/etc/makepkg.conf"
  local file="/etc/makepkg.conf"
  if findStringfn '\-march=x86-64 -mtune=generic' ${file}; then
    sed -i 's#-march=x86-64 -mtune=generic#-march=native#g' ${file}
    echo -e "Value in \"${file}\" successfuly replaced to: `grep "^CFLAGS" ${file}`"
  else
    echo -e "Can not find target value: \"-march=x86-64 -mtune=generic\"\nCurrent value: \"`grep "^CFLAGS" ${file}`\""
  fi
  
  if findStringfn 'MAKEFLAGS="-j2"' ${file}; then
    sed -i 's#MAKEFLAGS="-j2"#MAKEFLAGS="-j$(nproc)"#g' ${file}
    echo -e "Value in \"${file}\" successfuly replaced to: `grep "^MAKEFLAGS" ${file}`"
  else
    echo -e "Can not find target value: MAKEFLAGS=\"-j2\"\nCurrent value: \"`grep "^MAKEFLAGS" ${file}`\""
  fi
  
  if findStringfn 'COMPRESSZST=(zstd -c -z -q -)' ${file}; then
    sudo sed -i 's#COMPRESSZST=(zstd -c -z -q -)#COMPRESSZST=(zstd -1 -c -z -q -)#g' ${file}
    echo -e "Value in \"${file}\" successfuly replaced to: \"`grep "^COMPRESSZST" ${file}`\""
  else
    echo -e "Can not find target value: \"COMPRESSZST=(zstd -c -z -q -)\"\nCurrent value: \"`grep "^COMPRESSZST" ${file}`\""
  fi
}

function rewritePackagefn() {
  # static rewrite for file: "/usr/bin/makepkg"
  local file="/usr/bin/makepkg"
  if findStringfn 'SKIPCHECKSUMS=0' ${file}; then
    sed -i 's#SKIPCHECKSUMS=0#SKIPCHECKSUMS=1#g' ${file}
    echo -e "Value in \"${file}\" successfuly replaced to: `grep "^SKIPCHECKSUMS" ${file}`"
  else
    echo -e "Can not find target value: \"SKIPCHECKSUMS=0\"\nCurrent value: \"`grep "^SKIPCHECKSUMS" ${file}`\""
  fi
  
  if findStringfn 'SKIPPGPCHECK=0' ${file}; then
    sed -i 's#SKIPPGPCHECK=0#SKIPPGPCHECK=1#g' ${file}
    echo -e "Value in \"${file}\" successfuly replaced to: `grep "^SKIPPGPCHECK" ${file}`"
  else
    echo -e "Can not find target value: \"SKIPPGPCHECK=0\"\nCurrent value: \"`grep "^SKIPPGPCHECK" ${file}`\""
  fi
}

function installfn() {
  # install most common packages required by AUR
  sudo yes | \
  pacman -Syyu --needed \
         pkgconfig \
         base-devel \
         devtools \
         gcc \
         patch \
         make \
         flex \
         bison \
         ed \
         xmlto \
         kmod \
         inetutils \
         bc \
         libelf \
         git \
         cpio \
         perl \
         tar \
         xz
}
allfn() {
  # statc run for both config and package "makepkg"
  rewriteConfigfn && \
  rewritePackagefn && \
  installfn
}

statusfn() {
  # get current values of parameters supported by this script
  local file="/etc/makepkg.conf"
  echo -e "Current value in \"${file}\": \"`grep "^CFLAGS" ${file}`\""
  echo -e "Current value in \"${file}\": \"`grep "^MAKEFLAGS" ${file}`\""
  echo -e "Current value in \"${file}\": \"`grep "^COMPRESSZST" ${file}`\""
  unset file
  local file="/usr/bin/makepkg"
  echo -e "Current value in \"${file}\":  \"`grep "^SKIPCHECKSUMS" ${file}`\""
  echo -e "Current value in \"${file}\":  \"`grep "^SKIPPGPCHECK" ${file}`\""
  echo -e "Current value in \"${file}\":  \"`grep "^SKIPPGPCHECK" ${file}`\""
}

function helpfn() {
  # help how use script
  echo -e "Script to boost AUR building time (script supports short names for parameters)\n\nUsing script:\n\n${GREEN}`basename "${0}"`${NC} [--config|--package|--install|--all|--help]\n\n${GREEN}config${NC} - rewrite config file \"/etc/makepkg.conf\" (this is default [none] parameter)\n\n${GREEN}package${NC} - rewrite package file \"/usr/bin/makepkg\" ${RED}(it can be HARMFUL)${NC}\n\n${GREEN}install${NC} - install most common dependencies required for building process of many AUR packages\n\n${GREEN}all${NC} - rewrite both, config and package files and install deps ${RED}(it can be HARMFUL)${NC}\n\n${GREEN}help${NC} - get this message\n"
  exit 0
}

namingfn() {
  # start or stop services
  # echo "namingfn: ${OPTION1}"
  case "${OPTION1}" in
      --help|-h )                                                            helpfn ;;
      --config|-c )                                                 rewriteConfigfn ;;
      --package|-p )                                               rewritePackagefn ;;
      --install|-i )                                                      installfn ;;
      --all|-a )                                                              allfn ;;
      --status|-s )                                                        statusfn ;;
      "" )                                                          rewriteConfigfn ;;
      * ) echo -e "${RED}Parameter \"${OPTION1}\" is not supported.${NC}" && helpfn ;;
  esac
}

main() {
  namingfn ${OPTION1}
}

#just run
main ${1}
