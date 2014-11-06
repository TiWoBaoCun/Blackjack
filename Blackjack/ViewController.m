//
//  ViewController.m
//  Blackjack
//
//  Created by Richard Lieu on 5/4/14.
//  Copyright (c) 2014 Unbounded. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "Hand.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Blackjack";
    self.numberFormatter = [[NSNumberFormatter alloc]init];
    
    self.deck = [[Deck alloc]init];
    
    [self gameInit];
    
    self.gameTimer = [NSTimer timerWithTimeInterval:0.1f target:self selector:@selector(gameActionHandler:) userInfo:nil repeats:YES];
    
    [self registerTimerToFireOnMainThread];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Blackjack

- (void)showAllHandsValues
{
    self.gameStarted = NO;

    [self showHand:self.dealerHand atDealTime:NO];
    [self showHand:self.playerHand atDealTime:NO];

    self.dealerHandValue.text = [NSString stringWithFormat:@"%d", [self.dealerHand handValue]];

    self.bankroll.text = [[self numberFormatter] stringFromNumber:[NSNumber numberWithFloat:self.playerBankroll]];
}

- (void)gameActionHandler:(NSTimer *)timer
{
    if (!self.gameStarted)
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.btnHit.enabled = NO;
        self.btnStand.enabled = NO;
        self.btnDouble.enabled = NO;
        self.segBetAmount.enabled = YES;
        // Remaining cards in the deck is low, now get a new deck of cards
        if (self.deck.deckCards.count < 15) {
            self.deck = nil;
            self.deck = [[Deck alloc]init];
        }
        if (self.playerBankroll <= self.betAmount) {
            self.playerBankroll = 1000.00f;
            self.bankroll.text = [[self numberFormatter] stringFromNumber:[NSNumber numberWithFloat:self.playerBankroll]];
        }
    }
    else if (self.gameStarted)
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.btnHit.enabled = YES;
        self.btnStand.enabled = YES;
        if (self.playerHand.cards.count == 2) {
            self.btnDouble.enabled = YES;
        }
        else {
            self.btnDouble.enabled = NO;
        }

        self.segBetAmount.enabled = NO;
        if ([self.playerHand handValue] > 21)
        {
            self.gameStatus.text = @"You lose, busted!";
            self.playerBankroll -= self.betAmount;
            self.navigationItem.rightBarButtonItem.enabled = YES;
            
            [self showAllHandsValues];
        }
    }
}

- (void)registerTimerToFireOnMainThread
{
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.gameTimer forMode:NSDefaultRunLoopMode];
}

- (void)gameInit
{
    self.dealerHandTotal = 0;
    self.playerHandTotal = 0;
    self.dealerHandValue.text = @"";
    self.playerHandValue.text = @"";
    self.gameStatus.text = @"";
    self.dealerHandValue.backgroundColor = [UIColor whiteColor];
    self.playerHandValue.backgroundColor = [UIColor whiteColor];
    self.playerHand = nil;
    self.dealerHand = nil;
    [self.numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.playerBankroll = 10000.00f;
    self.bankroll.text = [[self numberFormatter] stringFromNumber:[NSNumber numberWithFloat:self.playerBankroll]];
    self.betAmount = 1000.00f;
    self.segBetAmount.selectedSegmentIndex = 2;
    self.gameStarted = NO;
    self.handCardViews = [[NSMutableArray alloc]init];
    self.gameStatus.text = @"Tap Deal to start BLACKJACK";
}

- (void)gameReset
{
    self.dealerHandTotal = 0;
    self.playerHandTotal = 0;
    self.dealerHandValue.text = @"";
    self.playerHandValue.text = @"";
    self.gameStatus.text = @"";
    self.dealerHandValue.backgroundColor = [UIColor whiteColor];
    self.playerHandValue.backgroundColor = [UIColor whiteColor];

    [self.playerHand.cards removeAllObjects];
    self.playerHand = nil;
    [self.dealerHand.cards removeAllObjects];
    self.dealerHand = nil;
    [self.numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.bankroll.text = [[self numberFormatter] stringFromNumber:[NSNumber numberWithFloat:self.playerBankroll]];
    self.gameStarted = NO;
    [self removeAllSubviews];
}


- (void)showHand: (Hand *)hand atDealTime: (BOOL)isDealTime
{
    if (!hand.cards.count) {
        return;
    }
    
    UIImageView *tempView;
    Card *card = nil;
    int x = hand.cardRect.origin.x;
    for (int i = 0; i < hand.cards.count;i++)
    {
        card = hand.cards[i];
        tempView = [[UIImageView alloc]initWithFrame:CGRectMake(x, hand.cardRect.origin.y, hand.cardRect.size.width, hand.cardRect.size.height)];
        if (hand.handID == 0 && isDealTime && i == 0)
            tempView.image = [UIImage imageNamed:@"faceDown"];
        else
            tempView.image = card.image;
        [self.view addSubview:tempView];
        [self.handCardViews addObject:tempView];
        x += 20;
    }
    
    // Dealer hand ID is 0; Player hand ID > 0
    if (hand.handID > 0) {
        self.playerHandValue.text = [NSString stringWithFormat:@"%d", [hand handValue]];
    }
}

- (void)removeAllSubviews
{
    for (UIView *view in self.handCardViews) {
        [view removeFromSuperview];
    }
    [self.handCardViews removeAllObjects];
}


- (IBAction)doubleBet:(id)sender
{
    [self.playerHand drawCardFromDeck:self.deck];

    if ([self.playerHand handValue] > 21)
    {
        self.gameStatus.text = @"You lose, busted!";
        self.playerBankroll -= self.betAmount;
        [self showAllHandsValues];
    }
    [self dealerDrawsCardsTillScore17orGreater: YES];
}

- (IBAction)dealHand:(id)sender {
    [self gameReset];
    CGRect dealerCardRect = {100, 90, 58, 78};
    self.dealerHand = [[Hand alloc]initFromDeck:self.deck handID:0 cardRect:dealerCardRect];
    [self showHand:self.dealerHand atDealTime:YES];
    
    CGRect playerCardRect = {100, 380, 58, 78};
    self.playerHand = [[Hand alloc]initFromDeck:self.deck handID:1 cardRect:playerCardRect];
    [self showHand:self.playerHand atDealTime:NO];

    self.playerHandTotal = [self.playerHand handValue];
    self.dealerHandTotal = [self.dealerHand handValue];


    if (self.playerHandTotal == 21 && self.dealerHandTotal == 21) {
        self.gameStatus.text = @"It's a push";
        [self showAllHandsValues];

        return;
    }
    else if (self.playerHandTotal == 21) {
        self.gameStatus.text = @"You win, BLACKJACK";
        self.playerBankroll += self.betAmount * 1.5f;
        [self showAllHandsValues];

        return;
    }
    else if (self.dealerHandTotal == 21) {
        self.gameStatus.text = @"You lose, Dealer BLACKJACK";
        self.playerBankroll -= self.betAmount;
        [self showAllHandsValues];
        self.gameStarted = NO;
        return;
    }
    
    self.gameStarted = YES;
}


- (IBAction)hitCard:(id)sender {
    [self.playerHand drawCardFromDeck:self.deck];
    [self showHand:self.playerHand atDealTime:NO];
}

- (void)dealerDrawsCardsTillScore17orGreater: (BOOL)isDoubleBet
{
    while (self.dealerHandTotal < 17)
    {
        self.dealerHandTotal = [self.dealerHand handValue];
        if (self.dealerHandTotal <= 17)
        {
            [self.dealerHand drawCardFromDeck:self.deck];
        }
        else if (self.dealerHandTotal > 21) {
            self.gameStatus.text = @"You Win! Dealer busted";
            self.playerBankroll += self.betAmount;
            [self showAllHandsValues];
            self.gameStarted = NO;
            return;
        }
    }
    self.dealerHandTotal = [self.dealerHand handValue];
    self.playerHandTotal = [self.playerHand handValue];
    if (self.dealerHandTotal > 21 && self.playerHandTotal  <= 21) {
        self.gameStatus.text = @"You Win! Dealer busted";
        if (isDoubleBet) {
            self.playerBankroll += self.betAmount*2;
        }
        else {
            self.playerBankroll += self.betAmount;
        }

        [self showAllHandsValues];
    }
    else if (self.playerHandTotal > 21) {
        self.gameStatus.text = @"You lose, busted!";
        self.playerBankroll -= self.betAmount;
        [self showAllHandsValues];
    }
    else if (self.dealerHandTotal > self.playerHandTotal) {
        self.gameStatus.text = @"You lose!";
        self.playerBankroll -= self.betAmount;
        [self showAllHandsValues];
    }
    else if (self.playerHandTotal > self.dealerHandTotal) {
        self.gameStatus.text = @"You Win!";
        if (isDoubleBet) {
            self.playerBankroll += self.betAmount*2;
        }
        else {
            self.playerBankroll += self.betAmount;
        }
        [self showAllHandsValues];
    }
    else {
        self.gameStatus.text = @"It's a push";
        [self showAllHandsValues];
    }
    self.gameStarted = NO;
}

- (IBAction)stand:(id)sender {
    [self dealerDrawsCardsTillScore17orGreater: NO];
}

- (IBAction)betAmount:(id)sender
{
    if ([[sender titleForSegmentAtIndex:self.segBetAmount.selectedSegmentIndex] isEqualToString:@"100"]) {
        self.betAmount = 100.00f;
        self.imgBetAmount.image = [UIImage imageNamed:@"100"];
    }
    else if ([[sender titleForSegmentAtIndex:self.segBetAmount.selectedSegmentIndex] isEqualToString:@"500"]) {
        self.betAmount = 500.00f;
        self.imgBetAmount.image = [UIImage imageNamed:@"500"];
    }
    else if ([[sender titleForSegmentAtIndex:self.segBetAmount.selectedSegmentIndex] isEqualToString:@"1K"]) {
        self.betAmount = 1000.00f;
        self.imgBetAmount.image = [UIImage imageNamed:@"1000"];
    }
}
@end
