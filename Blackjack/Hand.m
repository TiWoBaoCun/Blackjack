//
//  Hand.m
//  Blackjack
//
//  Created by Richard Lieu on 5/5/14.
//  Copyright (c) 2014 Unbounded. All rights reserved.
//

#import "Hand.h"

@implementation Hand


- (void)drawCardFromDeck: (Deck *)deck
{
    Card *card = [deck drawFromDeck];
    [self.cards addObject:card];
}

- (id)initFromDeck:(Deck *)deck  handID: (short)ID cardRect: (CGRect)rect
{
    self = [super init];
    if (self) {
        self.cards = [[NSMutableArray alloc]init];
        [self drawCardFromDeck:deck];
        [self drawCardFromDeck:deck];
        self.handID = ID;
        self.cardRect = rect;
    }
    return self;
}

- (int)handValue
{
    int totalValue = 0;
    
    BOOL aceInHand = NO;
    
    for (Card * card in self.cards) {
        if (card.isAce) {
            aceInHand = YES;
        }
        totalValue += card.value;
    }
    
    if (totalValue <= 11 && aceInHand) {
        totalValue += 10;
    }
    return totalValue;
}

@end
