#import "BreadcrumbView.h"
#import "BreadcrumbButton.h"
#import "ChevronBreadcrumbButton.h"
#import "BreadcrumbViewPrivateMethods.h"

#import <QuartzCore/QuartzCore.h>

@interface BreadcrumbView ()
{
    NSMutableArray *buttons;
    CGFloat buttonOverlap;
    CGFloat buttonOffset;
    CGFloat buttonWidth;
    CGFloat buttonHeight;
}

@end

@implementation BreadcrumbView

// set default values
-(void)ariseAndConquer
{
    [self setOpaque:NO];
    if(!buttons)
        buttons = [[NSMutableArray alloc] init];
    
    buttonOverlap = 7.0f;
    buttonOffset = 2.0f;
    buttonWidth = 55.0f;
    buttonHeight = 30.0f;
    
    CALayer *layer = [self layer];
    [layer setCornerRadius:4.0f];
    UIColor *backgd = [UIColor colorWithRed:69./255. green:69./255. blue:69./255. alpha:1.0];
    [layer setBorderColor:backgd.CGColor];
    [self setBackgroundColor:backgd];
    [layer setBorderWidth:2.0f];
    showsTouchWhenHighlighted = YES;
}

- (void)willMoveToSuperview:(UIView *)newSuperview;
{
    [self ariseAndConquer];
}


- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self ariseAndConquer];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self ariseAndConquer];
	}
	return self;
}

@synthesize delegate;
@synthesize automaticallySelectsNewButton;
@synthesize automaticallyRemovesFollowingButtonsOnSelection;
@synthesize showsTouchWhenHighlighted;

- (CGSize)sizeThatFits:(CGSize)unusedSize
{
    CGRect myFrame = [self frame];
    CGSize size = myFrame.size;
    
    NSUInteger i, count = [buttons count];
    
    size.height = (buttonOffset * 2.0f) + buttonHeight;
    size.width = (buttonOffset * 2.0f);
    
    for (i = 0; i < count; i++) 
    {
        CGRect frame = CGRectMake(0.0f, buttonOffset, buttonWidth, buttonHeight);
        frame.origin.x = buttonOffset + (buttonWidth * (float)i) - (buttonOverlap * (float)i);
        size.width = frame.origin.x + buttonOffset + buttonWidth;
    }
    return size;
}

-(void)updateGeometry:(BOOL )animated
{
    CGRect myFrame = [self frame];
    
    NSUInteger i, count = [buttons count];
    myFrame.size = [self sizeThatFits:CGSizeZero];
    
    if (animated) 
    {
        [UIView beginAnimations:@"updateGeometry" context:nil];
    }
    
    for (i = 0; i < count; i++) {
        CGRect frame = CGRectMake(0.0f, buttonOffset, buttonWidth, buttonHeight);
        UIButton *button = [buttons objectAtIndex:i];
        frame.origin.x = buttonOffset + (buttonWidth * (float)i) - (buttonOverlap * (float)i);
        [button setFrame:frame];
        [button setAlpha:1.0];
    }
    [self setFrame:myFrame];   
    if (animated)
    {
        [UIView commitAnimations];
    }
}

-(void)layoutSubviews
{
    [self updateGeometry:NO];
}

-(void)pushMybuttons:(id)button
{    
    for (UIButton *aButton in buttons) 
    {
        if (button == aButton) {
            [button setSelected:YES];
        }
        else {
            [button setSelected:NO];
        }
    }
    
    if(automaticallyRemovesFollowingButtonsOnSelection)
    {
        while (button != [buttons lastObject]) 
        {
            [self removeLastSegmentAnimated:YES];
        }
    }
    
    NSUInteger indexOfButton = [buttons indexOfObject:button];
    if (delegate && [delegate respondsToSelector:@selector(breadCrumbView:didSelectButtonAtIndex:)]) 
    {
        [delegate breadCrumbView:self didSelectButtonAtIndex:indexOfButton];
    }
}

-(void)addButton:(UIButton *)currentButton animated:(BOOL )animated
{
    UIButton *lastButton = [buttons lastObject];
    [currentButton addTarget:self action:@selector(pushMybuttons:) forControlEvents:UIControlEventTouchUpInside];
    if (lastButton) {
        CGRect frame = [lastButton frame];
        [currentButton setFrame:frame];
        [currentButton setAlpha:0.0];
    }
    
    if(automaticallySelectsNewButton)
    {
        for (UIButton *button in buttons) 
        {
            [button setSelected:NO];
        }
        [currentButton setSelected:YES];
    }
    [currentButton setShowsTouchWhenHighlighted:showsTouchWhenHighlighted];
    [buttons addObject:currentButton];
    [self addSubview:currentButton];
    [self updateGeometry:animated];
}

-(UIButton *)nextButton
{
    UIButton *currentButton = nil;
    if([buttons count] <= 0)
    {
        currentButton = [[BreadcrumbButton alloc] initWithFrame:CGRectZero];
    }
    else 
    {
        currentButton = [[ChevronBreadcrumbButton alloc] initWithFrame:CGRectZero];
    }
    return currentButton;
}

//simplified version of the UISEgmentedControl API
-(void)addSegmentWithImage:(UIImage *)image animated:(BOOL )animated
{
    UIButton *nextButton = [self nextButton];
    [nextButton setImage:image forState:UIControlStateNormal];
    if([buttons count] > 0)
    {
        [nextButton setImageEdgeInsets:UIEdgeInsetsMake(0, 7, 0, 0)];
    }
    [self addButton:nextButton animated:animated];
}

-(void)addSegmentWithTitle:(NSString *)title animated:(BOOL )animated; 
{
    UIButton *nextButton = [self nextButton];
    [nextButton setTitle:title forState:UIControlStateNormal];
    if([buttons count] > 0)
    {
        [nextButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 7, 0, 0)];
    }
    [self addButton:nextButton animated:animated];
}

-(void)animationDidStop:(NSString *)animationID 
               finished:(NSNumber *)finished 
                context:(void *)context
{
    if([@"removeLastSegment" isEqualToString:animationID])
    {
        UIButton *button = (__bridge id)context;
        
        [button removeFromSuperview];
        [self updateGeometry:NO];
    }
}

-(void)removeLastSegment
{
    [self removeLastSegmentAnimated:YES];
}

-(void)removeLastSegmentAnimated:(BOOL )animated;
{
    UIButton *lastButton = [buttons lastObject];
    
    if (!lastButton) 
    {
        return;
    }
    
    [lastButton removeTarget:self action:@selector(pushMybuttons:) forControlEvents:UIControlEventTouchUpInside];
    [lastButton setSelected:NO];
    [buttons removeLastObject];

    if(animated)
    {
        [UIView beginAnimations:@"removeLastSegment" context:(__bridge_retained void *)(lastButton)];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        UIButton *penultimateButton = [buttons lastObject];
        CGRect frame = [penultimateButton frame];
        [lastButton setAlpha:0.0];
        [lastButton setFrame:frame];
        [self updateGeometry:NO]; // we already started a beginAnimations, so no need to animate inside of updateGeometry:
        [UIView commitAnimations];
    }
    else 
    {
        [lastButton removeFromSuperview];
        [self updateGeometry:NO];
    }
    
    if(automaticallySelectsNewButton)
    {
        lastButton = [buttons lastObject];
        [lastButton setSelected:YES];
    }
}

-(NSUInteger)segmentCount
{
    return [buttons count];
}

-(NSArray *)segments
{
    if (IsEmpty(buttons)) {
        return [NSArray array];
    }
    return [NSArray arrayWithArray:buttons];
}

@end




