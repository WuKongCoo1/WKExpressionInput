//
//  WKExpressionTextView.h
//  WKExpressionInput
//
//  Created by 吴珂 on 16/4/6.
//  Copyright © 2016年 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKExpressionTextView : UITextView

@property (nonatomic, strong) NSString *originalString;//用于粘贴复制的字符串

- (void)setExpressionWithImageName:(NSString *)imageName fontSize:(CGFloat)fontSize;

@end
