//
//  ViewController.m
//  CrazyDrag
//
//  Created by mac on 16/4/11.
//  Copyright © 2016年 mac. All rights reserved.
//

//没有完成的部分: 点击弹出框之后再进行updateLabels 版本更新后没有了UIAlertView

#import "ViewController.h"
#import "InfoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController (){
    int currentValue;
    int targetValue;
    int score;
    int round;
}

- (IBAction)slideMoved:(id)sender;

@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *targetLabel;
@property (strong, nonatomic) IBOutlet UILabel *Score;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) AVAudioPlayer *clickAudio;

- (IBAction)showAlert: (id)sender;
- (IBAction)resetGame:(id)sender;
- (IBAction)showInfo:(id)sender;

@end


@implementation ViewController

@synthesize slider;
@synthesize targetLabel;
@synthesize Score;
@synthesize roundLabel;
@synthesize audioPlayer;
@synthesize clickAudio;

- (void) playClickMusic{
    NSString *clicMusicPath = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"mp3"];
    NSURL *url1 = [NSURL fileURLWithPath:clicMusicPath];
    NSError *error1;
    
    clickAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:&error1];
    clickAudio.numberOfLoops = 1;
    if (audioPlayer == nil) {
        NSString *error1Info = [NSString stringWithString:[error1 description]];
        NSLog(@"the error is: %@",error1Info);
    }else [clickAudio play];
}

- (void) playBackgroundMusic{
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"no" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPath];
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    if (audioPlayer == nil) {
        NSString *errorInfo = [NSString stringWithString:[error description]];
        NSLog(@"the error is:%@",errorInfo);
    }else{
        [audioPlayer play];
    }
}

- (void) allOverAgian{
    round = 0;
    score = 0;
    [self startNewRound];
    [self updateLabels];
}

- (void) updateLabels{
    self.targetLabel.text = [NSString stringWithFormat:@"%d",targetValue];
    self.Score.text = [NSString stringWithFormat:@"%d",score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d",round];
}

//新开始一轮游戏，将需要用得变量重定义
- (void) startNewRound {
    targetValue = 1 + arc4random()%100;
    currentValue = 1;
    self.slider.value = currentValue;
    round++;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Hilighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"]stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"]stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    

    [self allOverAgian];
    [self updateLabels];
    [self playBackgroundMusic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert:(id)sender {
    int difference = abs(currentValue - targetValue);
    int points = 100 - difference;
    
    NSString *title;
    if (difference == 0) {
        title = @"太准了!";
        points += 50;
    } else if (difference <= 10){
        title = @"很接近了!";
        points += 10;
    }else{
        title = @"下次多多瞄准!";
    }
    score += points;

    
    NSString *message = [NSString stringWithFormat:@"得分: %d", points];
    
// old fashioned way, not working:   [[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil]show];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        self.targetLabel.text = [NSString stringWithFormat:@"%d",targetValue];
    }];
    
    
    /*example
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"ok" style:UIAlertViewStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.targetLabel.text = @"xxxxx";
    }];
    [alertController addAction:act];
    */
    
    
    [alertController addAction:cancelAction];
     
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    /*
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"登陆:";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"密码:";
        textField.secureTextEntry = YES;
    }];
    */
    [self startNewRound];
    [self updateLabels];
    self.targetLabel.text = [NSString stringWithFormat:@"NaN"];
}

- (IBAction)resetGame:(id)sender {
    /* 这段不需要，添加的话会有对话框弹出，不添加直接做按钮动作
    NSString *message_reset = [NSString stringWithFormat:@"要重来吗?"];
    
    UIAlertController *alertController_reset = [UIAlertController alertControllerWithTitle:@"重头来过" message:message_reset preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction *resetAct = [UIAlertAction actionWithTitle:@"再来" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
        self.targetLabel.text = [NSString stringWithFormat:@"%d",targetValue];
    
    }];
    [alertController_reset addAction:resetAct];
    [self presentViewController:alertController_reset animated:YES completion:nil];
    self.targetLabel.text = [NSString stringWithFormat:@"NaN"];
     */
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self allOverAgian];
    [self.view.layer addAnimation:transition forKey:nil];
}

- (IBAction)showInfo:(id)sender {
    InfoViewController *controller = [[InfoViewController alloc]initWithNibName:@"InfoViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
    [self playClickMusic];
}

- (IBAction)slideMoved:(UISlider*)_slider {
//    UISlider *_slider = (UISlider*)sender; 原本上面是:(id)sender{} 这句就得有
//    NSLog(@"滑动条的当前数值是:%f", slider.value);
    currentValue = (int)lroundf(_slider.value);
}
@end
