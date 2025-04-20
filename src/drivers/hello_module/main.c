#include <linux/init.h>
#include <linux/module.h>

#include "logging/logging.h"

MODULE_LICENSE("Dual BSD/GPL");

static int __init hello_init(void)
{
    KLOG_FATAL("Hello, world\n");
    return 0;
}

static void __exit hello_exit(void)
{
    KLOG_FATAL("Goodbye, cruel world\n");
}

module_init(hello_init);
module_exit(hello_exit);

