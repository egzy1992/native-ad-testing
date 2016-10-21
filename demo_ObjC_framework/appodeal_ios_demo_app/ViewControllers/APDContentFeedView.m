//
//  APDContentFeedView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/14/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDContentFeedView.h"

@implementation APDContentFeedView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark --- CONSTRAIN

- (void) makeConstrain {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark --- PROPERTY

- (UITableView *) tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 100.0f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

@end
