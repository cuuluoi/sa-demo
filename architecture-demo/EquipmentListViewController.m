//
//  EquipmentListViewController.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "EquipmentListViewController.h"
#import "EquipmentListCellInfo.h"
#import "EquipmentListCell.h"
#import "EquipmentListService.h"

@interface EquipmentListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *equipments;
@property (nonatomic, strong) EquipmentListService *service;

@property (nonatomic) NSInteger currentScrollIndex;

@end

@implementation EquipmentListViewController

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"currentScrollIndex"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _service = [[EquipmentListService alloc] init];
    
    __weak __typeof(self)weak = self;
    _service.equipmentListDidLoad = ^(EquipmentListService *sender) {
        __strong __typeof(weak)strong = weak;
        strong.equipments = sender.equipments;
        [strong.tableView reloadData];
        strong.title = sender.equipmentListTitle;
    };
    [_tableView registerNib:[UINib nibWithNibName:@"EquipmentListCell" bundle:nil]
     forCellReuseIdentifier:@"EquipmentList"];
    self.title = _service.equipmentListTitle;
    self.currentScrollIndex = 0;
    [self addObserver:self forKeyPath:@"currentScrollIndex" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_service loadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger val = 0;
    if (_equipments) {
        val = _equipments.count;
    }
    return val;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EquipmentListCellInfo *infoObject = [_equipments objectAtIndex:indexPath.row];
    EquipmentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EquipmentList"];
    [cell setInfoObject:infoObject];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray *visibleCell = [self.tableView indexPathsForVisibleRows];
    NSIndexPath *firstOject = [visibleCell lastObject];
    NSInteger firstRow = firstOject.row;
    if (firstRow != self.currentScrollIndex) {
        self.currentScrollIndex = firstRow;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"currentScrollIndex"]) {
        NSInteger newNumber = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        NSInteger oldNumber = [[change objectForKey:NSKeyValueChangeOldKey] integerValue];
        if (newNumber >= self.equipments.count - 30) {
            if (oldNumber < newNumber) {
                [_service loadMoreEquipment];
            }
        }
    }
}

@end
