//
//  WKExpressionTool.h
//  WKExpressionInput
//
//  Created by 吴珂 on 16/4/6.
//  Copyright © 2016年 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WKExpressionTool : NSObject

+ (NSAttributedString *)generateAttributeStringWithOriginalString:(NSString *)originalString;

+ (NSString *)getExpressionStringWithImageName:(NSString *)imageName;
@end
