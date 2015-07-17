### Unoffical Docker-Container for IP-Symcon

***

based on Ubuntu 14.04

Volumes:

- /etc/symcon
- /usr/share/symcon
- /root

No Exposes (Ports) use option --net="Host"

Example to run image (tested with FS20 and Homematic):

	docker run --name symcon --net="host" \
	-v /mnt/data1/@appdata/symcon/etc:/etc/symcon \
	-v /mnt/data1/@appdata/symcon/root:/root \
	-v /mnt/data1/@appdata/symcon/share:/usr/share/symcon \
	--device /dev/ttyUSB0:/dev/ttyUSB0 \
	blockmove/symcon
