//
//  APDHelperTableView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/8/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDHelperTableView.h"

@implementation APDHelperTableView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark --- CONSTRAIN

- (void) updateConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}

#pragma mark --- PROPERTY

- (UITableView *) tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
