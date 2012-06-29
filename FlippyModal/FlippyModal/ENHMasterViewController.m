#import "ENHMasterViewController.h"
#import "ENHDetailViewController.h"
#import "UIViewController+CenteredModalPresentation.h"
#import "ENHFlipInViewControllerTest.h"
#import "ENHFadingCellsTableView.h"
#import "CustomTableViewCell.h"

#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAShapeLayer.h>

static NSString *CellIdentifier = @"CustomTableViewCell";

@interface ENHMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation ENHMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    UIImage *background = [UIImage imageNamed:@"TableViewBackGroundImage"];
    UIColor *backgroundColor = [[UIColor alloc] initWithPatternImage:background];
    [self.view setBackgroundColor:backgroundColor];
    
    
    // Load and register the NIB file
    UINib *nib = [UINib nibWithNibName:CellIdentifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    [self.tableView setRowHeight:58.0f];
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if ([self.tableView isKindOfClass:[ENHFadingCellsTableView class]])
    {
        [(ENHFadingCellsTableView *)self.tableView setFadeMultiplier:1.5f];
    }
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    CALayer *cellLayer = [cell layer];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat bottomLineWidth = 1.0;
    CGSize layerSize = [cellLayer bounds].size;
    
    layerSize.height -= bottomLineWidth * .5;
    CGRect layerRect = CGRectZero;
    layerRect.size = layerSize;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:layerRect];
    [shapeLayer setPath:path.CGPath];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setLineWidth:bottomLineWidth];
    [shapeLayer setStrokeColor:[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor];
    
    // Add a line along the bottom shapelayer style
    CGFloat overallLength = (layerSize.height * 2) + (layerSize.width * 2);
    CGFloat strokeStart = ((layerSize.width + layerSize.height) / overallLength);
    CGFloat strokeEnd = ((layerSize.width * 2 + layerSize.height) / overallLength);
    [shapeLayer setStrokeStart:strokeStart];
    [shapeLayer setStrokeEnd:strokeEnd];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil]];
    [cellLayer addSublayer:shapeLayer];
    
    NSDate *object = [_objects objectAtIndex:indexPath.row];
    cell.middleLabel.text = [object description];
    [cell.middleLabel setTextColor:[UIColor whiteColor]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(void)dismissFlippy:(UITapGestureRecognizer *)recognizer
{
    UIViewController *rootViewController = [[[[self detailViewController] view] window] rootViewController];
    [rootViewController dismissModalViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *object = [_objects objectAtIndex:indexPath.row];
    self.detailViewController.detailItem = object;
    
    ENHFlipInViewControllerTest *flipIn = [[ENHFlipInViewControllerTest alloc] init];
    
    [flipIn setModalPresentationStyle:UIModalPresentationFormSheet];
    [flipIn setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    UIViewController *rootViewController = [[[[self detailViewController] view] window] rootViewController];
    [rootViewController presentCenteredModalViewController:flipIn animated:YES];
    //    [rootViewController presentModalViewController:flipIn animated:YES];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFlippy:)];
    [flipIn.view addGestureRecognizer:tapRecognizer];
}

@end
