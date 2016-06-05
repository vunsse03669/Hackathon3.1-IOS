//
//  ViewController.m
//  Hackathon2
//
//  Created by Mr.Vu on 6/3/16.
//  Copyright © 2016 Mr.Vu. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"
#import "Piece.h"
#import "Map.h"
#import "BoardConfig.h"
#import "King.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GameObject shareInstance:self.vBoard];
    self.arrBoard = [[NSMutableArray alloc]init];
    [self initBoard];
}


#pragma mark - init board

- (void)initBoard {
    for(UIView *subview in self.vBoard.subviews) {
        
        if([subview isKindOfClass:[Cell class] ]) {
            [self caculateOrigiForCell:(Cell *)subview];
            [self.arrBoard addObject:subview];
            [((UIButton *)subview) addTarget:self action:@selector(clickOnCell: :) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if([subview isKindOfClass:[Piece class]]) {
            [self caculateOrigiForPiece:(Piece *)subview];
            [((UIButton *)subview) addTarget:self action:@selector(clickOnPiece:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    [Map print];
}

- (void)caculateOrigiForCell:(Cell *)cell {
    cell.row = cell.frame.origin.y/CELL_FRAME;
    cell.column = cell.frame.origin.x/CELL_FRAME;
}

- (void)caculateOrigiForPiece:(Piece *)piece {
    piece.row = piece.frame.origin.y/CELL_FRAME;
    piece.column = piece.frame.origin.x/CELL_FRAME;
}

#pragma mark - logic

- (void)clickOnCell:(Cell *)cell :(Piece *)piece{
    
    if(cell.canMove) {
        
        for(UIView *subview in self.vBoard.subviews){
            if([subview isKindOfClass:[Piece class]] && ((Piece *)subview).canMove) {
                [UIView animateWithDuration:1.0f animations:^{
                    subview.center = cell.center;
                    [((Piece *)subview) moveToRow:cell.row Column:cell.column];
                } completion:^(BOOL finished) {
                    if([((Piece *)subview) playerColor] == RED) {
                        [GameObject shareInstance:_vBoard].redPlayer.numberOfTurn ++;
                    }
                    if([((Piece *)subview) playerColor] == BLACK) {
                        [GameObject shareInstance:_vBoard].blackPlayer.numberOfTurn ++;
                    }
                    ((Piece *)subview).canMove = NO;
                    [Map print];
                    for(Cell *cell in self.arrBoard) {
                       [cell setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                    }
                }];
            }

        }
    }
}

- (void)clickOnPiece:(Piece *)piece {
    if([self checkEat:piece] && [self getPieceCanMove] != nil) {
        [UIView animateWithDuration:1.0f animations:^{
            [[self getPieceCanMove] moveToRow:piece.row Column:piece.column];
            [self getPieceCanMove].center = piece.center;
        } completion:^(BOOL finished) {
            //[piece removePieceFromBoard];
            [piece removeFromSuperview];
            for(Cell *cell in self.arrBoard) {
                [cell setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            }
            if([[self getPieceCanMove] playerColor] == RED) {
                [GameObject shareInstance:_vBoard].redPlayer.numberOfTurn ++;
            }
            if([[self getPieceCanMove] playerColor] == BLACK) {
                [GameObject shareInstance:_vBoard].blackPlayer.numberOfTurn ++;
            }
            
            [self getPieceCanMove].canMove = NO;
            [self checkGameOver];

            [Map print];
        }];
    }else {
        // turn of redPlayer
        if([GameObject shareInstance:_vBoard].checkTurn == 1) {
            for(Cell *cell in self.arrBoard) {
                if([piece checkMoveWithRow:cell.row Column:cell.column] && piece.playerColor == RED) {
                    [self setupMoveForPiece:piece];
                    if(piece.playerColor == BLACK) {
                        [cell setBackgroundImage:[UIImage imageNamed:EFFECT_BLUE] forState:UIControlStateNormal];
                    }else {
                        [cell setBackgroundImage:[UIImage imageNamed:EFFECT_RED] forState:UIControlStateNormal];
                    }
                    cell.canMove = YES;
                } else {
                    cell.canMove = NO;
                }
            }
        }
        // turn of blackPlayer
        if([GameObject shareInstance:_vBoard].checkTurn == 2) {
            for(Cell *cell in self.arrBoard) {
                if([piece checkMoveWithRow:cell.row Column:cell.column] && piece.playerColor == BLACK) {
                    [self setupMoveForPiece:piece];
                    if(piece.playerColor == BLACK) {
                        [cell setBackgroundImage:[UIImage imageNamed:EFFECT_BLUE] forState:UIControlStateNormal];
                    }else {
                        [cell setBackgroundImage:[UIImage imageNamed:EFFECT_RED] forState:UIControlStateNormal];
                    }
                    cell.canMove = YES;
                } else {
                    cell.canMove = NO;
                }
            }
        }

    }
   
}

- (void)setupMoveForPiece:(Piece *)piece {
    piece.canMove = YES;
    for(Piece *view in self.vBoard.subviews) {
        if([view isKindOfClass:[Piece class]] && (Piece *)view != piece) {
            ((Piece *)view).canMove = NO;
        }
    }
}

- (BOOL)checkEat:(Piece *)piece {
    
    for(Cell *cell in self.vBoard.subviews) {
        if([cell isKindOfClass:[Cell class]] && cell.canMove) {
            if(piece.row == cell.row && piece.column == cell.column){
                return YES;
            }
        }
    }
    
    return NO;
}

- (Piece *)getPieceCanMove {
    for(Piece *piece in self.vBoard.subviews) {
        if([piece isKindOfClass:[Piece class]] && piece.canMove) {
            return piece;
        }
    }
    return nil;
}

- (void)checkGameOver {
    int i = 0;
    for(Piece *piece in self.vBoard.subviews) {
        if([piece isKindOfClass:[King class]]) {
            i ++;
        }
    }
    if(i == 1) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Game Over" message:@"Do you want to continue" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"Continued", nil];
        [alert show];
    }
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) {
        NSLog(@"index = 0");
    }
    else if(buttonIndex == 1) {
        NSLog(@"index = 1");
    }
}


@end
