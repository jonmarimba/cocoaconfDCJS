//
//  CustomTableViewCell.m
//  FlippyModal
//
//  Created by Jonathan on 6/28/12.
//  Copyright (c) 2012 Enharmonic inc. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()


@end

@implementation CustomTableViewCell
@synthesize middleLabel = _middleLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
