//
//  APDViewModel.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDViewModel.h"

UIButton * k_apd_mainButtonWithTitle (NSString * title) {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    NSAttributedString * attrString = k_apd_mainAttributedFromMainButton(title);
    [button setAttributedTitle:attrString forState:UIControlStateNormal];
    
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 4.0f;
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = UIColor.lightGrayColor.CGColor;
    
    return button;
}

NSAttributedString * k_apd_mainAttributedFromMainButton(NSString * string){
    return [[NSAttributedString alloc] initWithString:string
                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f weight:UIFontWeightLight],
                                                        NSKernAttributeName : @(2.0),
                                                        NSForegroundColorAttributeName : UIColor.lightGrayColor}];
}

@implementation APDViewModel

+ (void) logWithString:(NSString *)string {
    NSLog(@"%@", string);
}

@end


@implementation DescriptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    return self;
}

@end
