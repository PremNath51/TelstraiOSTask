//
//  TelstraiOSTaskTests.m
//  TelstraiOSTaskTests
//
//  Created by PremNath on 09/03/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkManager.h"
#import "FactsListViewModel.h"
#import "FactsListViewController.h"
#import "AppDelegate.h"

@interface TelstraiOSTaskTests : XCTestCase

@property (nonatomic, strong) FactsListViewModel *viewModel;
@end

@implementation TelstraiOSTaskTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCheckClassCall {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    FactsListViewController *m = [[FactsListViewController alloc] initWithViewModel:self.viewModel];
    [m tellClassName];
    
    XCTAssertTrue([[m tableView] isMemberOfClass:[UITableView class]]);
    NSBundle *bundle = [NSBundle bundleForClass:[FactsListViewController class]];
    NSBundle *main = [NSBundle mainBundle];
    NSLog(@"%@ ============ %@", bundle, main);
}

- (void)testServiceCall{
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [[NetworkManager sharedManager] getFactsWithSuccess:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSHTTPURLResponse class]]) {
            NSInteger statusCode = [(NSHTTPURLResponse *) responseObject statusCode];
            XCTAssertEqual(statusCode, 200, @"Status is not 200 %ld", statusCode);
        }
        XCTAssert(responseObject, @"data nil");
        
        // do additional tests on the contents of the `data` object here, if you want
        
        // when all done, signal the semaphore
        
        dispatch_semaphore_signal(semaphore);
        
        
    } failure:^(NSString *failureReason, NSInteger statusCode) {
        // error handling here ...
        NSLog(@"%@",failureReason);
        XCTAssertNil(failureReason, @"dataTaskWithURL error %@", failureReason);
        
        
    }];
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
