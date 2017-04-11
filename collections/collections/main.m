//
//  main.m
//  collections
//
//  Created by Jullia Sharaeva on 02.04.17.
//  Copyright © 2017 Jullia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FractionCl.h"
void arrays(){
    NSMutableArray *fracarray = [[NSMutableArray alloc] init];
    unsigned int i;
    
    FractionCl *frac;
    for (i = 0; i < 10; ++i){
        frac = [[FractionCl alloc] init];
        [frac setNumerator: i];
        [frac setDenominator:i+2];
        
        fracarray[i] = frac;
    }
    
    NSLog(@"mutable array:");
    
    for (FractionCl *item in fracarray){
        [item print];
    }
    
    NSLog(@"unmutable array:");
    
    NSArray *fracarray2 = [[NSArray alloc] initWithArray:fracarray copyItems:YES];
    
    [fracarray2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj print];
    }];
    
    for (FractionCl *item in fracarray2){
        [item changeFraction: 2];
        
    }
    
    NSLog(@"changed unmutable array:");
    for (FractionCl *item in fracarray2){ [item print];}
    
    FractionCl *frac_new = [[FractionCl alloc] init];
    [frac_new setDenominator:2];
    [frac_new setNumerator:4];
    
    [fracarray addObject: frac_new];
    
    NSLog(@"add elem to mutable array");
    for (FractionCl *item in fracarray){ [item print];}
    
    NSLog(@"sorted unmutable array");
    NSArray *sortedfrac = [fracarray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (([obj1 getDenominator]%2==0)&&([obj2 getDenominator] % 2!=0)){
            return NSOrderedAscending;}
        else if (([obj1 getDenominator]%2!=0)&&([obj2 getDenominator] % 2==0)){
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    for (FractionCl *item in sortedfrac){ [item print];}
    
    //фильтрация
    
    NSPredicate *after14 = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        if (([evaluatedObject getDenominator] >= 14) || ([evaluatedObject getNumerator] >= 14))
        {
            return YES;
        } else {
            return NO;
        }
    }];
    
    NSArray *makesafter14 = [fracarray2 filteredArrayUsingPredicate:after14];
    NSLog(@"filtered inmutable array");
    for (FractionCl *item in makesafter14){ [item print];}
    
    NSLog(@"union");
    NSArray *allfactories = [fracarray arrayByAddingObjectsFromArray:fracarray2];
    for (FractionCl *item in allfactories){ [item print];}
    
    [fracarray2[5] changeFraction:4];
    for (FractionCl *item in allfactories){ [item print];}
    

}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        arrays();
        
//        enum weight {slim = 120, medium = 180, large = 200};
//        enum weight current_weight;
//        current_weight = medium;
//        
//        NSLog(@"current weight is %i ", current_weight);
//        
//        NSString *str1 = @"this is string 1";
//        NSString *str2 = @"this is string 2";
//        
//        NSString *res;
//        NSComparisonResult compareResult;
//        
//        NSLog(@"Length of str1: %lu", [str1 length]);
//        res = [NSString stringWithString:str2];
//        NSLog(@"copy: %@", res);
//        str2 = [str1 stringByAppendingString:str2];
//        NSLog(@"concatenation: %@", str2);
//        NSLog(@"and else: %@", res);
//        
//        //проверка на равенство
//        if ([str1 isEqualToString:res] == YES)
//            NSLog(@"str1 == res");
//        else
//            NSLog(@"str1 != res");
//        
//        //сравнение строк
//        compareResult = [str1 compare:str2];
//        NSLog(@"%ld", (long)compareResult);
//        
//        res = [str1 lowercaseString];
//        NSLog(@"lowercase conversion %s", [res UTF8String]);
//        
//        res = [str1 uppercaseString];
//        NSLog(@"uppercase conversion %@", res);
//        
//        NSLog(@"original string: %@", str1);
//        
//        res = [str1 substringToIndex:3];
//        NSLog(@"first 3 chars of str1: %@", res);
//        
//        //извлечение символов начиная с номера 8, до номера 13 (6 символов)
//        
//        res = [str1 substringFromIndex:5];
//        NSLog(@"Chars from index 5 of str1: %@", res);
//        
//        //извлечение символов начиная с номера 8 до номера 13 (6 символов)
//        
//        res = [[str1 substringFromIndex:8] substringToIndex:6];
//        NSLog(@"chars from index 8 through 13: %@", res);
//        
//        //второй способ
//        res = [str1 substringWithRange: NSMakeRange(8, 6)];
//        NSLog(@"chars from index 8 through 13: %@", res);
//        
//        // присутствие одной строки в другой
//        
//        //NSDecimalNumber *test = [NSDecimalNumber one];
//        //NSLog(@"%@", [NSDecimalNumber minimumDecimalNumber]);
//        
//        
////        Рассмотреть коллекции NSPointerArray,
////                                NSHashTable,
////                                NSMapTable,
////        описать несколько примеров их использования, написать код, разобраться чем данные коллекции отличаются от NSArray, NSSet, NSDictionary.
////        Рассмотреть дополнительные виды множеств NSCountedSet, NSOrderedSet
////
//        NSArray *nsar = [[NSArray alloc] init];
//        nsar = @[@"one", @"two", @"three", @"four"];
//        
//        NSPointerArray *nspar = [[NSPointerArray alloc] init];
//        [nspar addPointer:(nil)];
//        [nspar addPointer:@"Cat"];
//        [nspar addPointer:@"Dog"];
//        [nspar addPointer:@"Cow"];
//        int i;
//        
//        NSLog(@"%lu", (unsigned long)[nspar count]);
//        
//        NSCountedSet *cs = [[NSCountedSet alloc] init];
//        [cs addObject:@"Dog"];
//        [cs addObject:@"Cat"];
//        [cs addObject:@"Cow"];
//        [cs addObject:@"Mouse"];
//        [cs addObject:@"Cow"];
//        
//        NSLog(@"%lu", (unsigned long)[cs countForObject:@"Dog"]);
//        
//        for(id item in [cs objectEnumerator]){
//            NSLog(@"%@ - %lu", item, (unsigned long)[cs countForObject:item]);
//        }
//        
//        NSOrderedSet *cs;
//        [cs addObject:@"Dog"];
//        [cs addObject:@"Cat"];
//        [cs addObject:@"Cow"];
//        [cs addObject:@"Mouse"];
//        [cs addObject:@"Cow"];
//        
//        for(id item in [cs objectEnumerator]){
//            NSLog(@"%@", item);
//        }
//        
//        
//        
//        
//        
//        
    }
    return 0;
}


