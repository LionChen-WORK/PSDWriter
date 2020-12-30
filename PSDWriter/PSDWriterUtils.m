//
//  PSDWriterUtils.m
//  PSDWriter
//
//  Created by Lion ChenZG on 2020/12/30.
//

#import "PSDWriterUtils.h"

NSData *CGImageGetData(CGImageRef image, CGRect region)
{
    // Create the bitmap context
    CGContextRef    context = NULL;
    void *            bitmapData;
    int                bitmapByteCount;
    int                bitmapBytesPerRow;

    // Get image width, height. We'll use the entire image.
    int width = region.size.width;
    int height = region.size.height;

    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow = (width * 4);
    bitmapByteCount    = (bitmapBytesPerRow * height);

    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    //    bitmapData = malloc(bitmapByteCount);
    bitmapData = calloc(width * height * 4, sizeof(Byte));
    if (bitmapData == NULL)
    {
        return nil;
    }

    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    //    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGColorSpaceRef colorspace = CGImageGetColorSpace(image);
    context = CGBitmapContextCreate(bitmapData, width, height, 8, bitmapBytesPerRow,
                                    colorspace, kCGImageAlphaPremultipliedLast);
    //    CGColorSpaceRelease(colorspace);

    if (context == NULL)
        // error creating context
        return nil;

    // Draw the image to the bitmap context. Once we draw, the memory
    // allocated for the context for rendering will then contain the
    // raw image data in the specified color space.
    CGContextSaveGState(context);

    //    CGContextTranslateCTM(context, -region.origin.x, -region.origin.y);
    //    CGContextDrawImage(context, region, image);

    // Draw the image without scaling it to fit the region
    CGRect drawRegion;
    drawRegion.origin = CGPointZero;
    drawRegion.size.width = CGImageGetWidth(image);
    drawRegion.size.height = CGImageGetHeight(image);
    CGContextTranslateCTM(context,
                          -region.origin.x + (drawRegion.size.width - region.size.width),
                          -region.origin.y - (drawRegion.size.height - region.size.height));
    CGContextDrawImage(context, drawRegion, image);
    CGContextRestoreGState(context);

    // When finished, release the context
    CGContextRelease(context);

    // Now we can get a pointer to the image data associated with the bitmap context.

    NSData *data = [NSData dataWithBytes:bitmapData length:bitmapByteCount];
    free(bitmapData);

    return data;
}
