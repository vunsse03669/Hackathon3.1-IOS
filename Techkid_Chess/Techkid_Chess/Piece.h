//
//  Piece.h
//  Hackathon2
//
//  Created by Mr.Vu on 5/30/16.
//  Copyright © 2016 Mr.Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PlayerColor.h"

@interface Piece : UIButton

@property NSInteger row;
@property NSInteger column;
@property BOOL canMove;

@property NSInteger minRow;
@property NSInteger maxRow;
@property NSInteger minColumn;
@property NSInteger maxColumn;
@property PlayerColor playerColor;

- (instancetype)initWithRow:(NSInteger)row Column:(NSInteger)column Color:(PlayerColor) color;

- (BOOL)checkMoveWithRow:(NSInteger)nextRow Column:(NSInteger)nextColumn;

- (void)moveToRow:(NSInteger)row Column:(NSInteger)column;

- (void)addPieceToBoard;
- (void)removePieceFromBoard;
- (int)getCellFromBoard:(NSInteger)row Column:(NSInteger)column;
- (void)called;

@end
