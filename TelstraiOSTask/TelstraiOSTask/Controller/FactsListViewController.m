//
//  ViewController.m
//  TelstraiOSTask
//
//  Created by PremNath on 09/03/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import "FactsListViewController.h"
#import "TableViewCell.h"
#import "NetworkManager.h"
#import "FactsDataModel.h"
#import "AppDelegate.h"

@interface FactsListViewController ()

@property (nonatomic, strong, readonly) FactsListViewModel *viewModel;

@end

@implementation FactsListViewController

#pragma mark - FactsListViewController

- (instancetype)initWithViewModel:(FactsListViewModel *)viewModel {
    self = [super initWithStyle:UITableViewStylePlain];
    if (!self) return nil;
    _viewModel = viewModel;
    
    return self;
}

#pragma mark - Unit testing XCtest case

- (void)tellClassName {
    NSLog(@"this is Table_design_view");
}
#pragma mark - Overridden methods implementation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.viewModel.titleFromDataModel;
    [self createRefreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
#pragma mark - Creating Refresh control methods

- (void)createRefreshControl {
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [refreshControl addTarget:self action:@selector(performRefresh) forControlEvents:(UIControlEventValueChanged)];
    refreshControl.tintColor = [UIColor orangeColor];
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:NSStringFromClass([TableViewCell class])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = YES;
    self.tableView.clipsToBounds = NO;
    self.tableView.allowsSelection = NO;
    self.tableView.estimatedSectionHeaderHeight = 0.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 85.f;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.contentInset = UIEdgeInsetsMake(10.f, 0.f, 10.f, 0.f);
}

#pragma mark - FactListController Refresh delegate methods

- (void)performRefresh {
    [self.refreshControl beginRefreshing];
    [self refreshData];
    return;
}

-(void)refreshData {
    AppDelegate *appDelegate=( AppDelegate* )[UIApplication sharedApplication].delegate;
    [appDelegate getFactsData ];
    [self.refreshControl endRefreshing];
}

- (void)updateUI {
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

#pragma mark - Table View delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.numberOfSectionsFromDataModel;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfRowsFromDataModel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableViewCell class])
                                                          forIndexPath:indexPath];
    cell.titleLabelText = [self.viewModel titleAtIndexPath:indexPath];
    cell.itemLabelText = [self.viewModel descriptionAtIndexPath:indexPath];
    cell.imageRef = [self.viewModel imageAtIndexPath:indexPath];
    return cell;
}


@end
