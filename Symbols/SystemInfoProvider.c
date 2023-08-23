//
//  SystemInfoProvider.c
//  Symbols
//
//  Created by xiong有都 on 2023/8/4.
//

#include "SystemInfoProvider.h"
#include <stdio.h>
#include <unistd.h>

int global_var = 42;

int getPidInfo(void) {
    pid_t pid = getpid();
    return pid;
}

int increamentCount(void) {
    int static counter = 0;
    counter ++;
    return counter;
}
