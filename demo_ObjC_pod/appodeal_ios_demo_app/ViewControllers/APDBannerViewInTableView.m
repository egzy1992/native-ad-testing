//
//  APDBannerViewInTableView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/13/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBannerViewInTableView.h"

@implementation APDBannerViewInTableView

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark --- CONSTRAIN

- (void) updateConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}

#pragma mark --- PROPERY

-(UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.estimatedRowHeight = IS_IPAD ? 90.0f : 50.0f;
        _tableView.estimatedSectionHeaderHeight = IS_IPAD ? 90.0f : 50.0f;
        _tableView.estimatedSectionFooterHeight = IS_IPAD ? 90.0f : 50.0f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        _tableView.sectionFooterHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

@end
