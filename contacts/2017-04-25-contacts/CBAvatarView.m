//
//  CBAvatarView.m
//  2017-04-25-contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBAvatarView.h"

@implementation CBAvatarView


-(void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
}

-(void) fillRect:(CGRect)rect{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    NSArray* colors = @[[UIColor redColor],
                        [UIColor blueColor],
                        [UIColor greenColor],
                        [UIColor magentaColor],
                        [UIColor orangeColor],
                        [UIColor lightGrayColor]];
    
    unichar fcName = [_name characterAtIndex:0];
    unichar fcLName = [_lastName characterAtIndex:0];
    
    NSString *inic = [NSString stringWithFormat:@"%c%c", fcName, fcLName];
    int asciiCode = (int) inic;
    int colorIndx = asciiCode%7;
    
    CGContextSetFillColor(ctx, CGColorGetComponents([colors[colorIndx] CGColor]));
    CGContextFillPath(ctx);
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attr = [NSDictionary dictionaryWithObject:style forKey:NSParagraphStyleAttributeName];
    
    [inic drawInRect:rect withAttributes:attr];
}

-(UIImage*) getImage{
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end

