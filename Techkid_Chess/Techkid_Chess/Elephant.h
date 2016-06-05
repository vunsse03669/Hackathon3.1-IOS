//
//  Elephant.h
//  Hackathon2
//
//  Created by Mr.Vu on 5/30/16.
//  Copyright © 2016 Mr.Vu. All rights reserved.
//

#import "Piece.h"

@interface Elephant : Piece

- (id) initElephantWithRow:(NSInteger)row Column:(NSInteger)column MinRow:(NSInteger)minRow MaxRow:(NSInteger)maxRow Color:(PlayerColor)color;

- (BOOL)checkMoveWithRow:(NSInteger)nextRow Column:(NSInteger)nextColumn;

@end
