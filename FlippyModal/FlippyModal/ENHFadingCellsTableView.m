//
//  ENHFadingCellsTableView.m
//  FadingTableView
//
//  Created by Jonathan Saggau on 6/24/12.
//  Copyright (c) 2012 Enharmonic inc. All rights reserved.
//

#import "ENHFadingCellsTableView.h"

@implementation ENHFadingCellsTableView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setFadeMultiplier:1.0f];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setFadeMultiplier:1.0f];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self setFadeMultiplier:1.0f];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSMutableArray *visible = [[self visibleCells] mutableCopy];
    if ([visible count] > 0)
    {
        
        UITableViewCell *topCell = [visible objectAtIndex:0];
        UITableViewCell *bottomCell = [visible lastObject];
        [visible removeObject:topCell];
        [visible removeObject:bottomCell];
        for (UITableViewCell *cell in visible)
        {
            [cell setAlpha:1.0];
        }
        
        CGPoint contentOffset = [self contentOffset];
        CGRect topFrame = [topCell convertRect:[topCell bounds] toView:self];  
        CGFloat topMinY = CGRectGetMinY(topFrame);
        topMinY -= contentOffset.y;
        
        if (topMinY < 0)
        {
            //sliding up off screen
            CGFloat fractionOffTop = topMinY / topFrame.size.height * [self fadeMultiplier];
            [topCell setAlpha:1.0 + fractionOffTop];
        }
        else 
        {
            [topCell setAlpha:1.0];
        }
        
        CGRect bottomFrame = [bottomCell convertRect:[bottomCell bounds] toView:self];
        CGFloat bottomMaxY = CGRectGetMaxY(bottomFrame);
        bottomMaxY -= [self bounds].size.height;
        bottomMaxY -= contentOffset.y;
        
        if (bottomMaxY > 0)
        {
            CGFloat fractionOffbottom = bottomMaxY / bottomFrame.size.height * [self fadeMultiplier];
            [bottomCell setAlpha:1.0 - fractionOffbottom];
        }
        else 
        {
            [bottomCell setAlpha:1.0];
        }
    }
}

@synthesize fadeMultiplier = _fadeMultiplier;

@end
