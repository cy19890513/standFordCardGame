//
//  PlayingCard.h
//  Matchismo
//
//  Created by Yang Chen on 8/6/14.
//  Copyright (c) 2014 Yang Chen. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card
@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
