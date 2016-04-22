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
WKExpressionViewDelegate,
WKExpressionTextViewDelegate
>
@property (weak, nonatomic) IBOutlet UIView *expressionBG;
@property (weak, nonatomic) IBOutlet WKExpressionTextView *textView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *expressionBGBottomConstraint;
@property (strong, nonatomic) WKExpressionView *expView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view layoutIfNeeded];
    
    _expView = [WKExpressionView expressionView];
    _expView.delegate = self;
    _textView.expressionDelegate = self;
    
    [_expressionBG addSubview:_expView];
    
    
    [self observeKeyboard];
}


- (void)observeKeyboard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)showKeyBoard:(NSNotification *)noti
{
    NSDictionary *userInfo = noti.userInfo;
    
    CGRect keyBoardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat boardHeight = CGRectGetHeight(keyBoardFrame);
    self.expressionBGBottomConstraint.constant = boardHeight;
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.view layoutIfNeeded];
    }];
}



- (void)viewDidLayoutSubviews
{
    _expView.frame = _expressionBG.bounds;
    
    CGRect bounds = _expView.bounds;
    
    _expView.bounds = bounds;
    
    
    [_expView layoutIfNeeded];
    
    [_expView.collectionView reloadData];
}

- (void)expressionView:(WKExpressionView *)expressionView didSelectImageName:(NSString *)imageName
{
    [_textView setExpressionWithImageName:imageName fontSize:_textView.defaultFontSize];
}

- (void)expressionViewDidSelectDeleteButton:(WKExpressionView *)expressionView
{
    if (_textView.text.length == 0) {
        return;
    }
    NSMutableAttributedString *originalString = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    [originalString deleteCharactersInRange:NSMakeRange(originalString.length - 1, 1)];
    _textView.attributedText = originalString;
    
    [_textView textChanged];
    
}

- (void)expressionViewDidSelectSendButton:(WKExpressionView *)expressionView
{
    NSLog(@"发送");
}

- (void)expressionTextDidChange:(WKExpressionTextView *)textView textLength:(NSInteger)length
{
    [self.expView setSendButtonState:length == 0 ? NO : YES];
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
