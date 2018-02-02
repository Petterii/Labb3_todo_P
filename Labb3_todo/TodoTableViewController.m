//
//  TodoTableViewController.m
//  Labb3_todo
//
//  Created by lösen är 0000 on 2018-01-29.
//  Copyright © 2018 Petteri Tuononen. All rights reserved.
//

#import "TodoTableViewController.h"
#import "AddViewController.h"
#import "DetailsViewController.h"
#import "TodoList.h"

@interface TodoTableViewController ()
@property (nonatomic) TodoList *todoInfo;

@end

@implementation TodoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.todoInfo = [[TodoList alloc] initList];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *rubrik;
    if (section == 0) {
        rubrik = @"Aktiva";
    }
    else if (section == 1)
        rubrik = @"Historik";
    return rubrik;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return self.todoInfo.todoList.count;
    }
    
    if (section == 1) {
        return self.todoInfo.todoHistory.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActiveTodo" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = self.todoInfo.todoList[indexPath.row][@"title"];
        NSString *prio = self.todoInfo.todoList[indexPath.row][@"prio"];
        if ([prio isEqualToString:@"YES"]) {
            cell.backgroundColor = [UIColor greenColor];
        }
    }
    
    if (indexPath.section == 1) {
        
        cell.textLabel.text = self.todoInfo.todoHistory[indexPath.row][@"title"];
        cell.backgroundColor = [UIColor grayColor];
        
    }
   
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name;
    if(indexPath.section == 1)
        name = @"Delete";
    else name = @"Done";
    
    return name;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewRowAction *doneButton = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Done" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                        {
                                            self.todoInfo.index =indexPath.row;
                                            [self.todoInfo moveCurrentRowToTemp];
                                            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                            [self.todoInfo tempListToHistory];
                                            [self.tableView reloadData];
                                        }];
       
        doneButton.backgroundColor = [UIColor blueColor];
        return @[doneButton];
    }
    
    return NULL;
    
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
 
        self.todoInfo.index =indexPath.row;

        if (indexPath.section == 1){
            [self.todoInfo removeArrayHistoryIndex];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        // Delete the row from the data source
        
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    self.todoInfo.index = indexPath.row;
    self.todoInfo.section = indexPath.section;
    
    if ([segue.identifier isEqualToString:@"Add"]){
        AddViewController *add = [segue destinationViewController];
        add.todoInfo = self.todoInfo;
        
        
    } else  if ([segue.identifier isEqualToString:@"Details"]){
        
        DetailsViewController *ar = [segue destinationViewController];
        ar.todoInfo = self.todoInfo;
    }
    
    
}


@end
