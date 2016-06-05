//
//  Soldier.m
//  Hackathon2
//
//  Created by Mr.Vu on 5/30/16.
//  Copyright © 2016 Mr.Vu. All rights reserved.
//

#import "Soldier.h"
#import "PlayerColor.h"

@implementation Soldier

- (instancetype)initWithRow:(NSInteger)row Column:(NSInteger)column Color:(PlayerColor) color; {
    self = [super initWithRow:row Column:column Color:color];
    if(self) {
        self.overRiver = NO;
    }
    
    return self;
}

- (BOOL)checkMoveWithRow:(NSInteger)nextRow Column:(NSInteger)nextColumn; {
    
    if(self.playerColor == RED && self.row >= 5) {
        self.overRiver = YES;
    }
    else if(self.playerColor == BLACK && self.row <= 4) {
        self.overRiver = YES;
    }
    else {
        self.overRiver = NO;
    }
    
    if(!self.overRiver) {
        if(self.playerColor == RED && nextColumn == self.column && nextRow == self.row + 1) {
            return YES;
        }
        else if(self.playerColor == BLACK && nextColumn == self.column && nextRow == self.row - 1) {
            return YES;
        }
    }
    else if (self.overRiver) {
        if(self.playerColor == RED) {
            if(labs(nextColumn - self.column) == 1 && nextRow == self.row){
                return YES;
            } else if(nextRow == self.row + 1 && nextColumn == self.column) {
                return YES;
            }
            return NO;
        }
        else if(self.playerColor == BLACK) {
            if(labs(nextColumn - self.column) == 1 && nextRow == self.row){
                return YES;
            } else if(nextRow == self.row - 1 && nextColumn == self.column) {
                return YES;
            }
            return NO;
        }
    }
    
    return NO;
}

@end
