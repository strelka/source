//
//  CBVkContactsService.h
//  2017-04-25-contacts
//
//  Created by Jullia Sharaeva on 28.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBContactManager.h"

@interface CBVkContactsService : NSObject<CBContactManager, NSURLSessionDownloadDelegate>
//@property(nonatomic, strong) CBContactsList* resultContacts;
-(void)retrieveURL:(NSURL * )url successBlock:(void(^)(NSData *)) successBlock;

@end
