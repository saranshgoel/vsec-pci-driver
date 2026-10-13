#ifndef VSEC_H
#define VSEC_H

#include <linux/types.h>
#include <linux/pci.h>

// Shared device state structure if needed across files
struct vsec_dev {
    void __iomem *bar0_addr;
    struct pci_dev *pdev;
    // Add crypto or DMA specific fields here
};

// Function prototypes exposed by vsec_crypto.c
int vsec_crypto_init(void);
void vsec_crypto_exit(void);

// Function prototypes exposed by vsec_dma.c
int vsec_dma_init(void);
void vsec_dma_exit(void);

#endif /* VSEC_H */