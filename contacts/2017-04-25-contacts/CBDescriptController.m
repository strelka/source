//
//  CBDescriptController.m
//  2017-04-25-contacts
//
//  Created by Jullia Sharaeva on 26.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBDescriptController.h"
#import "CBDescriptionView.h"
#import "CBContact.h"
#import "CBAvatarView.h"

@interface CBDescriptController ()
@end

@implementation CBDescriptController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CBDescriptionView* descView = [[CBDescriptionView alloc]initWithFrame:self.view.bounds];
    descView.backgroundColor = [UIColor greenColor];
    descView.name.text = _contact.firstName;
    descView.lastName.text = _contact.lastName;
    descView.phone.text = _contact.phoneNumber;
    descView.email.text = _contact.email;
    
    [descView.avatar setRoundedAndColorView:80 andColor:_contact.avatarColor];

    [self.view addSubview:descView];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
