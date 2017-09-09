//
//  Deck.m
//  test
//
//  Created by DavidX Strube on 11/25/14.
//
//
#import "Deck.h"

@interface Deck()
//private properties
//must be strong or no one will be pointing to it
@property (strong, nonatomic) NSMutableArray *cards;
//NSMutableArray can be modified - adding and removing
@end

@implementation Deck

//cards getter - lazy instantiation
-(NSMutableArray *)cards
{
    //allocation and initialization are separate things (why?),
    //but they always go together (why?)
    //(alloc is a class method)
    if (!_cards) _cards = [[NSMutableArray alloc] init]; // equivalent to new ArrayList();
    //call functions with brackets; nested functions = nested brackets
    return _cards;
}

-(void) addCard:(Card *)card atTop:(BOOL)atTop{
    //two params
    if (card){
        if (atTop){
            [self.cards insertObject:card atIndex:0];
        }else{
            [self.cards addObject:card]; //addObject = bottom / end of array
        }
    }
    //what if card is nil? crash; cannot insert nil into an array
}

-(Card *)drawRandomCard{
    //this method takes no arguments but returns something
    
    //local vars start out as 0 / nil / no by default
    Card *randomCard = nil;
    
    if (self.cards.count){
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end