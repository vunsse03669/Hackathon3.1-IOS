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
#import "ChatRoomViewController.h"
#import "Utils.h"


@interface ViewController () <ChatRoomViewControllerDelegate>

@property ChatRoomViewController *socketRoom;
@property int messageIdx;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GameObject shareInstance:self.vBoard];
    self.arrBoard = [[NSMutableArray alloc]init];
    [self initBoard];
    
    //init socket
    self.socketRoom = [[ChatRoomViewController alloc] initWithUserName:self.username room:@"co_tuong_01"];
    [self.socketRoom startSocket];
    self.socketRoom.delegate = self;
    //[self sendMessage:@"Ahihi123"];
    self.messageIdx = 0;
 
}

- (void) sendMessage:(NSString *)message
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.socketRoom.roomReady) {
            [self.socketRoom.socket emit:@"message" withItems:@[message, self.socketRoom.roomName, self.socketRoom.userName]];
        }
        //[self sendMessage:[NSString stringWithFormat:@"message %d", self.messageIdx++]];
    });
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
        
        __block NSInteger oldRow = 0;
        __block NSInteger oldColumn = 0;
        
        for(Piece *subview in self.vBoard.subviews){
            if([subview isKindOfClass:[Piece class]] && ((Piece *)subview).canMove) {
                [UIView animateWithDuration:1.0f animations:^{
                    oldRow = subview.row;
                    oldColumn = subview.column;
                    subview.center = cell.center;
                    [((Piece *)subview) moveToRow:cell.row Column:cell.column];
                } completion:^(BOOL finished) {
                    NSInteger columnValue = cell.column;
                    NSInteger rowValue = cell.row;
                    BOOL eat = NO;
                    
                    NSDictionary *dictData = @{@"rowValue": @(rowValue),@"columnValue": @(columnValue),
                                               @"oldRow": @(oldRow),@"oldColumn": @(oldColumn),@"Eat":@(eat)};
                    NSString *strData = [Utils stringJSONByDictionary:dictData];
                    
                    [self.socketRoom.socket emit:@"message" withItems:@[strData, self.socketRoom.roomName, self.socketRoom.userName]];
                    self.lastMovingUser = self.username;
                    
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

- (BOOL) isMyTurn
{
    if ([self.lastMovingUser intValue] == [self.username intValue]) {
        return NO;
    }
    
    return YES;
}

- (void)clickOnPiece:(Piece *)piece {
    if (![self isMyTurn]) {
        return;
    }
    NSLog(@"%ld - %ld",piece.row,piece.column);
    if([self checkEat:piece] && [self getPieceCanMove] != nil) {
        __block NSInteger oldRow = 0;
        __block NSInteger oldColumn = 0;
        
        [UIView animateWithDuration:1.0f animations:^{
            oldRow = [self getPieceCanMove].row;
            oldColumn = [self getPieceCanMove].column;
            [[self getPieceCanMove] moveToRow:piece.row Column:piece.column];
            [self getPieceCanMove].center = piece.center;
        } completion:^(BOOL finished) {
            //[piece removePieceFromBoard];
            
            NSInteger rowValue = [self getPieceCanMove].row;
            NSInteger columnValue = [self getPieceCanMove].column;
            BOOL eat = YES;
            
            NSDictionary *dictData = @{@"rowValue": @(rowValue),@"columnValue": @(columnValue),
                                       @"oldRow": @(oldRow),@"oldColumn": @(oldColumn),@"Eat":@(eat)};
            NSString *strData = [Utils stringJSONByDictionary:dictData];
            
            [self.socketRoom.socket emit:@"message" withItems:@[strData, self.socketRoom.roomName, self.socketRoom.userName]];
            self.lastMovingUser = self.username;
            
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
        // minh1
        for(Cell *cell in self.arrBoard) {
            if([piece checkMoveWithRow:cell.row Column:cell.column]) {
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


- (void) handleMessage:(NSDictionary *)val;
{
    if ([val[@"owner_id"] intValue] == [self.username intValue]) {
        return;
    }
    
    NSLog(@"ANOTHER USER SEND YOU MESSAGE %@", val);
    NSDictionary *dictValue = [Utils dictByJSONString:val[@"message"]];
    NSInteger rowValue = [dictValue[@"rowValue"] intValue];
    NSInteger columVal = [dictValue[@"columnValue"] intValue];
    NSInteger oldRow = [dictValue[@"oldRow"] intValue];
    NSInteger oldColumn = [dictValue[@"oldColumn"] intValue];
    BOOL eat = [dictValue[@"Eat"] boolValue];
    self.lastMovingUser = dictValue[@"owner_id"];
    NSLog(@"Row: %ld - Col: %ld",rowValue,columVal);
    
    if(!eat) {
        [UIView animateWithDuration:1.0f animations:^{
            [self getPieceAtCell:oldRow :oldColumn].center = [self getCell:rowValue :columVal].center;
        } completion:^(BOOL finished) {
            
        }];
    }
    else if(eat) {
        //[[self getPieceAtCell:rowValue :columVal] removeFromSuperview];
        UIView *v1 = [self getPieceAtCell:oldRow :oldColumn];
        UIView *v2 = [self getPieceAtCell:rowValue :columVal];
        [UIView animateWithDuration:1.0f animations:^{
            v1.center = v2.center;
        } completion:^(BOOL finished) {
            [v2 removeFromSuperview];
        }];
    }
}

- (Piece *) getPieceAtCell:(NSInteger)row :(NSInteger)column {
    for(Piece *piece in self.vBoard.subviews) {
        if([piece isKindOfClass:[Piece class]] && piece.row == row && piece.column == column) {
            return piece;
        }
    }
    
    return nil;
}

- (Cell *) getCell:(NSInteger)row :(NSInteger)column {
    for(Cell *piece in self.vBoard.subviews) {
        if([piece isKindOfClass:[Cell class]] && piece.row == row && piece.column == column) {
            return piece;
        }
    }
    
    return nil;
}


@end
