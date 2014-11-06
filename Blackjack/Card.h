//
//  Card.h
//  Blackjack
//
//  Created by Richard Lieu on 5/4/14.
//  Copyright (c) 2014 Unbounded. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (nonatomic, assign) short   value;
@property (nonatomic, assign) BOOL    isAce;
@property (nonatomic, strong) UIImage *image;

- (id)initWithImage: (short)newValue imageName: (NSString *)image;
@end
