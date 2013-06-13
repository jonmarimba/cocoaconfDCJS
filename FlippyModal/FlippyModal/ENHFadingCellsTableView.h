//
//  ENHFadingCellsTableView.h
//  FadingTableView
//
//  Created by Jonathan Saggau on 6/24/12.
//  Copyright (c) 2012 Enharmonic inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ENHFadingCellsTableView : UITableView

//makes the cells fade out faster; useful for tuning based
//on your cell's contents.
@property(nonatomic, assign)CGFloat fadeMultiplier; 

@end
