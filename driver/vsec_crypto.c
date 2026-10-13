#include <linux/module.h>
#include <linux/printk.h>
#include "vsec.h"

int vsec_crypto_init(void) {
    pr_info("vsec_blk: Crypto submodule initialized\n");
    return 0;
}

void vsec_crypto_exit(void) {
    pr_info("vsec_blk: Crypto submodule exited\n");
}