//
//  PlayingCard.m
//  test
//
//  Created by DavidX Strube on 11/25/14.
//
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *)contents
{
    //This would yield "1 heart" instead of "ace heart"
    //return [NSString stringWithFormat:@"%d%@", self.rank, self.suit]; //%d = number; %@ = object
    
    NSArray *rankStrings = [PlayingCard validRanks];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

//If you implement both the setter AND getter, then "@synthesize x = _x;" is no longer automatic
@synthesize suit = _suit;

//line beginning with - = instance method
//line beginning with + = class methods, not sent to an instance, but to the class; e.g., utility method (static?)
+(NSArray *) validSuits{
    return @[@"Hearts",@"Spades",@"Clubs",@"Diamonds"];
}

+(NSArray *) validRanks{
    return @[@"?",@"Ace",@"2",@"3",...,@"10",@"Jack",@"Queen",@"King"];
}

+(NSUInteger) maxRank {return [self rankStrings].count - 1;}

-(void) setRank:(NSUInteger) rank{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

-(NSString *)suit{
    //if suit is valid / unset / nil, return suit; else, "?"
    return _suit ? _suit : @"?";
}
-(void) setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}
@end
