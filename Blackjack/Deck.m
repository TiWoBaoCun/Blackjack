//
//  Deck.m
//  Blackjack
//
//  Created by Richard Lieu on 5/4/14.
//  Copyright (c) 2014 Unbounded. All rights reserved.
//

#import "Deck.h"

@implementation Deck


- (id)init
{
    self = [super init];
    if (self)
    {
        NSArray *cardImageName = [NSArray arrayWithObjects:@"spadeAce", @"spade2", @"spade3", @"spade4", @"spade5", @"spade6", @"spade7",
                                  @"spade8", @"spade9", @"spade10", @"spadeJack", @"spadeQueen", @"spadeKing", @"heartAce", @"heart2", @"heart3", @"heart4", @"heart5", @"heart6", @"heart7", @"heart8", @"heart9", @"heart10", @"heartJack", @"heartQueen", @"heartKing", @"diamondAce", @"diamond2", @"diamond3", @"diamond4", @"diamond5", @"diamond6", @"diamond7", @"diamond8", @"diamond9", @"diamond10", @"diamondJack", @"diamondQueen", @"diamondKing", @"clubAce", @"club2", @"club3", @"club4", @"club5", @"club6", @"club7", @"club8", @"club9", @"club10", @"clubJack", @"clubQueen", @"clubKing", nil];
        self.deckCards = [[NSMutableArray alloc]init];
        
        int cardIndex = 0, cardValue;
        for (int suit = 0; suit < 4; suit++)
        {
            for (int i = 0; i < 13; i++)
            {
                if (i > 9)
                    cardValue = 10;
                else
                    cardValue = i+1;
                [self.deckCards addObject:[[Card alloc]initWithImage:cardValue imageName:cardImageName[cardIndex++]]];
            }
            
        }
    }
    return self;
}

- (id)drawFromDeck
{
    srand(time(nil));
    int index = rand()%self.deckCards.count;
    Card *card = [self.deckCards objectAtIndex:index];
    [self.deckCards removeObjectAtIndex:index];
    return card;
}

@end
