//
//  Deck.h
//  Blackjack
//
//  Created by Richard Lieu on 5/4/14.
//  Copyright (c) 2014 Unbounded. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

@property (nonatomic, strong) NSMutableArray *deckCards;
- (id)drawFromDeck;
@end
