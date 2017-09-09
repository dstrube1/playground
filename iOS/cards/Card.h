//
//  Card.h
//  test
//
//  Created by DavidX Strube on 11/21/14.
//
//

#ifndef test_Card_h
#define test_Card_h

#import <Foundation/Foundation.h>

@interface Card : NSObject

//all properties and methods in here are public

//all objects live in heap, not in stack, objects are always pointed to

//no garbage collection in Objective C
//garbage collection done by reference count
//when count of things pointed to a reference of an object goes to 0, clean it up from heap
//iOS 6: reference counting done manually; += done automatically

//strong = iOS keeps track of reference count
//weak = only keep this in heap as long as someone else points to it strongly
//nonatomic = not thread safe 
@property (strong, nonatomic) NSString *contents;
//if property is weak and reference count goes to 0, pointer value is immediately set to nil

@property (nonatomic getter=isFaceup)BOOL faceUp;
@property (nonatomic)BOOL unplayable;

- (int) match:(Card *)card;
- (int) matchMany:(NSArray *) otherCards;

@end
#endif
