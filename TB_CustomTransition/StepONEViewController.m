//
//  StepONEViewController.m
//  TB_CustomTransition
//
//  Created by Yari Dareglia on 7/30/13.
//  Copyright (c) 2013 Bitwaker. All rights reserved.
//

#import "StepONEViewController.h"
#import "StepTWOViewController.h"
#import "ContainerViewController.h"

#define CGRectSetPos( r, x, y ) CGRectMake( x, y, r.size.width, r.size.height )

@interface StepONEViewController ()

@end

@implementation StepONEViewController

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToStepTwo:(id)sender {
    StepTWOViewController *stepTWOViewController = [[StepTWOViewController alloc] init];
    ContainerViewController *containerController = (ContainerViewController*) self.parentViewController;
    
    [containerController presentViewController:stepTWOViewController];
}
@end
