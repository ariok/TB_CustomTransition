//
//  ContainerViewController.m
//  TB_CustomTransition
//
//  Created by Yari Dareglia on 7/28/13.
//  Copyright (c) 2013 Bitwaker. All rights reserved.
//

#import "ContainerViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ContainerViewController ()

@end

@implementation ContainerViewController

- (id)initWithViewController:(UIViewController*)viewController{
    
    if(self = [super init]){
        self.currentViewController = viewController;
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addChildViewController: self.currentViewController ];
    [self.detailView addSubview: self.currentViewController.view];
    [self.currentViewController didMoveToParentViewController:self];

}

//This function performs tha exchange between the CURRENT and the NEXT view
- (void)presentViewController:(UIViewController *)viewController{
    
    //A. Container hierarchy management ------------------------------
    
    //1. The current controller is going to be removed
    [self.currentViewController willMoveToParentViewController:nil];
    
    //2. The new controller is a new child of the container
    [self addChildViewController:viewController];
    
    //3. Setup the new controller's frame depending on the animation you want to obtain
    viewController.view.frame = CGRectMake(0, 0, self.detailView.frame.size.width, self.detailView.frame.size.height);

    
    
    
    //B. Generate images and setting up views (Screenshots) ------------------------
    
    //4. Create a screenshot of the CURRENT view and setup its layer
    UIImageView *currentView = [self takeScreenshot:self.view.layer];
    //4b. Build a view with black bg and attach here the just taken screenshot 
    UIView *blackView = [self blackView];
    [blackView addSubview:currentView];
    
    CGRect oldFrame = [currentView.layer frame];
    currentView.layer.anchorPoint = CGPointMake(0,0.5);
    currentView.layer.frame = oldFrame;
    
    //5. Hide the CURRENT view (we've taken the screenshot)
    [self.currentViewController.view setHidden:YES];

    //6. Add the new view to the detail view
    [self.detailView addSubview:viewController.view];
    
    //7. Create a screenshot of the NEXT view and setup its layer
    UIImageView *nextView = [self takeScreenshot:self.view.layer];
    oldFrame = [nextView.layer frame];
    nextView.layer.anchorPoint = CGPointMake(0,0.5);
    nextView.layer.frame = oldFrame;
    nextView.frame = CGRectMake(-self.view.frame.size.width, 0, nextView.frame.size.width, nextView.frame.size.height);
    //7.b Attach the screen shot to the black background view
    [blackView addSubview:nextView];
    [self.view addSubview:blackView];
    
    
    
    
    //C. THE ANIMATION!!!! ------------------------------------------
    
    //8. Setup the NEXT view layer
    CATransform3D tp = CATransform3DIdentity;
    tp.m34 = 1.0/ -500;
    tp = CATransform3DTranslate(tp, -300.0f, -10.0f, 300.0f);
    tp = CATransform3DRotate(tp, radianFromDegree(20), 0.0f,1.0f, 0.8f);
    nextView.layer.transform = tp;
    nextView.layer.opacity = 0.0f;
    
    //9. Finally, perform the animation from PREVIOUS to NEXT view
    [UIView animateWithDuration:1.0
     
    //9b. Animate the views to create a transition effect
    animations:^{
        
        //9c. Create transition for the CURRENT view. 
        CATransform3D t = CATransform3DIdentity;
        t.m34 = 1.0/ -500;
        t = CATransform3DRotate(t, radianFromDegree(5.0f), 0.0f,0.0f, 1.0f);
        t = CATransform3DTranslate(t, viewController.view.frame.size.width * 2, 0.0f, -400.0);
        t = CATransform3DRotate(t, radianFromDegree(-45), 0.0f,1.0f, 0.0f);
        t = CATransform3DRotate(t, radianFromDegree(50), 1.0f,0.0f, 0.0f);
        currentView.layer.transform = t;
        currentView.layer.opacity = 0.0;
        
        //9d. Create transition for the NEXT view. 
        CATransform3D t2 = CATransform3DIdentity;
        t2.m34 = 1.0/ -500;
        t2 = CATransform3DTranslate(t2, viewController.view.frame.size.width, 0.0f, 0.0);
        nextView.layer.transform = t2;
        nextView.layer.opacity = 1.0;

    }

     
    //D. Container hierarchy management ------------------------------
    //10. At the end of the animations we remove the previous view and update the Controller hierarchy.
    completion:^(BOOL finished) {
        
        
        //Remove the old Detail Controller view from superview
        [self.currentViewController.view removeFromSuperview];
     
        //Remove the old Detail controller from the hierarchy
        [self.currentViewController removeFromParentViewController];
     
        //Set the new view controller as current
        self.currentViewController = viewController;
        [self.currentViewController didMoveToParentViewController:self];
     
        //The Black backogrund view is no more needed
        [blackView removeFromSuperview];
     
    }];
    
    
    
}


//Create a view with a black background
- (UIView*)blackView{
    
    UIView *bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    return bgView;
}


//Create a UIImageView from the given layer
- (UIImageView*)takeScreenshot:(CALayer*)layer{
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, [[UIScreen mainScreen] scale]);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIImageView *screnshot = [[UIImageView alloc] initWithImage:image];
    
    return screnshot;
}



#pragma mark - Convert Degrees to Radian
double radianFromDegree(float degrees) {
    return (degrees / 180) * M_PI;
}

@end
