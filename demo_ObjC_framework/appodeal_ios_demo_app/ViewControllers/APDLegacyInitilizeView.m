//
//  APDLegacyInitilizeView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDLegacyInitilizeView.h"

@implementation APDLegacyInitilizeView

- (instancetype) initWithFrame:(CGRect)frame{
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
        _tableView.scrollEnabled = YES;
        _tableView.estimatedRowHeight = 44.0f;
        _tableView.estimatedSectionHeaderHeight = 44.0f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

#pragma mark --- HEADER_VIEW

-(UIView *) headerView:(NSString *)title tintColor:(UIColor *)tintColor fontSize:(CGFloat)fontSize backgroundColor:(UIColor *)backgroundColor{
    UILabel * newLabel = [UILabel new];
    UIView * view = [UIView new];
    view.backgroundColor = backgroundColor;
    
    {
        [view addSubview:newLabel];
    }
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: tintColor,
                                 NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize],
                                 NSKernAttributeName: @2};
    newLabel.attributedText = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    
    [newLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).with.offset(25);
        make.left.equalTo(view).with.offset(15);
        make.right.equalTo(view).with.offset(5);
        make.bottom.equalTo(view).with.offset(-2);
    }];
    
    return view;
}

@end
