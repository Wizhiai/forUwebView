//
//  ViewController.h
//  forUwebView
//
//  Created by 胡礼节 on 15/9/25.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate,UIWebViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIWebView *webview1;
@property(nonatomic,strong)UIWebView *webview2;
@property(nonatomic,strong)UIWebView *webview20;
@property(nonatomic,strong)UIWebView *webview0;
@property(nonatomic,strong)UIWebView *footerView;
@property(nonatomic,strong)UIView *theScrollerView;
@property (retain, nonatomic)UIPanGestureRecognizer *panGesture;
@property (retain, nonatomic)UIView *overLay;
@property (assign, nonatomic)BOOL isHidden;
@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIView *introView;
@property(nonatomic,strong)UILabel *titleLabelup;

@property(nonatomic,strong)UIImageView *imageViewup;
@property(nonatomic,strong)UIView *introViewup;
@end

