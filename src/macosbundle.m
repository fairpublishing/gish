#include <unistd.h>
#include <string.h>

#import <Foundation/Foundation.h>

void chdir_macos_bundle_resources()
{ @autoreleasepool
{
    NSString* resource_path = [[NSBundle mainBundle] resourcePath];
    const char *path_utf8 = [resource_path UTF8String];
    chdir(path_utf8);
}}

