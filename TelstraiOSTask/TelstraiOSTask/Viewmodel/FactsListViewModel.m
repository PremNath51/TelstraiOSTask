//
//  FactsListViewModel.m
//  TelstraiOSTask
//
//  Created by PremNath on 3/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import "FactsListViewModel.h"
#import <UIKit/UIKit.h>

@interface FactsListViewModel ()

@property (nonatomic, strong, readonly) FactsDataModel *factsDataModel;

@end


@implementation FactsListViewModel

#pragma mark - FactsListViewModel overridden methods

- (instancetype)initWithFactsDataModel:(FactsDataModel *)factsDataModel {
    self = [super init];
    if (!self) return nil;
        _factsDataModel = factsDataModel;
    return self;
}

- (NSString *)titleFromDataModel {
    return self.factsDataModel.title;

}
- (NSUInteger)numberOfSectionsFromDataModel {
    return 1;

}
- (NSUInteger)numberOfRowsFromDataModel {
    return self.factsDataModel.rows.count;
}

#pragma mark - Data Source Binding to the collection

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    FactRow* rowItem = [self factRowsAtIndexPath:indexPath];
    return rowItem.title;
}
- (NSString *)imageAtIndexPath:(NSIndexPath *)indexPath {
    FactRow* rowItem = [self factRowsAtIndexPath:indexPath];
    return rowItem.imageHref;

}
- (NSString *)descriptionAtIndexPath:(NSIndexPath *)indexPath {
    FactRow* rowItem = [self factRowsAtIndexPath:indexPath];
    return rowItem.theDescription;
}

- (FactRow *)factRowsAtIndexPath:(NSIndexPath *)indexPath {
    return [self.factsDataModel.rows objectAtIndex:indexPath.row];
}

@end
