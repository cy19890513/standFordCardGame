//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Yang Chen on 8/5/14.
//  Copyright (c) 2014 Yang Chen. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (nonatomic) int flipCount;
@property (nonatomic, strong) Deck* deck;
@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic) int gameType;

@end

@implementation CardGameViewController










-(CardMatchingGame *) game{
    if(!_game){ _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];}
    return _game;
}



-(Deck *) createDeck{
    
    return [[PlayingCardDeck alloc] init];
}



- (IBAction)gameReDeal:(UIButton *)sender {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    [self updateUI];
}


- (IBAction)touchCardButton:(UIButton *)sender {
    
    int chosenButtonindex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonindex];
    [self updateUI];
    }

-(void)updateUI{
    for(UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    }
    
}

-(NSString *)titleForCard:(Card *)card{
    return card.isChosen ? card.contents: @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed: card.isChosen? @"cardfront": @"cardback"];
}



@end