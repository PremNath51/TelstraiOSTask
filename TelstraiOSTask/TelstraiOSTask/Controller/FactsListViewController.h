//
//  ViewController.h
//  TelstraiOSTask
//
//  Created by PremNath on 09/03/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FactsListViewModel.h"

@interface FactsListViewController : UITableViewController

// Declaration of Viewmodel to download the data from internet

- (instancetype)initWithViewModel:(FactsListViewModel *)viewModel;
- (void)tellClassName;

@end

