//
//  Deck.h
//  test
//
//  Created by DavidX Strube on 11/25/14.
//
//

#ifndef test_Deck_h
#define test_Deck_h

#import <Foundation/Foundation.h>
@interface Deck : NSObject

-(void) addCard:(Card *)card atTop:(BOOL)atTop;

-(Card *)drawRandomCard;
#endif
