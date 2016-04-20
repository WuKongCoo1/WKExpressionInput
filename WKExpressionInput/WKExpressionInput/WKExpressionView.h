//
//  WKExpressionView.h
//  WKExpressionInput
//
//  Created by 吴珂 on 16/4/5.
//  Copyright © 2016年 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKExpressionView;
@protocol WKExpressionViewDelegate <NSObject>

- (void)expressionView:(WKExpressionView *)expressionView didSelectImageName:(NSString *)imageName;
- (void)expressionViewDidSelectDeleteButton:(WKExpressionView *)expressionView;

@end

@interface WKExpressionView : UIView

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (weak, nonatomic) id<WKExpressionViewDelegate> delegate;

+ (instancetype)expressionView;

- (void)selectDeleteButton;
- (void)selectExpression:(UIButton *)sender;
@end
