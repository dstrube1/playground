//
//  PlayingCardDeck.m
//  test
//
//  Created by DavidX Strube on 11/25/14.
//
//

#import "PlayingCardDeck.h"

@implementation PlayingCardDeck

//id = data type for pointer to an object of an unknown class
-(id)init{
    //similar to super();
    self = [super init];
    if (self){//self will almost always not be nil
        //create all 52 cards
        for (NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard  alloc] init];
                card.rank = rank;
                card.suit = suit;
                
            }
        }
    }
    
    return self;
}

@end
