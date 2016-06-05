//
//  Elephant.m
//  Hackathon2
//
//  Created by Mr.Vu on 5/30/16.
//  Copyright © 2016 Mr.Vu. All rights reserved.
//

#import "Elephant.h"
#import "BoardConfig.h"

@implementation Elephant

- (id) initElephantWithRow:(NSInteger)row Column:(NSInteger)column MinRow:(NSInteger)minRow MaxRow:(NSInteger)maxRow Color:(PlayerColor)color; {
    self = [super initWithRow:row Column:column Color:color];
    if(self) {
        self.minRow = minRow;
        self.maxRow = maxRow;
        self.minColumn = 0;
        self.maxColumn = BOARD_COLUMN;
    }
    
    return self;
}

- (BOOL)checkMoveWithRow:(NSInteger)nextRow Column:(NSInteger)nextColumn; {
    [super checkMoveWithRow:nextRow Column:nextColumn];
    if(labs(nextRow - self.row) == 2 && labs(nextColumn - self.column) == 2) {
        if(([self checkBarrierRow:self.row + 1 Column:self.column - 1] && nextRow > self.row && nextColumn < self.column) ||
           ([self checkBarrierRow:self.row + 1 Column:self.column + 1] && nextRow > self.row && nextColumn > self.column) ||
           ([self checkBarrierRow:self.row - 1 Column:self.column - 1] && nextRow < self.row && nextColumn < self.column) ||
           ([self checkBarrierRow:self.row - 1 Column:self.column + 1] && nextRow < self.row && nextColumn > self.column)) {
            
            if(self.playerColor == RED && [self getCellFromBoard:nextRow Column:nextColumn] == 1) {
                return NO;
            }
            
            if(self.playerColor == BLACK && [self getCellFromBoard:nextRow Column:nextColumn] == 2) {
                return NO;
            }
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)checkBarrierRow:(NSInteger)row Column:(NSInteger)column {
    if([self getCellFromBoard:row Column:column] != PIECE_EMPTY){
        return NO;
    }
    return YES;
}
@end
