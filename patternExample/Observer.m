//
//  Observer.m
//  patternExample
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import "Observer.h"
@interface Observer()
@property (nonatomic, strong) NSMutableSet<id<ObserverProtocol>> *addObservers;
@property (nonatomic, strong) NSMutableSet<id<ObserverProtocol>> *removeObservers;
@property (nonatomic, strong) NSMutableSet<id<ObserverProtocol>> *updateObservers;
@end

@implementation Observer

- (instancetype) init{
    self = [super init];
    if (self){
        _observers = [NSMutableSet new];
    }
    
    return self;
}
- (void) addObserver:(id)observer forEvent:(EventType)type{
    switch (type) {
        case EventTypeAddItem:
            [_addObservers addObject:observer];
            break;
        case EventTypeRemoveItem:
            [_removeObservers addObject:observer];
            break;
        case EventTypeUpdateItem:
            [_removeObservers addObject:observer];
        default:
            break;
    }
}

- (void) removeObserver:(id<ObserverProtocol>)observer forEvent:(EventType)type{
    switch (type) {
        case EventTypeAddItem:
            [_addObservers removeObject:observer];
            break;
        case EventTypeRemoveItem:
            [_removeObservers removeObject:observer];
            break;
        case EventTypeUpdateItem:
            [_removeObservers removeObject:observer];
        default:
            break;
    }

}

- (void) sendEvent:(EventType)type{

}

@end
