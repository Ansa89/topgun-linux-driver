PWD   := $(shell pwd)
KVER  ?= $(shell uname -r)
KDIR  := /lib/modules/$(KVER)/build
obj-m := lcdtopgun.o

lcdtopgun.ko:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

.PHONY: all clean install

all: lcdtopgun.ko

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean

install: lcdtopgun.ko
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules_install
	depmod -F$(KDIR)/System.map -ae $(KVER)
