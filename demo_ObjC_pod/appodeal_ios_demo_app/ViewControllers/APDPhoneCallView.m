//
//  APDPhoneCallView.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/25/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDPhoneCallView.h"

@interface APDPhoneCallView ()
{
    
}

@property (nonatomic, strong) UITextField * phoneNumberFill;
@property (nonatomic, strong) UIButton * callButton;

@end

@implementation APDPhoneCallView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        {
            [self addSubview:self.phoneNumberFill];
            [self addSubview:self.callButton];
        }
        
        {
            UITapGestureRecognizer * hideKeyBoardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHide)];
            self.userInteractionEnabled = YES;
            [self addGestureRecognizer:hideKeyBoardTap];
        }
    }
    return self;
}

- (void) updateConstraints{
    
    [self.phoneNumberFill mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).with.offset(-40);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.callButton.mas_top).with.offset(-20);
        make.centerX.equalTo(self);
    }];
    
    [self.callButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.callButton.mas_top).with.offset(-20);
        make.center.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark --- PROPERTY

-(UITextField *) phoneNumberFill{
    if (!_phoneNumberFill) {
        _phoneNumberFill = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) - 40, 40)];
        _phoneNumberFill.textColor = UIColor.grayColor;
        _phoneNumberFill.layer.cornerRadius = 5.0f;
        _phoneNumberFill.layer.borderWidth = 1.0f;
        _phoneNumberFill.layer.borderColor = UIColor.redColor.CGColor;
        _phoneNumberFill.font = [UIFont systemFontOfSize:27.0f weight:UIFontWeightLight];
        _phoneNumberFill.textAlignment = NSTextAlignmentCenter;
        _phoneNumberFill.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneNumberFill;
}

- (UIButton *) callButton{
    if (!_callButton) {
        _callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_callButton setAttributedTitle:[[NSAttributedString alloc] initWithString:[NSLocalizedString(@"call", nil) uppercaseString]
                                                                        attributes:@{
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:16 weight:UIFontWeightLight],
                                                                                     NSKernAttributeName : @(3.0),
                                                                                     NSForegroundColorAttributeName : UIColor.redColor}] forState:UIControlStateNormal];

        _callButton.layer.borderColor = UIColor.redColor.CGColor;
        _callButton.layer.borderWidth = 1.0f;
        _callButton.layer.cornerRadius = 5.0;
        [_callButton addTarget:self action:@selector(phoneCall:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callButton;
}

#pragma mark --- METHODS

- (void) keyBoardHide {
    [_phoneNumberFill resignFirstResponder];
}

#pragma mark --- ACTIONS

- (IBAction)phoneCall:(id)sender{
    if (self.phoneNumberFill.text && ![self.phoneNumberFill.text isEqualToString:@""]) {
        NSURL * teleUrl = [NSURL URLWithString:[@"tel://" stringByAppendingString:self.phoneNumberFill.text]];
        [[UIApplication sharedApplication] openURL:teleUrl];
    }
}

@end
