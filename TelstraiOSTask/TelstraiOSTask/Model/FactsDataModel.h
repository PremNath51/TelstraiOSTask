//
//  FactsModel.h
//  TelstraiOSTask
//
//  Created by PremNath on 3/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FactsDataModel;
@class FactRow;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface FactsDataModel : NSObject
@property (nonatomic, nullable, copy) NSString *title;
@property (nonatomic, nullable, copy) NSArray<FactRow *> *rows;
// Declaration of NSURL Connection Delegate Methods
+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end
// Declaration of values to be binded
@interface FactRow : NSObject
@property (nonatomic, nullable, copy) NSString *title;
@property (nonatomic, nullable, copy) NSString *theDescription;
@property (nonatomic, nullable, copy) NSString *imageHref;
@end

NS_ASSUME_NONNULL_END

