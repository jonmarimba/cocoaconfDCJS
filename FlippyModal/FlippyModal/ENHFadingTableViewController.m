//
//  ENHViewController.m
//  FadingTableView
//
//  Created by Jonathan Saggau on 6/24/12.
//  Copyright (c) 2012 Enharmonic inc. All rights reserved.
//

#import "ENHFadingTableViewController.h"

@interface ENHFadingTableViewController ()

@end

@implementation ENHFadingTableViewController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TableViewCell"];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
