//
//  UIImage+Extension.m
//  TelstraiOSTask
//
//  Created by PremNath on 10/3/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extensions)

+ (UIImage *)emptyImageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)resizeImageToSize:(CGSize)size {
    CGRect frame      = CGRectZero;
    frame.size        = self.size;
    CGFloat scale     = fminf(size.width/frame.size.width, size.height/frame.size.height);
    frame.size.width  = fminf(size.width, ceilf(scale * frame.size.width));
    frame.size.height = fminf(size.height, ceilf(scale * frame.size.height));
    frame.origin.x    = (size.width - frame.size.width)/2.f;
    frame.origin.y    = (size.height - frame.size.height)/2.f;
    
    UIGraphicsBeginImageContext(size);
    [self drawInRect:frame];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
