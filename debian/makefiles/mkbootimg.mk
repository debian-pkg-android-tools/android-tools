# Makefile for mkbootimg

SRCDIR ?= $(CURDIR)

VPATH+= $(SRCDIR)/core/mkbootimg
SRCS+= mkbootimg.c

VPATH+= $(SRCDIR)/core/libmincrypt
SRCS+= sha.c

CPPFLAGS+= -std=gnu11
CPPFLAGS+= -I$(SRCDIR)/core/mkbootimg
CPPFLAGS+= -I$(SRCDIR)/core/include

LIBS+= -lc

OBJS= $(SRCS:.c=.o)

all: mkbootimg

mkbootimg: $(OBJS)
	$(CC) -o $@ $(LDFLAGS) $(OBJS) $(LIBS)

clean:
	rm -rf $(OBJS) mkbootimg
