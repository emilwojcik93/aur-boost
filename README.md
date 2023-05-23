# aur-boost
Shell Script to boost AUR building time

This script will check declared parameters in `/etc/makepkg.conf` and change them for more efficient to speed up compiling AUR packages.

### Oneliners to run from internet
(downloads with `wget` or `curl` to `/tmp`)
```bash
# using wget with SSL
wget 'https://raw.githubusercontent.com/emilwojcik93/aur-boost/main/aur-boost.sh' -O "/tmp/aur-boost.sh" && chmod 755 "/tmp/aur-boost.sh" && sudo /tmp/aur-boost.sh

# using wget WITHOUT SSL
wget --no-check-certificate 'https://raw.githubusercontent.com/emilwojcik93/aur-boost/main/aur-boost.sh' -O "/tmp/aur-boost.sh" && chmod 755 "/tmp/aur-boost.sh" && sudo /tmp/aur-boost.sh

# using curl with SSL
curl -L 'https://raw.githubusercontent.com/emilwojcik93/aur-boost/main/aur-boost.sh' -o "/tmp/aur-boost.sh" && chmod 755 "/tmp/aur-boost.sh" && sudo /tmp/aur-boost.sh

# using curl WITHOUT SSL
curl -k -L 'https://raw.githubusercontent.com/emilwojcik93/aur-boost/main/aur-boost.sh' -o "/tmp/aur-boost.sh" && chmod 755 "/tmp/aur-boost.sh" && sudo /tmp/aur-boost.sh
```
### Install using `git`
Clone it in current directory and execute `aur-boost.sh`
```
# git clone git@github.com:emilwojcik93/aur-boost.git
# cd aur-boost
# sudo ./aur-boost.sh
```

Relevant links:
 - https://wiki.archlinux.org/title/makepkg#Tips_and_tricks
 - https://gist.github.com/beci/c737c89685a667053fe02f986d59ca44#file-aur_speed_up-md
 - https://www.frandieguez.dev/posts/speed-up-archlinux-aur-builds/