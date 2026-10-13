#include <linux/module.h>
#include <linux/printk.h>
#include "vsec.h"

int vsec_dma_init(void) {
    pr_info("vsec_blk: DMA submodule initialized\n");
    return 0;
}

void vsec_dma_exit(void) {
    pr_info("vsec_blk: DMA submodule exited\n");
}