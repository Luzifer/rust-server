#!/bin/bash
set -euxo pipefail

# Copy default rustserver script from Linux Game Server Managers when not present
[ -e /home/rustserver/rustserver ] || {
	cp /opt/rustserver /home/rustserver/rustserver
	chmod 0755 /home/rustserver/rustserver
}

/home/rustserver/rustserver "$@"

set +x
# Keep Docker container running until gameserver process is not longer available
while (pgrep RustDedicated >/dev/null 2>&1); do
	sleep 1
done
