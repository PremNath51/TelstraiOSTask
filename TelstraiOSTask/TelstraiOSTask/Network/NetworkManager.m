//
//  NetworkManager.m
//  TelstraiOSTask
//
//  Created by PremNath on 3/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import "NetworkManager.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

#define BASE_URL @"https://dl.dropboxusercontent.com"

@interface NetworkManager()
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) AFHTTPSessionManager *networkingManager;

@end

@implementation NetworkManager

#pragma mark -
#pragma mark Constructors

static NetworkManager *sharedManager = nil;
- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

+ (NetworkManager*)sharedManager {
    static dispatch_once_t once;
    dispatch_once(&once, ^
                  {
                      sharedManager = [[NetworkManager alloc] init];
                  });
    return sharedManager;
}

- (void)showProgressHUD {
    [self hideProgressHUD];
    self.progressHUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] delegate].window animated:YES];
    [self.progressHUD removeFromSuperViewOnHide];
    self.progressHUD.bezelView.color = [UIColor colorWithWhite:0.0 alpha:1.0];
    self.progressHUD.contentColor = [UIColor whiteColor];
}

- (void)hideProgressHUD {
    if (self.progressHUD != nil) {
        [self.progressHUD hideAnimated:YES];
        [self.progressHUD removeFromSuperview];
        self.progressHUD = nil;
    }
}

- (AFHTTPSessionManager*)getNetworkingManagerWithURL{
    if (self.networkingManager == nil) {
        self.networkingManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        self.networkingManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.networkingManager.responseSerializer = [AFHTTPResponseSerializer serializer];

        self.networkingManager.responseSerializer.acceptableContentTypes = [self.networkingManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html", @"application/json", @"text/json", @"text/plain"]];
        self.networkingManager.securityPolicy = [self getSecurityPolicy];
    }
    return self.networkingManager;
}

- (id)getSecurityPolicy {
    return [AFSecurityPolicy defaultPolicy];
}

- (NSString*)getError:(NSError*)error {
    if (error != nil) {
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        if (responseObject != nil && [responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"message"] != nil && [[responseObject objectForKey:@"message"] length] > 0) {
            return [responseObject objectForKey:@"message"];
        }
    }
    return @"Server Error. Please try again later";
}
// completionBlock will use to check if parsing is done or any error.

- (void)getFactsWithSuccess:(NetworkManagerSuccess)success failure:(NetworkManagerFailure)failure {
    [self showProgressHUD];
    // Asynchronously API is hit here
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [[self getNetworkingManagerWithURL] GET:@"/s/2iodh4vg0eortkl/facts.json" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self hideProgressHUD];
        if (success != nil) {
            success(responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self hideProgressHUD];
        NSString *errorMessage = [self getError:error];
        if (failure != nil) {
            failure(errorMessage, ((NSHTTPURLResponse*)operation.response).statusCode);
        }
    }];
}
@end

