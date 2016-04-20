//
//  WKExpressionCell.m
//  WKExpressionInput
//
//  Created by 吴珂 on 16/4/5.
//  Copyright © 2016年 MyCompany. All rights reserved.
//

#import "WKExpressionCell.h"
#import "WKExpressionViewConfiguration.h"

@implementation WKExpressionCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}

- (void)setPage:(NSInteger)page
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    ExpressionLineLineOfPage * ExpressionNumberOfLine
    _page = page;
    CGFloat expressionWH = self.bounds.size.width / ExpressionNumberOfLine;
//    expressionWH = 30.f;
    for (int i = 0 ; i < _expressionNumber; i++) {
        
        UIButton *expressionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView *img = [[UIImageView alloc] init];
        
        if (i == _expressionNumber - 1) {
            [expressionButton setImage:[UIImage imageNamed:@"DeleteEmoticonBtn"] forState:UIControlStateNormal];
            img.image = [UIImage imageNamed:@"DeleteEmoticonBtn"];
            
            [expressionButton addTarget:_expressionView action:@selector(selectDeleteButton) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            
            NSString *imageName = [NSString stringWithFormat:@"Expression_%ld", _page * (_expressionNumber - 1) + i + 1];
            [expressionButton setImage:[self scaleImage:[UIImage imageNamed:imageName] toSize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
            img.image = [UIImage imageNamed:imageName];
//            NSLog(@"%@", imageName);
            
            expressionButton.tag = _page * (_expressionNumber - 1) + i + 1;
            [expressionButton addTarget:_expressionView action:@selector(selectExpression:) forControlEvents:UIControlEventTouchUpInside];

        }
        CGRect bounds = expressionButton.imageView.bounds;
        bounds.size.height += 10;
        bounds.size.width += 10;
        
        expressionButton.imageView.bounds = bounds;
        
        //计算行列
        NSInteger row = i % _maxLineNumber;
        NSInteger col = i / _maxLineNumber;
        
        CGFloat x = row * expressionWH;
        CGFloat y = col * expressionWH;
        
        expressionButton.frame = CGRectMake(x, y, expressionWH, expressionWH);
        img.frame = expressionButton.frame;
//        [self.contentView addSubview:img];
        [self.contentView addSubview:expressionButton];
    }
}

- (UIImage *)scaleImage:(UIImage *)originalImage scale:(CGFloat)scale
{
    CGSize size = CGSizeMake(originalImage.size.width * scale, originalImage.size.height * scale);
    UIGraphicsBeginImageContext(size);
    
    [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return  scaleImage;
}

- (UIImage *)scaleImage:(UIImage *)originalImage toSize:(CGSize)size
{
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return  scaleImage;
}

@end
