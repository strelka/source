//
//  ViewController.m
//  patternExample
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import "ViewController.h"
#import "Singleton.h"
#import "Button.h"
#import "Observer.h"

#import "HWlabel.h"

@import UIKit;

@interface ViewController ()<ObserverProtocol>
@property (nonatomic, strong) Observer *observer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Singleton sharedInstance];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.bounds.size.width / 2 -20, 40, 40, 20);
    [btn setTitle:@"click" forState: UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [btn setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    
    HWlabel *lbl = []
    //    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:btn];
    
    
    
    
//    Button *addButton = [Button buttonWithType:ButtonTypeAdd];
//    [addButton draw];
//    [addButton size];
//    //[self.view addSubview:addButton];
//    
//    self.observer = [Observer new];
//    [_observer addObserver:self forEvent:EventTypeAddItem];
//    [_observer addObserver:self forEvent:EventTypeRemoveItem];
//    
//    
//    // Do any additional setup after loading the view, typically from a nib.
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observ:) name:nil object:nil];
}
- (void) didReceiveEvent:(EventType)type{

    NSLog(@"%@", @(type));
}

- (void)observ:(NSNotification *)notification{
    NSLog(@"%@", notification.description);
}

- (void) buttonClick:(UIButton *) sender{
    [Singleton sharedInstance];
    [_observer sendEvent:EventTypeAddItem];
    [_observer sendEvent:EventTypeAddItem];
    [_observer sendEvent:EventTypeRemoveItem];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
