# Makefile for adbd

SRCDIR ?= $(CURDIR)

VPATH+= $(SRCDIR)/core/adb
SRCS+= adb.c
SRCS+= adb_auth_client.c
SRCS+= backup_service.c
#SRCS+= base64.c
SRCS+= fdevent.c
SRCS+= file_sync_service.c
SRCS+= framebuffer_service.c
SRCS+= jdwp_service.c
SRCS+= log_service.c
SRCS+= remount_service.c
SRCS+= services.c
SRCS+= sockets.c
SRCS+= transport.c
SRCS+= transport_local.c
SRCS+= transport_usb.c
SRCS+= usb_linux_client.c
SRCS+= utils.c
SRCS+= env-props.c

VPATH+= $(SRCDIR)/core/libcutils
SRCS+= abort_socket.c
SRCS+= socket_inaddr_any_server.c
SRCS+= socket_local_client.c
SRCS+= socket_local_server.c
SRCS+= socket_loopback_client.c
SRCS+= socket_loopback_server.c
SRCS+= socket_network_client.c
SRCS+= list.c
SRCS+= load_file.c
SRCS+= android_reboot.c

VPATH+= $(SRCDIR)/core/libzipfile
SRCS+= centraldir.c
SRCS+= zipfile.c

VPATH+= $(SRCDIR)/bionic/libc/netbsd/net
SRC+= base64.c


CPPFLAGS+= -D_XOPEN_SOURCE -D_GNU_SOURCE
CPPFLAGS+= -DADB_HOST=0
CPPFLAGS+= -DHAVE_FORKEXEC=1
CPPFLAGS+= -DHAVE_SYMLINKS
CPPFLAGS+= -DHAVE_TERMIO_H
# XXX need to document why this is useful/needed
CPPFLAGS+= -DALLOW_ADBD_ROOT=1
CPPFLAGS+= -I$(SRCDIR)/core/adb
CPPFLAGS+= -I$(SRCDIR)/core/include
CPPFLAGS+= -I$(SRCDIR)/libhardware/include

LIBS+= -lc -lpthread -lz -lcrypto -lresolv

OBJS= $(SRCS:.c=.o)

all: adbd

adbd: $(OBJS)
	$(CC) -o $@ $(LDFLAGS) $(OBJS) $(LIBS)

clean:
	rm -rf $(OBJS) adbd
