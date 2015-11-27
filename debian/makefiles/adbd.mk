# Makefile for adbd

SRCDIR ?= $(CURDIR)

VPATH+= $(SRCDIR)/core/adb
SRCS+= adb.c
SRCS+= fdevent.c
SRCS+= transport.c
SRCS+= transport_local.c
SRCS+= transport_usb.c
SRCS+= adb_auth_client.c
SRCS+= sockets.c
SRCS+= services.c
SRCS+= file_sync_service.c
SRCS+= jdwp_service.c
SRCS+= framebuffer_service.c
SRCS+= remount_service.c
SRCS+= disable_verity_service.c
SRCS+= usb_linux_client.c

VPATH+= $(SRCDIR)/core/liblog
SRCS+= logd_write.c

VPATH+= $(SRCDIR)/core/fs_mgr
SRCS+= fs_mgr_fstab.c

VPATH+= $(SRCDIR)/core/libcutils
SRCS+= socket_inaddr_any_server.c
SRCS+= socket_local_client.c
SRCS+= socket_local_server.c
SRCS+= socket_loopback_client.c
SRCS+= socket_loopback_server.c
SRCS+= socket_network_client.c
SRCS+= properties.c
SRCS+= klog.c

VPATH+= $(SRCDIR)/extras/ext4_utils
SRCS+= ext4_sb.c

CPPFLAGS+= -std=gnu11
CPPFLAGS+= -D_XOPEN_SOURCE -D_GNU_SOURCE
CPPFLAGS+= -DADB_HOST=0
CPPFLAGS+= -DALLOW_ADBD_ROOT=1
CPPFLAGS+= -DALLOW_ADBD_DISABLE_VERITY=1
CPPFLAGS+= -DPROP_NAME_MAX=32
CPPFLAGS+= -DPROP_VALUE_MAX=92
CPPFLAGS+= -I$(SRCDIR)/core/adb
CPPFLAGS+= -I$(SRCDIR)/core/include
CPPFLAGS+= -I$(SRCDIR)/extras/ext4_utils
CPPFLAGS+= -I$(SRCDIR)/core/fs_mgr/include
CPPFLAGS+= -I$(SRCDIR)/libhardware/include
CPPFLAGS+= -include /usr/include/android/arch/$(android_arch)/AndroidConfig.h

LIBS+= -lc -lpthread -lbsd -lselinux -lresolv -lcrypto

OBJS= $(SRCS:.c=.o)

all: adbd

adbd: $(OBJS)
	$(CC) -o $@ $(LDFLAGS) $(OBJS) $(LIBS)

clean:
	rm -rf $(OBJS) adbd
