//
//  TodoList.h
//  Labb3_todo
//
//  Created by lösen är 0000 on 2018-01-30.
//  Copyright © 2018 Petteri Tuononen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoList : NSObject
@property (nonatomic) NSArray *todoList;
@property (nonatomic) NSArray *todoHistory;
@property (nonatomic) NSDictionary *inTempMove;

@property (nonatomic) long index;
@property (nonatomic) long section;


-(void)addToList:(NSString*)title detail:(NSString*)detail prio:(NSString*)prio;
-(void)moveToHistory;
-(void)removeArrayListIndex;
-(void)removeArrayHistoryIndex;
-(instancetype)initList;
-(void)moveCurrentRowToTemp;
-(void)tempListToHistory;
@end
