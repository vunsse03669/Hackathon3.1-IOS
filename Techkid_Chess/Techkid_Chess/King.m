//
//  King.m
//  Hackathon2
//
//  Created by Mr.Vu on 5/30/16.
//  Copyright © 2016 Mr.Vu. All rights reserved.
//

#import "King.h"
#import "BoardConfig.h"

#define MIN_X 3;
#define MAX_X 5;

@implementation King

- (id) initKingWithRow:(NSInteger)row Column:(NSInteger)column MinRow:(NSInteger)minRow MaxRow:(NSInteger)maxRow Color:(PlayerColor)color; {
    self = [super initWithRow:row Column:column Color:color];
    if(self) {
        self.maxRow = maxRow;
        self.minRow = minRow;
        self.maxColumn = MIN_X;
        self.maxColumn = MAX_X;
    }
    
    return self;
}

- (BOOL)checkMoveWithRow:(NSInteger)nextRow Column:(NSInteger)nextColumn; {
    [super checkMoveWithRow:nextRow Column:nextColumn];
    if( ( (labs(nextRow -self.row) == 1 && labs(nextColumn - self.column) == 0) ||
         (labs(nextRow -self.row) == 0 && labs(nextColumn - self.column) == 1) ) && nextColumn >= 3 && nextColumn <= 5 && (nextRow >= 7 || nextRow <= 2)) {
        if(self.playerColor == RED && [self getCellFromBoard:nextRow Column:nextColumn] == 1) {
            return NO;
        }
        
        if(self.playerColor == BLACK && [self getCellFromBoard:nextRow Column:nextColumn] == 2) {
            return NO;
        }
        return YES;
    }
    
    

    return NO;
}
@end
