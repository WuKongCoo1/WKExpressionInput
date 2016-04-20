//
//  WKExpressionTextView.m
//  WKExpressionInput
//
//  Created by 吴珂 on 16/4/6.
//  Copyright © 2016年 MyCompany. All rights reserved.
//

#import "WKExpressionTextView.h"
#import "WKExpressionViewConfiguration.h"

@implementation WKExpressionTextView

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:self];
}



- (void)setExpressionWithImageName:(NSString *)imageName fontSize:(CGFloat)fontSize
{
    //属性字符串
    WKExpressionTextAttachment *attachment = [[WKExpressionTextAttachment alloc] initWithData:nil ofType:nil];
    UIImage *image = [UIImage imageNamed:imageName];
    attachment.image = image;
    attachment.text = [WKExpressionTool getExpressionStringWithImageName:imageName];
    attachment.bounds = CGRectMake(0, 0, 14, 14);
    NSAttributedString *insertAttributeStr = [NSAttributedString attributedStringWithAttachment:attachment];
    NSMutableAttributedString *resultAttrString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
//    [resultAttrString appendAttributedString: appendAttributeStr];
    //在当前编辑位置插入字符串
    [resultAttrString insertAttributedString:insertAttributeStr atIndex:self.selectedRange.location];
    
    NSRange tempRange = self.selectedRange;
    
    self.attributedText = resultAttrString;
    
    self.selectedRange = NSMakeRange(tempRange.location + 1, 0);
    
}



- (void)textChange:(NSNotification *)noti
{
    NSLog(@"%@", self.attributedText);
    

    self.attributedText = [WKExpressionTool generateAttributeStringWithOriginalString:[self  parseAttributeTextToNormalString:self.attributedText]];
}

- (NSString *)parseAttributeTextToNormalString:(NSAttributedString *)attributedString
{
    NSMutableString *normalString = [NSMutableString string];
    [attributedString enumerateAttributesInRange:NSMakeRange(0, attributedString.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        WKExpressionTextAttachment *attachment = attrs[@"NSAttachment"];
        
        if (attachment) {//图片
            NSLog(@"图片");
            [normalString appendString:attachment.text];
        }else{//文字
            NSLog(@"文字");
            NSAttributedString *attrStr = [attributedString attributedSubstringFromRange:range];
            
            [normalString appendString:attrStr.string];
        }
    }];
    
    return normalString;
}

#pragma mark - Actions
- (void)copy:(id)sender
{
    NSAttributedString *selectedString = [self.attributedText attributedSubstringFromRange:self.selectedRange];
    NSString *copyString = [self parseAttributeTextToNormalString:selectedString];
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    if (copyString.length != 0) {
        pboard.string = copyString;
    }
}

- (void)cut:(id)sender
{
    [self copy:sender];
    
    NSMutableAttributedString *originalString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [originalString deleteCharactersInRange:self.selectedRange];
    self.attributedText = originalString;
    
    
}

@end
