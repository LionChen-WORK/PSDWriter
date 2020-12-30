//
//  PSDWriterUtils.h
//  PSDWriter
//
//  Created by Lion ChenZG on 2020/12/30.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif

/** A convenience function for getting RGBA NSData from a CGImageRef. */
NSData *CGImageGetData(CGImageRef image, CGRect region);
