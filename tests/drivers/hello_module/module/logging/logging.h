#ifndef _HELLO_MODULE_LOGGING_H
#define _HELLO_MODULE_LOGGING_H

#include <linux/kern_levels.h>

#define LVL_DEBUG   KERN_DEBUG
#define LVL_INFO    KERN_INFO
#define LVL_WARN    KERN_WARNING
#define LVL_ERROR   KERN_ERR
#define LVL_FATAL   KERN_ALERT


#define LOG_DEBUG(logger, fmt, args...)
#define LOG_INFO(logger, fmt, args...)
#define LOG_WARN(logger, fmt, args...)
#define LOG_ERROR(logger, fmt, args...)
#define LOG_FATAL(logger, msg)

#define KLOG_DEBUG(fmt, args...)
#define KLOG_INFO(fmt, args...)
#define KLOG_WARN(fmt, args...)
#define KLOG_ERROR(fmt, args...)
#define KLOG_FATAL(fmt, args...)


#define LOGGER_USE_DEBUG_LEVEL

#if defined(LOGGER_USE_DEBUG_LEVEL)
    #if ! defined(LVL_DEBUG)
        #error "Macro 'LVL_DEBUG' is not defined"
    #endif
    #if ! defined(LOGGER_USE_INFO_LEVEL)
        #define LOGGER_USE_INFO_LEVEL
    #endif
    #undef LOG_DEBUG
    #undef KLOG_DEBUG
#endif
#if defined(LOGGER_USE_INFO_LEVEL)
    #if ! defined(LVL_INFO)
        #error "Macro 'LVL_INFO' is not defined"
    #endif
    #if ! defined(LOGGER_USE_WARNING_LEVEL)
        #define LOGGER_USE_WARNING_LEVEL
    #endif
    #undef LOG_INFO
    #undef KLOG_INFO
#endif
#if defined(LOGGER_USE_WARN_LEVEL)
    #if ! defined(LVL_WARN)
        #error "Macro 'LVL_WARN' is not defined"
    #endif
    #if ! defined(LOGGER_USE_ERROR_LEVEL)
        #define LOGGER_USE_ERROR_LEVEL
    #endif
    #undef LOG_WARN
    #undef KLOG_WARN
#endif
#if defined(LOGGER_USE_ERROR_LEVEL)
    #if ! defined(LVL_ERROR)
        #error "Macro 'LVL_ERROR' is not defined"
    #endif
    #if ! defined(LOGGER_USE_FATAL_LEVEL)
        #define LOGGER_USE_FATAL_LEVEL
    #endif
    #undef LOG_ERROR
    #undef KLOG_ERROR
#endif
#if defined(LOGGER_USE_FATAL_LEVEL)
    #if ! defined(LVL_FATAL)
        #error "Macro 'LVL_FATAL' is not defined"
    #endif
    #undef LOG_FATAL
    #undef KLOG_FATAL
#endif


#define _LOGGER_CAN_LOG(logger, level)  true

#define _PLOG_IMPL(logger, level, fmt, args...) \
    logger(level fmt, ## args)


#define _LOG(logger, level, fmt, args...)) \
    do { \
        if (! _LOGGER_CAN_LOG(logger, level)) { \
            break; \
        } \
        _LOG_IMPL(logger, level, fmt, args...); \
    } \
    while (0)


#if defined(LOGGER_USE_DEBUG_LEVEL)
    #define LOG_DEBUG(logger, fmt, args...)  _LOG(logger, LVL_DEBUG, fmt, args...)
#endif

#if defined(LOGGER_USE_INFO_LEVEL)
    #define LOG_INFO(logger, fmt, args...)   _LOG(logger, LVL_INFO, fmt, args...)
#endif

#if defined(LOGGER_USE_WARN_LEVEL)
    #define LOG_WARN(logger, fmt, args...)   _LOG(logger, LVL_WARN, fmt, args...)
#endif

#if defined(LOGGER_USE_ERROR_LEVEL)
    #define LOG_ERROR(logger, fmt, args...)  _LOG(logger, LOG_ERROR, fmt, args...)
#endif

#if defined(LOGGER_USE_FATAL_LEVEL)
    #define LOG_FATAL(logger, fmt, args...)  _LOG(logger, LVL_FATAL, fmt, args...)
#endif

#if __KERNEL__
    #if defined(LOGGER_USE_DEBUG_LEVEL)
        #define KLOG_DEBUG(fmt, args...)  _LOG(printk, LVL_DEBUG, fmt, args...)
    #endif

    #if defined(LOGGER_USE_INFO_LEVEL)
        #define KLOG_INFO(fmt, args...)   _LOG(printk, LVL_INFO, fmt, args...)
    #endif

    #if defined(LOGGER_USE_WARN_LEVEL)
        #define KLOG_WARN(fmt, args...)   _LOG(printk, LVL_WARN, fmt, args...)
    #endif

    #if defined(LOGGER_USE_ERROR_LEVEL)
        #define KLOG_ERROR(fmt, args...)  _LOG(printk, LOG_ERROR, fmt, args...)
    #endif

    #if defined(LOGGER_USE_FATAL_LEVEL)
        #define KLOG_FATAL(fmt, args...)  _LOG(printk, LVL_FATAL, fmt, args...)
    #endif
#endif

#endif /* _HELLO_MODULE_LOGGING_H */

