//
//  Card.m
//  test
//
//  Created by DavidX Strube on 11/21/14.
//
//This is the model, so don't import any UI

#import "Card.h"

@interface Card()
//can put put private method declarations here,
//40:20 in episode 1 of stanford ios itune video cast
@end

@implementation Card

//Is this all automatically generated from the Card.h code? Even the getter "isFaceup"?
//@synthesize contents = _contents;
//- (NSString *) contents{
//    return _contents;
//}
//
//- (void)setContents:(NSString *)contents{
//    _contents = contents;
//}
//
//@synthesize faceUp = _faceUp;
//@synthesize unplayable = _unplayable;
//
//- (BOOL) isFaceup{
//    return _faceUp;
//}
//- (void) setFaceup:(BOOL)faceUp{
//    _faceUp = faceUp;
//}
//
//- (BOOL) unplayable{
//    return _unplayable;
//}
//
//- (void) setUnplayable:(BOOL)unplayable{
//    _unplayable = unplayable;
//}

//isEqualToString is NSString method

//0 = NO = nil
- (int) match:(Card *)card{
    int score = 0;
    //if card.contents is nil, comparison = false
    //if card is nil, .contents isn't called and comparison is skipped
    // == tests pointer's binary value, pointing to the same location, same object
    //      , not the same as checking the characters / content
    if ([card.contents isEqualToString:self.contents]){
        score = 1;
    }
    return score;
}

//NSArray cannot be modified - no adding or removing
- (int) matchMany:(NSArray *) otherCards{
    int score = 0;
    //if otherCards is nil, enumeration quitely doesn't happen
    //no need to check for nil
    for (Card *card in otherCards){
        if ([card.contents isEqualToString:self.contents]){
            score = 1;
            break;
        }
    }
    return score;
}

@end