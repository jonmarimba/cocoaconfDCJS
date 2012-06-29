#import <UIKit/UIKit.h>
#import "BreadcrumbView.h"


@interface CustomBreadViewController : UIViewController <BreadcrumbViewDelegate> 

@property(nonatomic, weak)IBOutlet BreadcrumbView *breadCrumbView;

-(IBAction)addButton:(id )sender;
-(IBAction)removeButton:(id )sender;

@end

