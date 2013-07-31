//
//  ContainerViewController.h
//  TB_CustomTransition
//
//  Created by Yari Dareglia on 7/28/13.
//  Copyright (c) 2013 Bitwaker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) UIViewController *currentViewController;

- (id)initWithViewController:(UIViewController*)viewController;
- (void)presentViewController:(UIViewController *)viewController;

@end
