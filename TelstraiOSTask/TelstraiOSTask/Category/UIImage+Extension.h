//
//  NSObject+UIImage_Extension.h
//  TelstraiOSTask
//
//  Created by PremNath on 10/3/18.
//  Copyright © 2018 Wipro. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIImage (Extensions)

+ (UIImage *)emptyImageWithSize:(CGSize)size;
- (UIImage *)resizeImageToSize:(CGSize)size;

@end
