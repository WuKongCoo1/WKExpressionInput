//
//  WKExpressionTextView.h
//  WKExpressionInput
//
//  Created by 吴珂 on 16/4/6.
//  Copyright © 2016年 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKExpressionTextView;
@protocol WKExpressionTextViewDelegate <UITextViewDelegate>

- (void)expressionTextDidChange:(WKExpressionTextView *)textView textLength:(NSInteger)length;

@end


@interface WKExpressionTextView : UITextView 

@property (nonatomic, strong) NSString *originalString;//用于粘贴复制的字符串
@property (nonatomic, assign) CGFloat defaultFontSize;
@property (nonatomic, weak) id<WKExpressionTextViewDelegate> expressionDelegate;


- (void)setExpressionWithImageName:(NSString *)imageName fontSize:(CGFloat)fontSize;

- (void)textChanged;

@end
