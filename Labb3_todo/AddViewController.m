//
//  AddViewController.m
//  Labb3_todo
//
//  Created by lösen är 0000 on 2018-01-30.
//  Copyright © 2018 Petteri Tuononen. All rights reserved.
//

#import "AddViewController.h"
#import "TodoList.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextView *detailedText;
@property (weak, nonatomic) IBOutlet UISwitch *prioSwitch;
@property (weak, nonatomic) IBOutlet UITextField *titleTextInput;


@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)savedButton:(id)sender {

   
    
    NSString *title =self.titleTextInput.text;
    NSString *detail = self.detailedText.text;
    NSString *prio = @"";
    
    if(self.prioSwitch.isOn)
        prio = @"YES";
    else prio = @"NO";
    
    [self.todoInfo addToList:title detail:detail prio:prio];
    
    [self.navigationController popViewControllerAnimated:YES];
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
