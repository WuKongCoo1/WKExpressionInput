//
//  WKExpressionCell.h
//  WKExpressionInput
//
//  Created by 吴珂 on 16/4/5.
//  Copyright © 2016年 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKExpressionView.h"

@class WKExpressionCell;
@protocol WKExpressionCellDelegate <NSObject>

- (void)expressionCellDidSelectDeleteButton:(WKExpressionCell *)cell;
- (void)expressionCell:(WKExpressionCell *)cell didSelectImageName:(NSString *)imageName;

@end

@interface WKExpressionCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger expressionNumber;
@property (nonatomic, assign) NSInteger maxLineNumber;

@property (nonatomic, weak) id<WKExpressionCellDelegate> delegate;

@end
