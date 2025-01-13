# simple-memory-cleaner (clmem)
This is a simple script that removes the "buff/cache" from RAM. There nothing different

But there are some features =)
## Install
One line. One command. And everything is ready!
```sh
curl -fsSL https://raw.githubusercontent.com/medowic/simple-memory-cleaner/master/install.sh | sudo bash
```
## Uninstall
```sh
curl -fsSL https://raw.githubusercontent.com/medowic/simple-memory-cleaner/master/uninstall.sh | sudo bash
```
## Usage
### Manually
You can use the `clmem` command for fast memory cleaning

> [!NOTE]
> To use `clmem`, you must be a root or use `sudo`

```sh
$ sudo clmem
# Cleaned: ... MiB
```
### At background (daemon)
Also, `clmem` works as a daemon to clean up memory periodically

To start and stop it, use `systemctl`
```sh
systemctl start clmem # start service
systemctl stop clmem # stop service
```
Usually, `clmem` cleans up memory every 30 minutes, but this value can be changed in `/etc/clmem.conf`:
```
# This is configuration file for simple-memory-cleaner (clmem)

# How often will the memory be cleared (in minutes)?
CLEAN_TIME=30
```
Cleaning is set to every 30 minutes (`CLEAN_TIME=30`). You can change this value to whatever you want but it must be not less than `1`.
```
CLEAN_TIME=60 # now, the daemon will clean memory every 60 minutes
```
If you set this value to less than `1`, the daemon will not start
```
CLEAN_TIME=0 # daemon will be stopped with exit-code 1
```
**After changing the value, restart the daemon by running** `systemctl restart clmem`
# License
This is project is under the [MIT License](https://raw.githubusercontent.com/medowic/simple-memory-cleaner/master/LICENSE)
