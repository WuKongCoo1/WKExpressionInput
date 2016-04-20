//
//  WKExpressionView.m
//  WKExpressionInput
//
//  Created by 吴珂 on 16/4/5.
//  Copyright © 2016年 MyCompany. All rights reserved.
//

#import "WKExpressionView.h"
#import "WKExpressionViewConfiguration.h"
#import "WKExpressionCell.h"

@interface WKExpressionView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, assign) NSInteger numberOfExpressionInPage;
@property (nonatomic, assign) NSInteger numberOfPage;

@end

@implementation WKExpressionView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"WKExpressionView" owner:nil options:nil] firstObject];
        
    }
    return self;
}

+ (instancetype)expressionView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WKExpressionView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    UINib *cellNIb = [UINib nibWithNibName:@"WKExpressionCell" bundle:nil];
    
    [self.collectionView registerNib:cellNIb forCellWithReuseIdentifier:cellIdentifier];
    
    [self.sendButton setBackgroundImage:[self createColorImageWithColor:[UIColor colorWithRed:250 / 255.f green:250 / 255.f blue:250 / 255.f alpha:1.f]] forState:UIControlStateNormal];
    
    [self.sendButton setBackgroundImage:[self createColorImageWithColor:[UIColor blueColor]] forState:UIControlStateSelected];
    
    [self.sendButton setBackgroundImage:[self createColorImageWithColor:[UIColor blueColor]] forState:UIControlStateHighlighted];
    
//    [self.sendButton setImage:[self createColorImageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    
}

- (NSInteger)numberOfExpressionInPage
{
    _numberOfExpressionInPage = ExpressionLineLineOfPage * ExpressionNumberOfLine;
    return _numberOfExpressionInPage;
}

- (NSInteger)numberOfPage
{
    _numberOfPage = ceil((ExpressionCount / ((CGFloat)self.numberOfExpressionInPage - 1)));
    self.pageControl.numberOfPages = _numberOfPage;
    return _numberOfPage;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberOfPage;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WKExpressionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.expressionNumber = self.numberOfExpressionInPage;
    cell.maxLineNumber = ExpressionNumberOfLine;
    cell.page = indexPath.row;
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds);
    self.pageControl.currentPage = page;
}

- (void)selectDeleteButton
{
    if ([self.delegate respondsToSelector:@selector(expressionViewDidSelectDeleteButton:)]) {
        [self.delegate expressionViewDidSelectDeleteButton:self];
    }
}

- (void)selectExpression:(UIButton *)sender
{
    NSString *imageName = [NSString stringWithFormat:@"Expression_%ld", sender.tag];
    
    
    
    if ([self.delegate respondsToSelector:@selector(expressionView:didSelectImageName:)]) {
        [self.delegate expressionView:self didSelectImageName:imageName];
    }
}

- (UIImage *)createColorImageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContext(CGSizeMake(40, 40));
    [color setFill];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextFillRect(context, CGRectMake(0, 0, 40, 40));
    
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}

@end
