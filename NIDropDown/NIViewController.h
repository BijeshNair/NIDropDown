//
//  NIViewController.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface NIViewController : UIViewController <NIDropDownDelegate>
{
    IBOutlet UIButton *btnSelect;
    NIDropDown *dropDown;
}

@property (retain, nonatomic) IBOutlet UIButton *btnSelect;
- (IBAction)selectClicked:(id)sender;

-(void)rel;
@end
