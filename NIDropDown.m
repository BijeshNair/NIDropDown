//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

#define SCREEN_BOUND [[UIScreen mainScreen]bounds]
#define DEFAULT_ALIGNMENT 5

@interface NIDropDown ()
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIView *btnSender;
@property(nonatomic, strong) NSArray *list;
@property(nonatomic, strong) NSArray *imageList;
@property(nonatomic, strong) UIViewController *dropDownViewController;
@property(nonatomic, strong) UIButton *backgroundButton;
@property(nonatomic) NSTextAlignment dropDownItemTextAlignment;
@property(nonatomic, strong) UIColor *itemBackgroundColor;
@property(nonatomic, strong) UIColor *itemTextColor;
@property(nonatomic, strong) UIColor *itemSelectionColor;
@property(nonatomic, strong) UIColor *itemSelectionTextColor;
@property(nonatomic, strong) UIColor *tableSeparatorColor;
@property(nonatomic, strong) UIColor *tableBackgroundColor;
@property(nonatomic, strong) UIColor *backgroundDimViewColor;
@property(nonatomic) CGFloat backgroundDimViewAlpha;
@end

@implementation NIDropDown
@synthesize table;
@synthesize btnSender;
@synthesize list;
@synthesize imageList;
@synthesize delegate;
@synthesize animationDirection;

- (id)showDropDown:(UIView *)b theHeight:(CGFloat *)height theArr:(NSArray *)arr theImgArr:(NSArray *)imgArr theDirection:(NSString *)direction withViewController:(UIViewController *)viewController {
    btnSender = b;
    _dropDownItemTextAlignment = DEFAULT_ALIGNMENT;
    animationDirection = direction;
    self.table = (UITableView *)[super init];
    self.dropDownViewController = viewController;
    if (self) {
        // Initialization code
        CGRect btn = b.frame;
        
        self.list = [NSArray arrayWithArray:arr];
        self.imageList = [NSArray arrayWithArray:imgArr];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }else if ([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, 5);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 5;
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y-*height, btn.size.width, *height);
        } else if([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *height);
        }
        table.frame = CGRectMake(0, 0, btn.size.width, *height);
        table.bounces = NO;
        [UIView commitAnimations];
        [b.superview addSubview:self];
        _backgroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_BOUND.size.width, SCREEN_BOUND.size.height)];
        [_backgroundButton setBackgroundColor:[UIColor clearColor]];
        [_backgroundButton addTarget:self action:@selector(hideDimView:) forControlEvents:UIControlEventTouchUpInside];
        [b.superview addSubview:_backgroundButton];
        [b.superview sendSubviewToBack:_backgroundButton];
        
        [self addSubview:table];
    }
    return self;
}

-(void)hideDropDown:(UIButton *)b {
    CGRect btn = b.frame;
    
    CGRect originGlobal = [b convertRect:btn toView:nil];
    originGlobal.origin.x = 15;
    originGlobal.origin.y = originGlobal.origin.y + 46.5;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if ([animationDirection isEqualToString:@"up"]) {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, self.frame.size.width, 0);
    }else if ([animationDirection isEqualToString:@"down"]) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
    }
    table.frame = CGRectMake(0, 0, originGlobal.size.width, 0);
    [UIView commitAnimations];
    [_backgroundButton removeFromSuperview];
    [self.delegate niDropDownHidden:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.preservesSuperviewLayoutMargins = NO;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        
    }
    if ([self.imageList count] == [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        cell.imageView.image = [imageList objectAtIndex:indexPath.row];
    } else if ([self.imageList count] > [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        if (indexPath.row < [imageList count]) {
            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
        }
    } else if ([self.imageList count] < [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        if (indexPath.row < [imageList count]) {
            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
        }
    }
    
    if(_itemBackgroundColor != nil){
        cell.backgroundColor = _itemBackgroundColor;
    } else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    if(_dropDownItemTextAlignment != DEFAULT_ALIGNMENT){
        cell.textLabel.textAlignment = _dropDownItemTextAlignment;
    } else{
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    if(_itemSelectionColor != nil){
        UIView * v = [[UIView alloc] init];
        v.backgroundColor = _itemSelectionColor;
        cell.selectedBackgroundView = v;
    } else{
        UIView * v = [[UIView alloc] init];
        v.backgroundColor = [UIColor colorWithRed:0/255.0f green:152/255.0f blue:255/255.0f alpha:1.0f];
        cell.selectedBackgroundView = v;
    }
    
    if(_itemTextColor != nil){
        cell.textLabel.textColor = _itemTextColor;
    } else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown:btnSender];
    
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
//    [btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
    
    for (UIView *subview in btnSender.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            [subview removeFromSuperview];
        }
    }
    if(_itemSelectionTextColor != nil){
        c.textLabel.textColor = _itemSelectionTextColor;
    } else{
        c.textLabel.textColor = [UIColor blackColor];
    }
    imgView.image = c.imageView.image;
    imgView = [[UIImageView alloc] initWithImage:c.imageView.image];
    imgView.frame = CGRectMake(5, 5, 25, 25);
    [btnSender addSubview:imgView];
    [self myDelegate:c.textLabel.text];
    [_backgroundButton removeFromSuperview];
}

- (void) myDelegate:(NSString *)title {
    [self.delegate niDropDownDelegateMethod:btnSender withTitle:title];
}

-(IBAction)hideDimView:(id)sender{
    [self hideDropDown:btnSender];
}

-(void) setDropDownItemTextAlignment:(NSTextAlignment)alignment{
    _dropDownItemTextAlignment = alignment;
}

-(void) setDropDownItemBackgroundColor:(UIColor *)color{
    _itemBackgroundColor = color;
}

-(void) setDropDownItemTextColor:(UIColor *)color{
    _itemTextColor = color;
}

-(void) setDropDownSelectionTextColor:(UIColor *)color{
    _itemSelectionTextColor = color;
}

-(void) setDropDownSelectionColor:(UIColor *)color{
    _itemSelectionColor = color;
}

-(void) setDropDownSeparatorColor:(UIColor *)color{
    _tableSeparatorColor = color;
    if(_tableSeparatorColor != nil){
        table.separatorColor = _tableSeparatorColor;
    } else{
        table.separatorColor = [UIColor grayColor];
    }
    [table reloadData];
}

-(void) setDropDownTableBgColor:(UIColor *)color{
    _tableBackgroundColor = color;
    if(_tableBackgroundColor != nil){
        table.backgroundColor = _tableBackgroundColor;
    } else{
        table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
    }
    [table reloadData];
}

-(void)setDimViewColor:(UIColor *)color withAlpha:(CGFloat)alpha{
    _backgroundDimViewColor = color;
    _backgroundDimViewAlpha = alpha;
    CGFloat newAlpha = _backgroundDimViewAlpha?_backgroundDimViewAlpha:0.5;
    CGColorRef bgColor = CGColorCreateCopyWithAlpha([_backgroundDimViewColor CGColor], newAlpha);
    [_backgroundButton setBackgroundColor:[UIColor colorWithCGColor:bgColor]];
    [_backgroundButton setNeedsLayout];
    [_backgroundButton layoutIfNeeded];
}


-(void)dealloc {
//    [super dealloc];
//    [table release];
//    [self release];
}

@end
