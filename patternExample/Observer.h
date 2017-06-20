//
//  Observer.h
//  patternExample
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EventType){
    EventTypeAddItem,
    EventTypeRemoveItem,
    EventTypeUpdateItem
};

@protocol ObserverProtocol <NSObject>

- (void)didReceiveEvent:(EventType)type;

@end
@interface Observer : NSObject
- (void) addObserver:(id<ObserverProtocol>)observer forEvent:(EventType)type;
- (void) removeObserver:(id<ObserverProtocol>)observer forEvent:(EventType)type;
- (void) sendEvent:(EventType)type;

@end
