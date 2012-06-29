#import <UIKit/UIKit.h>

@class BreadcrumbView;

@protocol BreadcrumbViewDelegate
@optional
-(void)breadCrumbView:(BreadcrumbView *)view didSelectButtonAtIndex:(NSUInteger)index;

@end

@interface BreadcrumbView : UIView 

@property(nonatomic, weak)NSObject <BreadcrumbViewDelegate> *delegate;
@property(nonatomic, assign)BOOL automaticallySelectsNewButton;
@property(nonatomic, assign)BOOL automaticallyRemovesFollowingButtonsOnSelection;
@property(nonatomic, assign)BOOL showsTouchWhenHighlighted;

//simplified version of the UISegmentedControl API
-(void)addSegmentWithImage:(UIImage *)image animated:(BOOL )animated;
-(void)addSegmentWithTitle:(NSString *)title animated:(BOOL )animated; 
-(void)removeLastSegmentAnimated:(BOOL )animated;

-(NSUInteger)segmentCount;
-(NSArray *)segments;

@end

