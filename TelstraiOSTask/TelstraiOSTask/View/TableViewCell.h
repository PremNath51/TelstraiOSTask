//
//  TableViewCell.h
//  TelstraiOSTask
//
//  Created by PremNath on 10/3/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

- (void) setTitleLabelText:(NSString *)text;
- (void) setImageRef:(NSString *)imageRef;
- (void) setItemLabelText:(NSString *)text;

@end
