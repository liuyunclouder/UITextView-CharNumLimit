//
//  UITextView+CharNumLimit.h
//  BBP
//
//  Created by TangYunfei on 15/9/30.
//  Copyright © 2015年 TangYunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  注意不要在调用initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer maxCharNum:(NSNumber *)maxCharNum delegate:(id<UITextViewDelegate>)delegate之后再设置textView.delegate了
 */

@interface UITextView (CharNumLimit)

@property (nonatomic, readonly, retain) NSNumber *availableCharNum;

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer maxCharNum:(NSNumber *)maxCharNum delegate:(id<UITextViewDelegate>)delegate;

@end
