//
//  FactsListViewModel.h
//  TelstraiOSTask
//
//  Created by PremNath on 3/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FactsDataModel.h"

@interface FactsListViewModel : NSObject

- (instancetype)initWithFactsDataModel:(FactsDataModel *)factsDataModel;
 // Declaration of Viewmodel Delegate methods
- (NSString *)titleFromDataModel;
- (NSUInteger)numberOfSectionsFromDataModel;
- (NSUInteger)numberOfRowsFromDataModel;
- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)imageAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)descriptionAtIndexPath:(NSIndexPath *)indexPath;

@end
