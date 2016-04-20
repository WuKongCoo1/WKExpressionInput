//
//  ViewController.m
//  WKExpressionInput
//
//  Created by 吴珂 on 16/4/5.
//  Copyright © 2016年 MyCompany. All rights reserved.
//

#import "ViewController.h"
#import "WKExpressionViewConfiguration.h"

@interface ViewController ()
<
WKExpressionViewDelegate
>
@property (weak, nonatomic) IBOutlet UIView *expressionBG;
@property (weak, nonatomic) IBOutlet WKExpressionTextView *textView;

@property (strong, nonatomic) WKExpressionView *expView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view layoutIfNeeded];
    
    _expView = [WKExpressionView expressionView];
    _expView.delegate = self;
    
    [_expressionBG addSubview:_expView];
}

- (void)viewDidLayoutSubviews
{
    _expView.frame = _expressionBG.bounds;
    
    CGRect bounds = _expView.bounds;
//    bounds.size.width = floor(bounds.size.width / 50) * 50;
    
    _expView.bounds = bounds;
    
    
    [_expView layoutIfNeeded];
    
    [_expView.collectionView reloadData];
}

- (void)expressionView:(WKExpressionView *)expressionView didSelectImageName:(NSString *)imageName
{
    [_textView setExpressionWithImageName:imageName fontSize:15];
}

- (void)expressionViewDidSelectDeleteButton:(WKExpressionView *)expressionView
{
    if (_textView.text.length == 0) {
        return;
    }
    NSMutableAttributedString *originalString = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    [originalString deleteCharactersInRange:NSMakeRange(originalString.length - 1, 1)];
    _textView.attributedText = originalString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
