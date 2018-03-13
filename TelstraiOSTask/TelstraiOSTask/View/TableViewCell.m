//
//  TableViewCell.m
//  TelstraiOSTask
//
//  Created by PremNath on 10/3/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImage+Extension.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface TableViewCell ()<SDWebImageManagerDelegate>

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, copy) NSString *imageRef;
@property (nonatomic, weak) UIImageView *itemImageView;
@property (nonatomic, weak) UILabel *itemLabel;
@end

// Creating constraints programatically for TableViewCell

@implementation TableViewCell

const int PADDING = 7;

#pragma mark - Initializing the Table view UI controls

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.clipsToBounds = NO;
        
        UILabel *label = [UILabel new];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:label];
        self.titleLabel = label;
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        self.titleLabel.numberOfLines = 0;

        UIImageView *itemImageView = [UIImageView new];
        [self.contentView addSubview:itemImageView];
        self.itemImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.itemImageView = itemImageView;
        
        UILabel *itemLabel = [UILabel new];
        itemLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:itemLabel];
        self.itemLabel = itemLabel;
        self.itemLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.itemLabel.numberOfLines = 0;

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(PADDING);
            make.left.equalTo(self.contentView.mas_left).offset(PADDING);
            make.right.equalTo(self.contentView.mas_right).offset(-PADDING);
        }];
        
        [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(PADDING);
            make.right.equalTo(self.contentView.mas_right).offset(-PADDING);
            make.bottom.greaterThanOrEqualTo(self.contentView.mas_bottom).with.priorityLow();
            make.height.equalTo(@80);
            make.width.equalTo(@80);
        }];

        [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(PADDING);
            make.left.equalTo(self.contentView.mas_left).offset(PADDING);
            make.right.equalTo(self.itemImageView.mas_left).offset(-PADDING);
            make.height.greaterThanOrEqualTo(self.itemImageView.mas_height);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}

- (void)initialise {
    self.titleLabel.text = nil;
    self.itemLabel.text = nil;
    self.imageRef = nil;
    self.itemImageView.image = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.separatorInset = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = false;
    // Initialization code
    [self initialise];
}
#pragma mark - TableView overridden methods

- (void)prepareForReuse {
    [super prepareForReuse];
    [self initialise];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.contentView layoutIfNeeded];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    //according to apple super should be called at end of method
    [super updateConstraints];
}

#pragma mark - Binding the Data to the Table view cell

// Binding Data to Title Text

- (void) setTitleLabelText:(NSString *)text {
    if (text == nil) {
        self.titleLabel.text = @"No Title";
    } else {
        self.titleLabel.text = text;
    }
    [self.titleLabel sizeToFit];
}
// Binding Data to Description Text

- (void) setItemLabelText:(NSString *)text {
    if (text == nil) {
        self.itemLabel.text = @"No Description";
    } else {
        self.itemLabel.text = text;
    }
    [self.itemLabel sizeToFit];
}
// Binding Data to Image View

- (void) setImageRef:(NSString *)imageRef {
    NSLog(@"image ref %@",imageRef);
    if (imageRef == nil || !(imageRef.length > 0)) {
        self.itemImageView.image = [[UIImage imageNamed:@"placeholder.png"] resizeImageToSize:CGSizeMake(80.f, 80.f)];
    } else {
        __weak TableViewCell *weakCell = self;
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageRef] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image == nil) {
                weakCell.itemImageView.image = [[UIImage imageNamed:@"placeholder.png"] resizeImageToSize:CGSizeMake(80.f, 80.f)];
            }
            weakCell.itemImageView.image = [image resizeImageToSize:CGSizeMake(80.f, 80.f)];
            
        }];
    }
}

@end
