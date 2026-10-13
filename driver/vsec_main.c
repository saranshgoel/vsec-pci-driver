#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include "vsec.h"

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Saransh");
MODULE_DESCRIPTION("Virtual Secure Storage Controller Driver");
MODULE_VERSION("0.1");

static int __init vsec_init(void)
{
    pr_info("vsec_blk: Initializing main driver module...\n");
    
    if (vsec_crypto_init() != 0)
        return -1;
        
    if (vsec_dma_init() != 0) {
        vsec_crypto_exit();
        return -1;
    }

    pr_info("vsec_blk: Driver loaded successfully across multiple files!\n");
    return 0;
}

static void __exit vsec_exit(void)
{
    vsec_dma_exit();
    vsec_crypto_exit();
    pr_info("vsec_blk: Driver Unloaded Cleanly\n");
}

module_init(vsec_init);
module_exit(vsec_exit);