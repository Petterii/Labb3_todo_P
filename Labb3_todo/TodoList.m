//
//  TodoList.m
//  Labb3_todo
//
//  Created by lösen är 0000 on 2018-01-30.
//  Copyright © 2018 Petteri Tuononen. All rights reserved.
//

#import "TodoList.h"

@implementation TodoList

-(instancetype)initList {
    self = [super self];
    if (self) {
        NSUserDefaults *saveTodo = [NSUserDefaults standardUserDefaults];
        self.todoHistory = [saveTodo objectForKey:@"todohistory"];
        self.todoList = [saveTodo objectForKey:@"todolist"];
        
        if (self.todoList == nil && self.todoHistory == nil) {
            self.todoList = @[];
            self.todoHistory = @[];
        }
    }
    return self;
}


-(void)addToList:(NSString*)title detail:(NSString*)detail prio:(NSString*)prio{
    NSDictionary *newNote = @{@"title":title, @"detail":detail, @"prio":prio};
    NSMutableArray *addNote = @[].mutableCopy;
    [addNote addObjectsFromArray:self.todoList];
    if ([prio isEqualToString:@"YES"]) {
        [addNote insertObject:newNote atIndex:0];
        
    }else   [addNote addObject:newNote];
    self.todoList = [addNote copy];
   
    [self saveUsersD];
}

-(NSArray*)removeCurrentIndex:(NSArray*)list{
    NSMutableArray *changeList = @[].mutableCopy;
    [changeList addObjectsFromArray:list];
    [changeList removeObjectAtIndex:self.index];
    list = [changeList copy];
    return list;
}

-(void)moveCurrentRowToTemp{
    self.inTempMove = self.todoList[self.index];
    [self removeArrayListIndex];
}

-(void)tempListToHistory{
    NSMutableArray *changeHistory = @[].mutableCopy;
    [changeHistory addObjectsFromArray:self.todoHistory];
    [changeHistory addObject:self.inTempMove];
    self.todoHistory = [changeHistory copy];
}

-(void)moveToHistory{
    // Move note to History
    NSMutableArray *changeHistory = @[].mutableCopy;
    [changeHistory addObjectsFromArray:self.todoHistory];
    [changeHistory addObject:self.todoList[self.index]];
    self.todoHistory = [changeHistory copy];
    
    // remove note from Active list
   self.todoList = [self removeCurrentIndex:self.todoList];
    [self saveUsersD];
}


-(void)removeArrayListIndex{
    self.todoList = [self removeCurrentIndex:self.todoList];
    [self saveUsersD];
}

-(void)removeArrayHistoryIndex{
    self.todoHistory = [self removeCurrentIndex:self.todoHistory];
    [self saveUsersD];
}

-(void)saveUsersD{
    NSUserDefaults *saveTodo = [NSUserDefaults standardUserDefaults];
    [saveTodo setObject:self.todoList forKey:@"todolist"];
    [saveTodo setObject:self.todoHistory forKey:@"todohistory"];
}

@end
