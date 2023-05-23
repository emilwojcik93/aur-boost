# aur-boost
Shell Script to boost AUR building time

This script will check declared parameters in:
 * `/etc/makepkg.conf` (by default [none] parameter)
 * `/usr/bin/makepkg`

and change them for more efficient to speed up compiling AUR packages.


## Help example:
```bash
user@host:~# sudo ./aur-boost.sh --help
Script to boost AUR building time (script supports short names for parameters)

Using script:

aur-boost.sh [--config|--package|--install|--all|--help]

config - rewrite config file "/etc/makepkg.conf" (this is default [none] parameter)

package - rewrite package file "/usr/bin/makepkg" (it can be HARMFUL)

install - install most common dependencies required for building process of many AUR packages

all - rewrite both, config and package files and install deps (it can be HARMFUL)

help - get this message
```

## Help example:
```bash
user@host:~# sudo ./aur-boost.sh --status
Current value in "/etc/makepkg.conf": "CFLAGS="-march=native -O2 -pipe -fno-plt -fexceptions \"
Current value in "/etc/makepkg.conf": "MAKEFLAGS="-j$(nproc)""
Current value in "/etc/makepkg.conf": "COMPRESSZST=(zstd -1 -c -z -q -)"
Current value in "/usr/bin/makepkg":  "SKIPCHECKSUMS=1"
Current value in "/usr/bin/makepkg":  "SKIPPGPCHECK=1"
Current value in "/usr/bin/makepkg":  "SKIPPGPCHECK=1"
```

## Oneliners to run from internet
(downloads with `wget` or `curl` to `/tmp`)
### using wget with SSL
```bash
wget 'https://raw.githubusercontent.com/emilwojcik93/aur-boost/main/aur-boost.sh' -O "/tmp/aur-boost.sh" && chmod 755 "/tmp/aur-boost.sh" && sudo /tmp/aur-boost.sh
```
### using wget WITHOUT SSL
```bash
wget --no-check-certificate 'https://raw.githubusercontent.com/emilwojcik93/aur-boost/main/aur-boost.sh' -O "/tmp/aur-boost.sh" && chmod 755 "/tmp/aur-boost.sh" && sudo /tmp/aur-boost.sh
```
### using curl with SSL
```bash
curl -L 'https://raw.githubusercontent.com/emilwojcik93/aur-boost/main/aur-boost.sh' -o "/tmp/aur-boost.sh" && chmod 755 "/tmp/aur-boost.sh" && sudo /tmp/aur-boost.sh
```
### using curl WITHOUT SSL
```bash
curl -k -L 'https://raw.githubusercontent.com/emilwojcik93/aur-boost/main/aur-boost.sh' -o "/tmp/aur-boost.sh" && chmod 755 "/tmp/aur-boost.sh" && sudo /tmp/aur-boost.sh
```
### Execute using `git`

Clone it in current directory and execute `aur-boost.sh`
```bash
git clone git@github.com:emilwojcik93/aur-boost.git
cd aur-boost
sudo ./aur-boost.sh
```

Relevant links:
 - https://wiki.archlinux.org/title/makepkg#Tips_and_tricks
 - https://gist.github.com/beci/c737c89685a667053fe02f986d59ca44#file-aur_speed_up-md
 - https://www.frandieguez.dev/posts/speed-up-archlinux-aur-builds/