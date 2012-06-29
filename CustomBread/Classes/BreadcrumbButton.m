#import "BreadcrumbButton.h"

@interface BreadcrumbButton ()
{
    CGGradientRef   normalGradient;
    CGGradientRef   highlightGradient;
}

@end

@implementation BreadcrumbButton

// set default values
-(void)ariseAndConquer
{
    [self setOpaque:NO];
    
    if (self.superview) 
    {
        [self setBackgroundColor:[[self superview] backgroundColor]];
    } 
    else 
    {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
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

- (void) dealloc
{
    if (highlightGradient) 
    {
        CGGradientRelease(highlightGradient);
    }
    
    if (normalGradient)
    {
        CGGradientRelease(normalGradient);
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)dirtyRect
{
	CGRect imageBounds = CGRectMake(0.0, 0.0, self.bounds.size.width - 0.5, self.bounds.size.height);
	CGRect bounds = [self bounds];
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat alignStroke;
	CGFloat resolution;
	CGFloat stroke;
	CGMutablePathRef path;
	CGPoint point;
	CGPoint controlPoint1;
	CGPoint controlPoint2;
	CGGradientRef gradient;
	UIColor *color;
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGPoint point2;
	resolution = 0.5f * (bounds.size.width / imageBounds.size.width + bounds.size.height / imageBounds.size.height);
	
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, bounds.origin.x, bounds.origin.y);
	CGContextScaleCTM(context, (bounds.size.width / imageBounds.size.width), (bounds.size.height / imageBounds.size.height));
	
	// Gradient
	
	stroke = 1.0f;
	stroke *= resolution;
	if (stroke < 1.0f) {
		stroke = ceilf(stroke);
	} else {
		stroke = roundf(stroke);
	}
	stroke /= resolution;
	stroke *= 2.0f;
	alignStroke = fmodf(0.5f * stroke * resolution, 1.0f);
	path = CGPathCreateMutable();
	point = CGPointMake(52.0f, 29.0f);
	point.x = (roundf(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (roundf(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathMoveToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(54.0f, 27.0f);
	point.x = (roundf(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (roundf(resolution * point.y + alignStroke) - alignStroke) / resolution;
	controlPoint1 = CGPointMake(53.097f, 29.0f);
	controlPoint2 = CGPointMake(54.0f, 28.097f);
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake(54.0f, 3.0f);
	point.x = (roundf(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (roundf(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(52.0f, 1.0f);
	point.x = (roundf(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (roundf(resolution * point.y + alignStroke) - alignStroke) / resolution;
	controlPoint1 = CGPointMake(54.0f, 1.903f);
	controlPoint2 = CGPointMake(53.097f, 1.0f);
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake(3.0f, 1.0f);
	point.x = (roundf(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (roundf(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(1.0f, 3.0f);
	point.x = (roundf(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (roundf(resolution * point.y + alignStroke) - alignStroke) / resolution;
	controlPoint1 = CGPointMake(1.903f, 1.0f);
	controlPoint2 = CGPointMake(1.0f, 1.903f);
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake(1.0f, 27.0f);
	point.x = (roundf(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (roundf(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(3.0f, 29.0f);
	point.x = (roundf(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (roundf(resolution * point.y + alignStroke) - alignStroke) / resolution;
	controlPoint1 = CGPointMake(1.0f, 28.097f);
	controlPoint2 = CGPointMake(1.903f, 29.0f);
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake(52.0f, 29.0f);
	point.x = (roundf(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (roundf(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	CGPathCloseSubpath(path);
	
    if (self.state == UIControlStateNormal)
        gradient = self.normalGradient;
    else
        gradient = self.highlightGradient;
    
	CGContextAddPath(context, path);
	CGContextSaveGState(context);
	CGContextEOClip(context);
	point = CGPointMake(27.478f, 30.416f);
	point2 = CGPointMake(27.478f, 1.483f);
	CGContextDrawLinearGradient(context, gradient, point, point2, (kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation));
	CGContextRestoreGState(context);
	color = [UIColor colorWithRed:0.173f green:0.173f blue:0.173f alpha:1.0f];
	[color setStroke];
	CGContextSetLineWidth(context, stroke);
	CGContextSetLineCap(context, kCGLineCapSquare);
	CGContextSaveGState(context);
	CGContextAddPath(context, path);
	CGContextAddRect(context, imageBounds);
	CGContextEOClip(context);
	CGContextAddPath(context, path);
	CGContextStrokePath(context);
	CGContextRestoreGState(context);
	CGPathRelease(path);
	
	CGContextRestoreGState(context);
	CGColorSpaceRelease(space);
}


- (CGGradientRef)normalGradient
{
    if (normalGradient == NULL)
    {
        CGFloat locations[3];
        
        NSMutableArray *colors = [NSMutableArray arrayWithCapacity:3];
        UIColor *color = [UIColor colorWithRed:0.373f green:0.373f blue:0.373f alpha:1.0f];
        [colors addObject:(id)[color CGColor]];
        locations[0] = 1.0f;
        color = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f];
        [colors addObject:(id)[color CGColor]];
        locations[1] = 0.694f;
        color = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
        [colors addObject:(id)[color CGColor]];
        locations[2] = 0.289f;
        CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
        normalGradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)colors, locations);
        CGColorSpaceRelease(space);
    }
    return normalGradient;
}

- (CGGradientRef)highlightGradient
{
    if (highlightGradient == NULL)
    {
        CGFloat locations[2];
        
        NSMutableArray *colors = [NSMutableArray arrayWithCapacity:2];
        UIColor *color = [UIColor colorWithRed:0.128f green:0.128f blue:0.128f alpha:1.0f];
        [colors addObject:(id)[color CGColor]];
        locations[0] = 0.0f;
        color = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
        [colors addObject:(id)[color CGColor]];
        locations[1] = 1.0f;
        
        CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
        highlightGradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)colors, locations);
        CGColorSpaceRelease(space);
    }
    return highlightGradient;
}

//hesitateUpdate stuff from http://code.google.com/p/iphonegradientbuttons/
#pragma mark -
#pragma mark Touch Handling
- (void)hesitateUpdate
{
    [self setNeedsDisplay];
    [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0.1];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self setNeedsDisplay];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self hesitateUpdate];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self setNeedsDisplay];
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self hesitateUpdate];
}


@end
