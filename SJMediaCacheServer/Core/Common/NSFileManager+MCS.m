//
//  NSFileManager+MCS.m
//  SJMediaCacheServer
//
//  Created by BlueDancer on 2020/11/26.
//

#import "NSFileManager+MCS.h"

@implementation NSFileManager (MCS)

- (unsigned long long)mcs_fileSizeAtPath:(NSString *)path {
    return path.length != 0 ? [NSFileManager.defaultManager attributesOfItemAtPath:path error:NULL].fileSize : 0;
}

- (unsigned long long)mcs_directorySizeAtPath:(NSString *)path {
    if ( path.length == 0 )
        return 0;
    NSUInteger size = 0;
    for ( NSString *subpath in [NSFileManager.defaultManager subpathsAtPath:path] )
        size += [self mcs_fileSizeAtPath:[path stringByAppendingPathComponent:subpath]];
    return size;
}

- (unsigned long long)mcs_freeDiskSpace {
    return [[self attributesOfFileSystemForPath:NSHomeDirectory() error:NULL][NSFileSystemFreeSize] unsignedLongLongValue];
}

@end
