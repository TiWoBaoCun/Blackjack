//
//  Card.m
//  Blackjack
//
//  Created by Richard Lieu on 5/4/14.
//  Copyright (c) 2014 Unbounded. All rights reserved.
//

#import "Card.h"

@implementation Card

- (id)initWithImage:(short)newValue imageName:(NSString *)image
{
    self = [super init];
    
    if (self) {
        self.value = newValue;
        self.image = [UIImage imageNamed:image];
        if (self.value == 1)
            self.isAce = YES;
        else
            self.isAce = NO;
    }
    
    return self;
}

@end
