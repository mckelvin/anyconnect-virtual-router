#!/bin/sh
set -e
# 1. Build libhack.so
cat - >/tmp/hack.c <<EOF
// http://superuser.com/questions/284709/how-to-allow-local-lan-access-while-connected-to-cisco-vpn

#include <sys/socket.h>
#include <linux/netlink.h>

int _ZN27CInterfaceRouteMonitorLinux20routeCallbackHandlerEv()
{
  int fd=50;          // max fd to try
  char buf[8192];
  struct sockaddr_nl sa;
  socklen_t len = sizeof(sa);

  while (fd) {
     if (!getsockname(fd, (struct sockaddr *)&sa, &len)) {
        if (sa.nl_family == AF_NETLINK) {
           ssize_t n = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
        }
     }
     fd--;
  }
  return 0;
}

int _ZN18CFileSystemWatcher11AddNewWatchESsj(void *string, unsigned int integer)
{
  return 0;
}
EOF
gcc -o /opt/cisco/anyconnect/lib/libhack.so -shared -fPIC /tmp/hack.c
rm -rf /tmp/hack.c


# 2. Hack /etc/init.d/vpnagentd
cat - >/tmp/hack.patch <<EOF
--- /etc/init.d/vpnagentd   2015-09-05 23:56:01.247270904 +0800
+++ /etc/init.d/vpnagentd   2015-09-05 23:56:20.472755657 +0800
@@ -38,7 +38,7 @@
   fi

   echo -n "Starting up \$CLIENTNAME"
-  /opt/cisco/anyconnect/bin/vpnagentd
+  LD_PRELOAD=/opt/cisco/anyconnect/lib/libhack.so /opt/cisco/anyconnect/bin/vpnagentd
   RETVAL=\$?
   echo
   return \$RETVAL
EOF


# 3. Restart vpnagentd
patch -p0 -N /etc/init.d/vpnagentd < /tmp/hack.patch || true
rm -rf /tmp/hack.patch

/etc/init.d/vpnagentd stop
