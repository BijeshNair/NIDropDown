//
//  NIViewController.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIViewController.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIViewController (){
    NSArray * arr;
    NSArray * arrImage;
}

@end

@implementation NIViewController

@synthesize btnSelect;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Hello 0", @"Hello 1", @"Hello 2", @"Hello 3", @"Hello 4", @"Hello 5", @"Hello 6", @"Hello 7", @"Hello 8", @"Hello 9",nil];
    arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
}

- (void)viewDidUnload {
//    [btnSelect release];
    btnSelect = nil;
    [self setBtnSelect:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
//    [btnSelect release];
//    [super dealloc];
}

- (IBAction)button1Clicked:(id)sender {
    if(dropDown1 == nil) {
        CGFloat f = 200;
        dropDown1 = [[NIDropDown alloc]showDropDown:sender theHeight:&f theArr:arr theImgArr:arrImage theDirection:@"down" withViewController:self];
        [dropDown1 setDropDownSelectionColor:[UIColor grayColor]];
        dropDown1.delegate = self;
    }
    else {
        [dropDown1 hideDropDown:sender];
//        [self rel];
    }
}

- (IBAction)button2Clicked:(UIButton *)sender {
    if(dropDown2 == nil) {
        CGFloat f = 200;
        dropDown2 = [[NIDropDown alloc]showDropDown:sender theHeight:&f theArr:arr theImgArr:arrImage theDirection:@"down" withViewController:self];
        [dropDown2 setDropDownSelectionColor:[UIColor grayColor]];
        dropDown2.delegate = self;
    }
    else {
        [dropDown2 hideDropDown:sender];
        //        [self rel];
    }
}


- (IBAction)button3Clicked:(UIButton *)sender {
    if(dropDown3 == nil) {
        CGFloat f = 200;
        dropDown3 = [[NIDropDown alloc]showDropDown:sender theHeight:&f theArr:arr theImgArr:arrImage theDirection:@"up" withViewController:self];
        [dropDown3 setDropDownSelectionColor:[UIColor grayColor]];
        dropDown3.delegate = self;
    }
    else {
        [dropDown3 hideDropDown:sender];
        //        [self rel];
    }
}


- (void) niDropDownDelegateMethod:(UIView *)sender withTitle:(NSString *)title {
//    [self rel];
    UIButton *btn = (UIButton *)sender;
    [btn setTitle:title forState:UIControlStateNormal];
//    NSLog(@"%@", btnSelect.titleLabel.text);
//    [btnSelect setTitle:title forState:UIControlStateNormal];
}

- (void)niDropDownHidden:(NIDropDown *)sender{
    if (sender == dropDown1) {
        dropDown1 = nil;
    }else if(sender == dropDown2){
        dropDown2 = nil;
    }else{
        dropDown3 = nil;
    }
    
}


@end
