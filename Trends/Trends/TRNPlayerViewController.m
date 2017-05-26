//
//  TRNPlayerViewController.m
//  Trends
//
//  Created by Jullia Sharaeva on 26.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//
#import "YTPlayerView.h"
#import "TRNPlayerViewController.h"

@interface TRNPlayerViewController ()

@end

@implementation TRNPlayerViewController

- (instancetype) initWithVideoId:(NSString*)videoId{
    self = [super init];
    if (self){
        _videoId = videoId;
    }
    return self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _playerView = [[YTPlayerView alloc] init];
    [_playerView loadWithVideoId:_videoId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
