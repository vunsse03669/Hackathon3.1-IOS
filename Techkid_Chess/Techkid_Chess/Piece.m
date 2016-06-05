//
//  Piece.m
//  Hackathon2
//
//  Created by Mr.Vu on 5/30/16.
//  Copyright © 2016 Mr.Vu. All rights reserved.
//

#import "Piece.h"
#import "BoardConfig.h"
#import "Map.h"

@implementation Piece


- (instancetype)initWithRow:(NSInteger)row Column:(NSInteger)column Color:(PlayerColor) color; {
    
    self = [super init];
    if(self) {
        self.row = row;
        self.column = column;
        self.playerColor = color;
        self.minColumn = 0;
        self.maxColumn = BOARD_COLUMN - 1;
        self.minRow = 0;
        self.maxRow = BOARD_ROW - 1;
        
        [self addPieceToBoard];
    }
    
    return self;
}

- (void)addPieceToBoard; {
    [[Map shareInstance]addPiece:self];
}

- (void)removePieceFromBoard; {
    [[Map shareInstance]removePiece:self];
}
- (int)getCellFromBoard:(NSInteger)row Column:(NSInteger)column; {
    return [[Map shareInstance]getCellWithRow:row Column:column];
}


- (BOOL)checkMoveWithRow:(NSInteger)nextRow Column:(NSInteger)nextColumn; {
    
    /*  Check if next position is out of board */
    if(nextRow < self.minRow  || nextRow > self.maxRow) {
        return NO;
    }
    if(nextColumn < self.minColumn || nextColumn > self.maxColumn) {
        return NO;
    }
    if(nextRow == self.row && nextColumn == self.column) {
        return NO;
    }
    
    
    if(self.playerColor == RED && [self getCellFromBoard:nextRow Column:nextColumn] == 1) {
        return NO;
    }
    
    if(self.playerColor == BLACK && [self getCellFromBoard:nextRow Column:nextColumn] == 2) {
        return NO;
    }
    
    return YES;
}

- (void)moveToRow:(NSInteger)row Column:(NSInteger)column; {
    /* before move remove old position in board, after move add new position to board */
    if([self checkMoveWithRow:row Column:column]) {
        [self removePieceFromBoard];
        self.row = row;
        self.column = column;
        [self addPieceToBoard];
    }
}

- (void)called;{}


@end
