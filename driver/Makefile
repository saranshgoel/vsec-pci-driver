obj-m += vsec_driver.o
vsec_driver-objs := vsec_main.o vsec_crypto.o vsec_dma.o

KDIR ?= /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

default:
	@mkdir -p build
	$(MAKE) -C $(KDIR) M=$(PWD) OUT_DIR=$(PWD)/build modules
	@mv -f *.o *.ko *.mod *.mod.c *.symvers *.order .*.cmd build/ 2>/dev/null || true

clean:
	rm -rf build/ *.o *.ko *.mod *.mod.c *.symvers *.order .*.cmd .tmp_versions