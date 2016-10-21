//
//  APDAudioRecordingView.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/24/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDAudioRecordingView.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface APDAudioRecordingView () <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    NSTimer * timer;
    AVAudioRecorder * recorder;
    AVAudioPlayer * player;
    NSMutableArray * arrayListOfRecordSound;
}

@property (nonatomic, strong) UIButton * startRecordingButton;
@property (nonatomic, strong) UIButton * stopRecordingButton;
@property (nonatomic, strong) UIButton * playRecordingButton;
@property (nonatomic, strong) UILabel * timerLabel;

@end

@implementation APDAudioRecordingView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        {
            [self addSubview:self.startRecordingButton];
            [self addSubview:self.playRecordingButton];
            [self addSubview:self.stopRecordingButton];
            [self addSubview:self.timerLabel];
        }
    }
    return self;
}

- (void)updateConstraints {
    
    [self.startRecordingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.and.height.equalTo(@50);
    }];
    [self.playRecordingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startRecordingButton);
        make.right.equalTo(self.startRecordingButton.mas_left).with.offset(-10);
        make.width.and.height.equalTo(@30);
    }];
    [self.stopRecordingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startRecordingButton);
        make.left.equalTo(self.startRecordingButton.mas_right).with.offset(10);
        make.width.and.height.equalTo(@30);
    }];
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.startRecordingButton.mas_top).with.offset(-20);
        make.centerX.equalTo(self);
        make.width.equalTo(@200);
    }];
    
    [super updateConstraints];
}

-(void)deadLock{
    [self stopRecording];
}

#pragma mark --- PROPERTY

-(UILabel * )timerLabel {
    if (!_timerLabel) {
        _timerLabel = [UILabel new];
        _timerLabel.textAlignment = NSTextAlignmentCenter;
        _timerLabel.font = [UIFont systemFontOfSize:80.0f weight:UIFontWeightLight];
        _timerLabel.textColor = UIColor.lightGrayColor;
        
        _timerLabel.text = @"0:00";
    }
    return _timerLabel;
}

- (UIButton *) startRecordingButton {
    if (!_startRecordingButton) {
        _startRecordingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _startRecordingButton.layer.cornerRadius = 5.0;
        _startRecordingButton.clipsToBounds = YES;
        [_startRecordingButton setBackgroundImage:[UIImage imageNamed:@"startRecording"] forState:UIControlStateNormal];
        [_startRecordingButton setBackgroundImage:[UIImage imageNamed:@"stopRecording"] forState:UIControlStateSelected];
        _startRecordingButton.backgroundColor = UIColor.clearColor;
        
        [_startRecordingButton addTarget:self action:@selector(startRecording:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startRecordingButton;
}

- (UIButton *) stopRecordingButton {
    if (!_stopRecordingButton) {
        _stopRecordingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _stopRecordingButton.layer.cornerRadius = 5.0;
        _stopRecordingButton.clipsToBounds = YES;
        [_stopRecordingButton setBackgroundImage:[UIImage imageNamed:@"saveRecording"] forState:UIControlStateNormal];
        [_stopRecordingButton setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        _stopRecordingButton.backgroundColor = UIColor.clearColor;
        
        [_stopRecordingButton addTarget:self action:@selector(stopRecording) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopRecordingButton;
}

- (UIButton *) playRecordingButton {
    if (!_playRecordingButton) {
        _playRecordingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playRecordingButton.layer.cornerRadius = 5.0;
        _playRecordingButton.clipsToBounds = YES;
        [_playRecordingButton setBackgroundImage:[UIImage imageNamed:@"playRecordingFilled"] forState:UIControlStateNormal];
        [_playRecordingButton setBackgroundImage:[UIImage imageNamed:@"pauseRecordingFilled"] forState:UIControlStateSelected];
        _playRecordingButton.backgroundColor = UIColor.clearColor;
        
        [_playRecordingButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playRecordingButton;
}

#pragma mark --- ACTIONS

- (IBAction)startRecording:(id)sender{
    [self disableButton];
    
    if (self.startRecordingButton.selected) {
        [self pauseRecording];
        self.startRecordingButton.selected = NO;
        return;
    }
    
    if (recorder.currentTime > 0.0) {
        [self continueRecording];
        self.startRecordingButton.selected = YES;
        return;
    }
    
    if ([self startAudioSession]){
        [self record];
    }
}

#pragma mark --- PRIVATE


- (void) disableButton{
    if (!self.startRecordingButton.selected) {
        self.playRecordingButton.enabled = NO;
        self.stopRecordingButton.enabled = NO;
        return;
    }
    
    self.playRecordingButton.enabled = YES;
    self.stopRecordingButton.enabled = YES;
}

- (NSString *) dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    return [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".aif"];
}

- (BOOL) startAudioSession{
    NSError *error;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    if (![session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error])
    {
        NSLog(@"Error setting session category: %@", error.localizedFailureReason);
        return NO;
    }
    
    
    if (![session setActive:YES error:&error])
    {
        NSLog(@"Error activating audio session: %@", error.localizedFailureReason);
        return NO;
    }
    
    return YES;
}

- (BOOL) record{
    self.startRecordingButton.selected = YES;
    
    NSError *error;
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    
    [settings setValue: [NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [settings setValue: [NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];
    [settings setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
    [settings setValue: [NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    [settings setValue:  [NSNumber numberWithInt: AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
    
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath_ = [searchPaths objectAtIndex: 0];
    
    NSString *pathToSave = [documentPath_ stringByAppendingPathComponent:[self dateString]];
    
    NSURL *url = [NSURL fileURLWithPath:pathToSave];//FILEPATH];

    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if (!recorder)
    {
        NSLog(@"Error establishing recorder: %@", error.localizedFailureReason);
        return NO;
    }
    
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    self.timerLabel.text = @"0:00";
    
    if (![recorder prepareToRecord])
    {
        NSLog(@"Error: Prepare to record failed");
        return NO;
    }
    
    if (![recorder record])
    {
        NSLog(@"Error: Record failed");
        return NO;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
    
    return YES;
}

- (void)updateMeters{
    self.timerLabel.text = [NSString stringWithFormat:@"%3.0f:%i",recorder.currentTime, (int)(recorder.currentTime * 100) % 100];
}

-(void)play {
    if (self.playRecordingButton.selected) {
        self.playRecordingButton.selected = NO;
        [player stop];
        return;
    }
    
    self.playRecordingButton.selected = YES;
    
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath_ = [searchPaths objectAtIndex: 0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
//    if ([fileManager fileExistsAtPath:[self recordingFolder]])
//    {
    
        arrayListOfRecordSound=[[NSMutableArray alloc]initWithArray:[fileManager  contentsOfDirectoryAtPath:documentPath_ error:nil]];
        
        NSLog(@"====%@",arrayListOfRecordSound);
        
//    }
    
    if ([arrayListOfRecordSound count]) {
        NSString  *selectedSound =  [documentPath_ stringByAppendingPathComponent:[arrayListOfRecordSound objectAtIndex:0]];
        
        NSURL   *url =[NSURL fileURLWithPath:selectedSound];
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    }
    
    
    if (!player)
    {
        return;
    }
    
    player.delegate = self;
    
    if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil])
    {
        return;
    }
    
    [player prepareToPlay];
    [player play];
    
    
}

- (void) stopRecording{
    [recorder updateMeters];
    [timer invalidate];
    [recorder stop];
    self.timerLabel.text = @"0:00";
}

- (void) continueRecording{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
    [recorder record];
    
}

- (void) pauseRecording{
    [timer invalidate];
    [recorder pause];
    
}


@end
