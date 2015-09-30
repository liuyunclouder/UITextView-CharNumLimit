//
//  UITextView+CharNumLimit.m
//  BBP
//
//  Created by TangYunfei on 15/9/30.
//  Copyright © 2015年 TangYunfei. All rights reserved.
//

#import "UITextView+CharNumLimit.h"
#import <objc/runtime.h>

@interface UITextView()<UITextViewDelegate>

@property (nonatomic, retain) NSNumber *maxCharNum;

@property (nonatomic, weak) id<UITextViewDelegate> customDelegate;

@end


@implementation UITextView (CharNumLimit)

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer maxCharNum:(NSNumber *)maxCharNum delegate:(id<UITextViewDelegate>)delegate
{
    self = [self initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self setMaxCharNum:maxCharNum];
        [self setCustomDelegate:delegate];
        self.delegate = self;
    }
    
    return self;
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.customDelegate textViewShouldBeginEditing:textView];
    } else {
        return YES;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.customDelegate textViewDidBeginEditing:textView];
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.customDelegate textViewShouldEndEditing:textView];
    } else {
        return YES;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.customDelegate textViewDidEndEditing:textView];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([[self availableCharNum] integerValue] <= 0) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, [[self maxCharNum] unsignedIntegerValue])];
    }
    
    
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.customDelegate textViewDidChange:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [self.customDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    } else {
        return YES;
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [self.customDelegate textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)]) {
        return [self.customDelegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    } else {
        return YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        return [self.customDelegate textView:textView shouldInteractWithURL:URL inRange:characterRange];
    } else {
        return YES;
    }
}

#pragma mark - property simulation

- (id<UITextViewDelegate>)customDelegate {
    return objc_getAssociatedObject(self, @selector(customDelegate));
}

- (void)setCustomDelegate:(id<UITextViewDelegate>)customDelegate {
    objc_setAssociatedObject(self, @selector(customDelegate), customDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)maxCharNum {
    return objc_getAssociatedObject(self, @selector(maxCharNum));
}

- (void)setMaxCharNum:(NSNumber *)maxCharNum {
    objc_setAssociatedObject(self, @selector(maxCharNum), maxCharNum, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)availableCharNum {
    NSInteger availableCharNum = [self.maxCharNum unsignedIntegerValue] - [self.text length];
    
    return @(availableCharNum);
}



@end
