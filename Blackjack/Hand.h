//
//  Hand.h
//  Blackjack
//
//  Created by Richard Lieu on 5/5/14.
//  Copyright (c) 2014 Unbounded. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface Hand : NSObject
@property (strong, nonatomic) NSMutableArray *cards;
@property (assign, nonatomic) short handID; //0:dealer hand, >1: player hand
@property (assign, nonatomic) CGRect cardRect;
- (void)drawCardFromDeck: (Deck *)deck;
- (id)initFromDeck:(Deck *)deck  handID: (short)ID cardRect: (CGRect)rect;
- (int)handValue;

@end
