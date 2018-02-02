//
//  DetailsViewController.m
//  Labb3_todo
//
//  Created by lösen är 0000 on 2018-01-30.
//  Copyright © 2018 Petteri Tuononen. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *detailText;
@property (weak, nonatomic) IBOutlet UITextField *titleLabe;
@property (weak, nonatomic) IBOutlet UISwitch *prioSwitch;
@property (weak, nonatomic) IBOutlet UIButton *moveToComplete;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    if(self.todoInfo.section == 0){
       self.detailText.text = self.todoInfo.todoList[self.todoInfo.index][@"detail"];
        self.titleLabe.text = self.todoInfo.todoList[self.todoInfo.index][@"title"];
        self.moveToComplete.hidden = NO;
        self.saveButton.hidden = YES;
        self.prioSwitch.hidden = NO;
        if ([self.todoInfo.todoList[self.todoInfo.index][@"prio"] isEqualToString:@"YES"]) {
            [self.prioSwitch setOn:YES animated:YES];
        }
    } else if (self.todoInfo.section == 1){
       self.detailText.text = self.todoInfo.todoHistory[self.todoInfo.index][@"detail"];
       self.titleLabe.text= self.todoInfo.todoHistory[self.todoInfo.index][@"title"];
        self.moveToComplete.hidden = YES;
        self.saveButton.hidden = YES;
        self.prioSwitch.hidden = YES;
    }
    
  
}

- (IBAction)noteDone:(id)sender {
    
    [self.todoInfo moveToHistory];
    
    [self.navigationController popViewControllerAnimated:YES];
}

// todo future update
- (IBAction)saveButton:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
