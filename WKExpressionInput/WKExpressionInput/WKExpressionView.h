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
- (void)expressionViewDidSelectSendButton:(WKExpressionView *)expressionView;
@end

@interface WKExpressionView : UIView

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (weak, nonatomic) id<WKExpressionViewDelegate> delegate;


+ (instancetype)expressionView;
/**
 *  点击发送按button
 *
 *  @param sender 发送button
 */
- (IBAction)didSelectSendButton:(id)sender;

/**
 *  设置发送按钮状态
 *
 *  @param enable 是否可选
 */
- (void)setSendButtonState:(BOOL)enabled;

@end
