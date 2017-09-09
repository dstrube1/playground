//
//  PlayingCard.h
//  test
//
//  Created by DavidX Strube on 11/25/14.
//
//

#ifndef test_PlayingCard_h
#define test_PlayingCard_h

#import <Foundation/Foundation.h>
@interface PlayingCard : Card //PlayingCard is a subclass of Card

@property (strong, nonatomic)NSString *suit; //(heart, spade, club, diamond)
//NSUInteger = unsigned
@property (nonatomic)NSUInteger *rank; //1(Ace) - 13 (King)


#endif
