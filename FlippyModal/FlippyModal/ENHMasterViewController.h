#import <UIKit/UIKit.h>

@class ENHDetailViewController;

@interface ENHMasterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak)IBOutlet UITableView *tableView;
@property (nonatomic, strong) ENHDetailViewController *detailViewController;

@end
