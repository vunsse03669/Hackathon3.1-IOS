//
//  Horse.m
//  Hackathon2
//
//  Created by Mr.Vu on 5/30/16.
//  Copyright © 2016 Mr.Vu. All rights reserved.
//

#import "Horse.h"
#import "BoardConfig.h"

@implementation Horse

- (BOOL)checkMoveWithRow:(NSInteger)nextRow Column:(NSInteger)nextColumn; {
    [super checkMoveWithRow:nextRow Column:nextColumn];
    
    if(labs(nextRow - self.row) == 2 && labs(nextColumn - self.column) == 1) {
        if(([self getCellFromBoard:self.row + 1 Column:self.column] == PIECE_EMPTY && nextRow - self.row > 0)||
           ([self getCellFromBoard:self.row - 1 Column:self.column] == PIECE_EMPTY && nextRow - self.row < 0)) {
            return YES;
        }
    }
    else if(labs(nextRow - self.row) == 1 && labs(nextColumn - self.column) == 2) {
        if(([self getCellFromBoard:self.row Column:self.column + 1] == PIECE_EMPTY && nextColumn - self.column > 0) ||
           ([self getCellFromBoard:self.row Column:self.column - 1] == PIECE_EMPTY && nextColumn - self.column < 0 )) {
            return YES;
        }
    }
    
    return NO;
}

@end
