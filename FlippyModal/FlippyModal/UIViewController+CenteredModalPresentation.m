#import "UIViewController+CenteredModalPresentation.h"

@implementation UIViewController (CenteredModalPresentation)

-(void)presentCenteredModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    if ([modalViewController modalPresentationStyle] == UIModalPresentationFormSheet)
    {
        CGRect frame = [modalViewController.view frame];
        [self presentModalViewController:modalViewController animated:animated];
        UIView *modalSuper = [modalViewController.view superview];
        CGRect superFrame = [modalSuper frame];
        CGFloat widthDelta = superFrame.size.width - frame.size.width;
        CGFloat heightDelta = superFrame.size.height - frame.size.height;
        
        superFrame.size = frame.size;
        superFrame.origin.x += floorf(widthDelta * 0.5f);
        superFrame.origin.y += floorf(heightDelta * 0.5f);
        superFrame = CGRectIntegral(superFrame);
        [modalViewController.view.superview setFrame:superFrame];
    }
    else
    {
        [self presentModalViewController:modalViewController animated:animated];
    }
}
@end
