# Top 10 Linux Job Interview Questions: [link]

## ip
how to check current ip address?
> `ip addr show eth0`

## df 
how to check for free disk space?

> `df -ah`
- all filesystems, human readable

## systemctl/service
how would you manage services?

> `service udev status`
- command for older machines

> `systemctl status udev`
- for machines running systemd

## du
how would you check total size of a directory?

> `du -sh ~`
- disk usage, summarize in a human readable format the user's home directory

## ss/netstat
check for listening network sockets, open ports, tcp/udp services?

> `ss -tulpn`
- list listening sockets and their process ID that are tcp, or udp, not resolving service names.
- running as root gives more results

> `netstat -tulpn`
- depreciated, same as above command

## ps/top/htop
how would you check CPU usage for a given process?

> `ps aux | grep nginx`
- searches for nginx and lists process info

> `top` or `htop`
- GUI version, updates in real time

## mount
how would you mount a filesystem in linux?

> `mount /dev/sda2 /mnt`
- takes absolute path to filesystem and mounts it to destination

[link]: https://www.youtube.com/watch?v=l0QGLMwR-lY
