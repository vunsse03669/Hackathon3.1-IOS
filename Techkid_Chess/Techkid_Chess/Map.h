//
//  Map.h
//  Hackathon2
//
//  Created by Mr.Vu on 5/30/16.
//  Copyright © 2016 Mr.Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Piece.h"

@interface Map : NSObject

+ (Map *)shareInstance;
- (void)addPiece:(Piece *)piece;
- (void)removePiece:(Piece *)piece;
- (int)getCellWithRow:(NSInteger)row Column:(NSInteger)column;
+ (void)print;

@end
