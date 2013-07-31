//
//  StepTWOViewController.m
//  TB_CustomTransition
//
//  Created by Yari Dareglia on 7/30/13.
//  Copyright (c) 2013 Bitwaker. All rights reserved.
//

#import "StepTWOViewController.h"
#import "StepONEViewController.h"
#import "ContainerViewController.h"

@interface StepTWOViewController ()

@end

@implementation StepTWOViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToStepONE:(id)sender {
    StepONEViewController *stepONEViewController = [[StepONEViewController alloc] init];
    ContainerViewController *containerController = (ContainerViewController*) self.parentViewController;
    
    [containerController presentViewController:stepONEViewController];
}

@end
