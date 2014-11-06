//
//  ViewController.h
//  Blackjack
//
//  Created by Richard Lieu on 5/4/14.
//  Copyright (c) 2014 Unbounded. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hand.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dealerHandValue;
@property (strong, nonatomic) IBOutlet UILabel *playerHandValue;
@property (strong, nonatomic) IBOutlet UILabel *bankroll;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segBetAmount;
@property (strong, nonatomic) IBOutlet UIButton *btnHit;
@property (strong, nonatomic) IBOutlet UIButton *btnStand;

@property (strong, nonatomic) IBOutlet UIButton *btnDouble;


@property (strong, nonatomic) IBOutlet UIImageView *imgBetAmount;

- (IBAction)betAmount:(id)sender;


@property (strong, nonatomic) NSNumberFormatter *numberFormatter;
@property (strong, nonatomic) IBOutlet UILabel *gameStatus;

- (IBAction)doubleBet:(id)sender;

- (IBAction)dealHand:(id)sender;

- (IBAction)hitCard:(id)sender;
- (IBAction)stand:(id)sender;
@property (assign, nonatomic) int playerHandTotal;
@property (assign, nonatomic) int dealerHandTotal;
@property (strong, nonatomic) Hand *playerHand;
@property (strong, nonatomic) Hand *dealerHand;
@property (assign, nonatomic) float playerBankroll;
@property (assign, nonatomic) float betAmount;
@property (assign, nonatomic) BOOL gameStarted;
@property (strong, nonatomic) NSTimer *gameTimer;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) NSMutableArray *handCardViews;
@end
