#import "CustomBreadViewController.h"
#import "BreadcrumbView.h"

@implementation CustomBreadViewController

-(void)viewDidAppear:(BOOL)animated
{
    [self.breadCrumbView setAutomaticallySelectsNewButton:YES];
    [self.breadCrumbView setAutomaticallyRemovesFollowingButtonsOnSelection:YES];
    [self.breadCrumbView addSegmentWithTitle:@"hi" animated:NO];
    [self.breadCrumbView setDelegate:self];
}

-(void)breadCrumbView:(BreadcrumbView *)view didSelectButtonAtIndex:(NSUInteger)index;
{
    NSLog(@"Hey somebody selected button at index %d", index);
}

-(IBAction)addButton:(id )sender
{
    [self.breadCrumbView addSegmentWithTitle:@"hi" animated:YES];
}

-(IBAction)removeButton:(id )sender
{
    [self.breadCrumbView removeLastSegmentAnimated:YES];
}

@synthesize breadCrumbView;
     

@end