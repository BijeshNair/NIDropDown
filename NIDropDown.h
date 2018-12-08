//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIDropDown;
@protocol NIDropDownDelegate
- (void) niDropDownDelegateMethod: (NIDropDown *) sender;
- (void) niDropDownDelegateMethod: (UIView *) sender withTitle:(NSString *)title;
- (void) niDropDownHidden: (NIDropDown *)sender;
@end

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSString *animationDirection;
    UIImageView *imgView;
}
@property (nonatomic, weak) id <NIDropDownDelegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;
-(void)hideDropDown:(UIView *)b;
- (id)showDropDown:(UIView *)b theHeight:(CGFloat *)height theArr:(NSArray *)arr theImgArr:(NSArray *)imgArr theDirection:(NSString *)direction withViewController:(UIViewController *)viewController;
-(void) setDropDownItemTextAlignment:(NSTextAlignment)alignment;
-(void) setDropDownItemBackgroundColor:(UIColor *)color;
-(void) setDropDownItemTextColor:(UIColor *)color;
-(void) setDropDownSelectionTextColor:(UIColor *)color;
-(void) setDropDownSelectionColor:(UIColor *)color;
-(void) setDropDownSeparatorColor:(UIColor *)color;
-(void) setDropDownTableBgColor:(UIColor *)color;
-(void) setDimViewColor:(UIColor *)color withAlpha:(CGFloat)alpha;
@end
