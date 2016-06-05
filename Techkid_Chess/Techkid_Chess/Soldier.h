//
//  Soldier.h
//  Hackathon2
//
//  Created by Mr.Vu on 5/30/16.
//  Copyright © 2016 Mr.Vu. All rights reserved.
//

#import "Piece.h"

@interface Soldier : Piece

@property BOOL overRiver;

- (instancetype)initWithRow:(NSInteger)row Column:(NSInteger)column Color:(PlayerColor) color;
- (BOOL)checkMoveWithRow:(NSInteger)nextRow Column:(NSInteger)nextColumn;

@end
