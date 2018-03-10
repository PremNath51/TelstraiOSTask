//
//  NetworkManager.h
//  TelstraiOSTask
//
//  Created by PremNath on 3/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetworkManagerSuccess)(id responseObject);
typedef void (^NetworkManagerFailure)(NSString *failureReason, NSInteger statusCode);

@interface NetworkManager : NSObject
// GET JSON Method Declaration
+ (id)sharedManager;
- (void)getFactsWithSuccess:(NetworkManagerSuccess)success failure:(NetworkManagerFailure)failure;


@end
