//
//  WKExpressionCell.h
//  WKExpressionInput
//
//  Created by 吴珂 on 16/4/5.
//  Copyright © 2016年 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKExpressionView.h"

@interface WKExpressionCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger expressionNumber;
@property (nonatomic, assign) NSInteger maxLineNumber;

@property (nonatomic, weak) WKExpressionView *expressionView;

@end
