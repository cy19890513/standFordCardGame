//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Yang Chen on 8/7/14.
//  Copyright (c) 2014 Yang Chen. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"

@interface CardMatchingGame()

@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;// all cards
@end

@implementation CardMatchingGame






- (NSMutableArray *) cards{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
    
}

-(instancetype)initWithCardCount: (NSUInteger)count usingDeck:(Deck *)deck{
    
    self = [super init];
    
    if(self){
        for(int i=0;i<count;i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }else{
                self= nil;
                break;
            }
        }//end of for loop
        
    }
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOSEN = 1;

-(void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
        }else{
            //match against other card
            for(Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        self.score +=matchScore* MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched=YES;
                    }else{
                        self.score -=MISMATCH_PENALTY;
                        otherCard.chosen =NO;
                    }
                    break;// can only choose 2 cards for now.
                }
            }//end of for
            self.score -=COST_TO_CHOSEN;
            card.chosen= YES;
        }
    }//end of not matched
    
}


- (Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count])?self.cards[index]:nil;
}

-(instancetype) init{
    return nil;
}

/*
-(void)gameRedeal{
    self.score=0;
    NSMutableArray *cards2;
    
    
}
*/



@end
