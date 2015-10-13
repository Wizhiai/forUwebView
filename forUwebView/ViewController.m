//
//  ViewController.m
//  forUwebView
//
//  Created by 胡礼节 on 15/9/25.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "ViewController.h"
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
#import "SVProgressHUD.h"



@interface ViewController (){
    UIButton *share;
    UIScrollView *scrollView;
    UIView *view1 ;
     UIView *view2 ;
    UIView *Tip1 ;
     UIView *Tip2;
    UILabel *tlabel1;
    UILabel *tlabel2;
  UIView *view0 ;
    int newscId;
    int view1Id;
   
    BOOL flag;

    UIButton *line;
        UIButton *line2;
    float yt;
    UIView *tabView;
    NSString *imgNext;
    
}

@end

@implementation ViewController{
    NSString *html;
      NSString *title;
      NSString *time;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = true;
      newscId = 1;
    
  
    self.webview0 = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, HEIGHT -20)];
    self.webview0.delegate = self;
    self.webview0.scrollView.showsHorizontalScrollIndicator = NO;
    self.webview0.scrollView.bounces = NO;

    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, WIDTH,  HEIGHT-20)];
    scrollView.backgroundColor = [UIColor whiteColor];
    view0 = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, HEIGHT -20)];

    view0.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:view0];

    
    
    //放上去的内容限制的移动范围 [UIScreen mainScreen].bounds.size.height/5
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(WIDTH,HEIGHT);
//scrollView.C
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentOffset = CGPointMake(0,10);
 scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
//    scrollView.bounces = NO;
//    self.mys.bounces = NO;//设置scroll遇到边框不滑动
    
    
    scrollView.alpha = 0;
    
    
    [self.view addSubview:scrollView];
    
    
    
    //上面的加载界面
    view1 = [[UIView alloc]initWithFrame:CGRectMake(0, -160, WIDTH, 60)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    
    
//    line = [[UIButton alloc]initWithFrame:CGRectMake(0, -view1.frame.size.height-60, WIDTH, 1)];
//    line.backgroundColor = [UIColor blackColor];
//    
//    [view1 addSubview:line];
  
    //下面的加载界面
    
    view2 = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 60)];
    view2.backgroundColor = [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1.0];
    
    line2 = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT + 60, WIDTH, 1)];
    line2.backgroundColor = [UIColor blackColor];
    [view2 addSubview:line2];
    [self.view addSubview:view2];
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestPost:newscId andTagView:0];//初次加载数据

    
   
    //提示界面
    tlabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, WIDTH, 60)];
    tlabel1.alpha = 0;
//    line.alpha = 0;
    view1.alpha = 0;
     [view1 addSubview:tlabel1];
    tlabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, WIDTH, 60)];

    tlabel2.font=[UIFont fontWithName:@"Arial" size:15];


    tabView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-HEIGHT*0.06, WIDTH, HEIGHT*0.06)];
    tabView.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    
    
    
    
    [self.view addSubview:tabView];
    //tabar按钮
    UIButton *leftBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,WIDTH*1/5,  HEIGHT*0.06)];

    [leftBack setImage:[UIImage imageNamed:@"News_Navigation_Arrow_Highlight@3x.png"] forState:UIControlStateNormal];

     leftBack.contentMode = UIViewContentModeScaleAspectFill;
    [tabView addSubview:leftBack];
    
   
    
    UIButton *downBack = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH*1/5,0,  WIDTH*1/5,HEIGHT*0.06)];

    [downBack setImage:[UIImage imageNamed:@"News_Navigation_Next_Highlight@3x.png"] forState:UIControlStateNormal];

    downBack.contentMode = UIViewContentModeScaleAspectFill;
    [tabView addSubview:downBack];
    
    
    UIButton *fav =[ [UIButton alloc]initWithFrame:CGRectMake(WIDTH*2/5,0,  WIDTH*1/5,HEIGHT*0.06)];
    [fav setImage:[UIImage imageNamed:@"News_Fav_Highlight@2x.png"] forState:UIControlStateNormal];
      fav.contentMode = UIViewContentModeScaleAspectFill;
    [tabView addSubview:fav];
    
    
    UIButton *comment =[ [UIButton alloc]initWithFrame:CGRectMake(WIDTH*3/5,0,  WIDTH*1/5,HEIGHT*0.06)];
    [comment setImage:[UIImage imageNamed:@"News_Navigation_Comment_Highlight@3x.png"] forState:UIControlStateNormal];
    comment.contentMode = UIViewContentModeScaleAspectFill;
    [tabView addSubview:comment];
    
 share =[ [UIButton alloc]initWithFrame:CGRectMake(WIDTH*4/5,0,  WIDTH*1/5,HEIGHT*0.06)];
    [share setImage:[UIImage imageNamed:@"News_Navigation_Share_Highlight@3x"] forState:UIControlStateNormal];
    share.contentMode = UIViewContentModeScaleAspectFill;
    [tabView addSubview:share];
    [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self followRollingScrollView:self.webview0];
    

    
    
   
    self.titleLabel=[[UILabel alloc]initWithFrame: CGRectMake(5,0,WIDTH*0.7,60 )];
    self.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
    self.titleLabel.numberOfLines=0;
    
    
    self.imageView=[[UIImageView alloc]initWithFrame: CGRectMake(WIDTH*0.7,0, WIDTH*0.3,60)];

    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.introView = [[UIView alloc]initWithFrame:CGRectMake(0,  0, WIDTH, 60)];
    self.introView.backgroundColor = [UIColor whiteColor];
    [self.introView addSubview:self.titleLabel];
    [self.introView addSubview:self.imageView];
     self.introView.backgroundColor =  [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1.0];
    [view2 addSubview:self.introView];
    
    
    self.titleLabelup=[[UILabel alloc]initWithFrame: CGRectMake(5,0,WIDTH*0.7,45 )];
    self.titleLabelup.font=[UIFont fontWithName:@"Arial" size:15];
    self.titleLabelup.numberOfLines=0;
    
    
    self.imageViewup=[[UIImageView alloc]initWithFrame: CGRectMake(WIDTH*0.7,0, WIDTH*0.3,45)];
   
    self.imageViewup.contentMode = UIViewContentModeScaleAspectFit;
    self.introViewup = [[UIView alloc]initWithFrame:CGRectMake(0,  0, WIDTH, 45 )];
    self.introViewup.backgroundColor = [UIColor whiteColor];
    [self.introViewup addSubview:self.titleLabelup];
    [self.introViewup addSubview:self.imageViewup];
    self.introViewup.backgroundColor =  [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1.0];
    [view1 addSubview:self.introViewup];
    view1.backgroundColor = [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1.0];
}
- (void)initweb:(int)TagView{
    
  

    


    NSString *headHtml = [NSString stringWithFormat:@"%@%@%d%@%d%@%f%s%d%@%f%@%f%@", @"<html><meta name='viewport' content='width=device-width; initial-scale=1.0; maximum-scale=1.0;'><head><style type=\"text/css\">div#nextIntro {background-color:#99bbbb;};body{text-align:justify ;text-justify:inter-word;background-color: whitecolor" , @";font-family:'LTHYSZK';margin-top: 0px;margin-left: 0px;margin-right: 0px;line-height:",28,@"px;font-color:#ff0000;font-size:", 16,
                          
                          @"px;word-wrap:break-word;overflow:hidden;}img {border:1px solid #eee;max-width:" ,WIDTH- 25,"px;width:expression(this.width > 270 ? '270px' : this.widt+'px');overflow:hidden;}a{color:#0E89E1;text-decoration: none;font-size:",
                          
                          
                          
                          
                          16,@";}table{table-layout: fixed;}td{word-break: break-all; word-wrap:break-word;}video{border:1px solid #eee;max-width:",WIDTH - 30,@"px;max-height:",(WIDTH-30)*0.562,@"px;width:expression(this.width > 270 ? '270px' : this.widt+'px');overflow:hidden;}</style></head><body>"];
    

    
    NSString *topHtml = @"";
    //标题
   NSString * strTitle = title;
    NSString *titleHtml = @"";
   NSString * strSource = @"ForU采集";;
  NSString  * strTime = time;


    titleHtml = [NSString stringWithFormat:@"%@%d%@%@%@",@"<br><table width=\"100%\"border=\"0\"cellpadding=\"0\"cellspacing=\"0\"><tr><td width=\"4\"valign=\"middle\" ></td><td valign=\"middle\"><div style=\"padding-left:10px;padding-right:10px;\"><span style='font-size:", 21+3 ,@"px;'>",strTitle,@"</span>"@"</div></td></tr>"];
    NSString *timeSourceHtml = [NSString stringWithFormat:@"%@%d%@%@%@%d%@%@%@",@"<tr><td width=\"4\"></td><td valign=\"right\"><div style=\"padding:10px;\"><span style='font-size:", 10 ,@"px;color:gray;'>",strSource,@"</span><span>&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='font-size:", 10+2 ,@"px;color:gray;'>",strTime,@"</span></div></td></tr></table>"];
    titleHtml = [NSString stringWithFormat:@"%@%@",titleHtml,timeSourceHtml];
    
    
    
    
    
    
    
    
    
    //html 结束
    NSString *bottomHtml = @"</body></html>";

    NSString *content = [NSString stringWithFormat:@"%@%@%@",@"<div style='padding-left:5px;padding-right:5px;'><font style='color:#555555;'>",html,@"</font></div>"];
    NSString *allHtml = [NSString stringWithFormat:@"%@%@%@%@%@",headHtml,topHtml,titleHtml,content,bottomHtml];
//    NSString *allHtml = [NSString stringWithFormat:@"%@%@%@",temH,html,bottomHtml];

  
    NSString *lineHtml =[NSString stringWithFormat: @" <br><br><hr noshade color=%@>",@"#EEA9B8"];
    NSString *tableHtml =[NSString stringWithFormat: @"<table><tr><th style=%@>下拉加载下一条新闻:</th></tr></table>",@"text-align:left"];
    allHtml = [NSString stringWithFormat:@"%@%@%@",allHtml,lineHtml,tableHtml];
    
    
    if (TagView == 0) {
        
        [self.webview0 loadHTMLString:allHtml baseURL:nil];
        self.webview0.backgroundColor = [UIColor whiteColor];

        
        [self.webview0 loadHTMLString:allHtml baseURL:nil];
        


        
        
        [view0 addSubview:self.webview0 ];
    }
    
    

}

- (void)requestPost:(int)newsId andTagView:(int)tagView{
    
    
    
    NSString *urlPath = @"http://115.29.176.50/interface/index.php/Home/GetNews/search";

    NSString *key = @"hulijieluolianglvkang015";
    NSString *table = @"worldnews";
    NSString *str = [NSString stringWithFormat:@"newsId=%d&key=%@&table=%@",newsId,key,table];
    
    NSData *bodyData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlPath];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:bodyData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

  

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

        NSDictionary *result = [dic valueForKey:@"result"];
        html = [[result valueForKey:@"newscontent"] objectAtIndex:0];
        title = [[result valueForKey:@"newstitle"] objectAtIndex:0];
        time = [[result valueForKey: @"newstime"] objectAtIndex:0];
        imgNext =[[result valueForKey: @"newsfirstimg"] objectAtIndex:0];
        if (tagView!=100) {
             [self initweb:tagView];
        }
        if (newsId == (newscId+1)) {
             [self setViewContent];
        }else if(newsId == (newscId-1))
        {
        [self setViewContentup];
        }
        NSLog(@"%@",html);
        
        
    }];
    
    
    
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView1{

}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    


       flag = false;
    tabView.alpha = 1;

   
  
    
//    [UIView animateWithDuration:0.2 animations:^{
//        tabView.alpha = 0;
//        
//    }];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView1
{
    [ UIView animateWithDuration:1 animations:^{

        
         scrollView.alpha = 1;
    }];
scrollView.alpha = 1;
    
    flag = true;
    [SVProgressHUD dismiss];
   
    
     [self setViews:2];
    [self setViews:1];
    NSLog(@"UU");
    }

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView1 willDecelerate:(BOOL)decelerate{
    NSLog(@"+++%f",scrollView1.contentOffset.y);
    
    //    view2.frame = CGRectMake(0, HEIGHT *2, WIDTH, 100);
    
    float y = scrollView1.contentOffset.y;
    
    if (y<-80&&newscId>1) {
        newscId--;
        view1.alpha = 1;
        [self requestPost:newscId andTagView:0];
    }else if(y>100){
        newscId++;
        [ UIView animateWithDuration:0.5 animations:^{
            scrollView.alpha = 0;
            
            
        }];
                  [SVProgressHUD showWithStatus:@"正在解析数据" maskType:SVProgressHUDMaskTypeGradient];
        [self requestPost:newscId andTagView:0];
    }


}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView1{

    if (flag&&scrollView1==scrollView) {
        
   
//    NSLog(@"%f",self.webview0.scrollView.contentOffset.y);
    float y = scrollView1.contentOffset.y;
    
    if(y<0)
    {
        tlabel1.alpha = 1;
//        line.alpha = 1;
        view1.alpha = 1;
        
        if ((y-yt)<0) {
    
                   view1.frame = CGRectMake(0, 0, WIDTH, -1*y);
                    view1.alpha = 1;
//        line.frame = CGRectMake(0, view1.frame.size.height - 80, WIDTH, 1);
        tlabel1.frame = CGRectMake(13, view1.frame.size.height - 100, WIDTH, 30) ;
            self.introViewup.frame = CGRectMake(5, view1.frame.size.height - 70, WIDTH, 30) ;
        tlabel1.text = @"松开加载上一条新闻:";
//        [view1 addSubview:tlabel1];
        }else if(y>-50&&y<0){
            [ UIView animateWithDuration:0.3 animations:^{
                view1.frame = CGRectMake(0, -100, WIDTH, 0);

            }];
            
        
        
        }else{
            view1.frame = CGRectMake(0, 0, WIDTH, -1*y);
            line.frame = CGRectMake(0, view1.frame.size.height - 80, WIDTH, 1);
            tlabel1.frame = CGRectMake(13, view1.frame.size.height - 100, WIDTH, 30) ;
            self.introViewup.frame = CGRectMake(5, view1.frame.size.height - 70, WIDTH, 30) ;
            tlabel1.text = @"松开加载上一条新闻:";
          
//            [view1 addSubview:tlabel1];
        }
        
        
    }else  if(y>0){
        
        if ((y-yt)>0) {

            
            view2.frame = CGRectMake(0, HEIGHT-y, WIDTH, y);
//            line2.frame = CGRectMake(0, 80 , WIDTH, 1);
            tlabel2.frame = CGRectMake(0, 0, WIDTH, 30) ;
            tlabel2.text = @"松开加载下一条新闻:";
           tlabel2.font=[UIFont fontWithName:@"Arial" size:15];
//            [view2 addSubview:tlabel2];

           
        }else if(y<50){
            


           [ UIView animateWithDuration:0.1 animations:^{
               view2.frame = CGRectMake(0, HEIGHT, WIDTH, 10);
               

           }];
           
        }else{
            view2.frame = CGRectMake(0, HEIGHT-y, WIDTH, y);
//            line2.frame = CGRectMake(0, 80 , WIDTH, 1);
            tlabel2.frame = CGRectMake(0, 0, WIDTH, 30) ;
            tlabel2.text = @"松开加载下一条新闻:";
            tlabel2.font=[UIFont fontWithName:@"Arial" size:15];
//            [view2 addSubview:tlabel2];
            
        }
        
        NSLog(@"---%f",y-yt);

        

    }
    yt = y;
        
         }
}


//设置跟随滚动的滑动试图
-(void)followRollingScrollView:(UIView *)scrollView1
{
    self.theScrollerView = scrollView1;
    
    self.panGesture = [[UIPanGestureRecognizer alloc] init];
    self.panGesture.delegate=self;
    self.panGesture.minimumNumberOfTouches = 1;
    [self.panGesture addTarget:self action:@selector(handlePanGesture:)];
    [self.theScrollerView addGestureRecognizer:self.panGesture];
    
    self.overLay = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    self.overLay.alpha=0;
    self.overLay.backgroundColor=self.navigationController.navigationBar.barTintColor;
    [self.navigationController.navigationBar addSubview:self.overLay];
    [self.navigationController.navigationBar bringSubviewToFront:self.overLay];
}

#pragma mark - 兼容其他手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - 手势调用函数
-(void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    CGPoint translation = [panGesture translationInView:[self.theScrollerView superview]];
    
    //    NSLog(@"%f",translation.y);
    //    CGFloat detai = self.lastContentset - translation.y;
    //显示
    if (translation.y >= 5) {
        if (self.isHidden) {
            [UIView animateWithDuration:0.2 animations:^{
                tabView.alpha = 1;
                
            }];

                //                if ([self.scrollView isKindOfClass:[UIScrollView class]]) {
                //                    UIScrollView *scrollView=(UIScrollView *)self.scrollView;
                //                    scrollView.contentOffset=CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y+44);
                //                }else if ([self.scrollView isKindOfClass:[UIWebView class]]){
                //                    UIWebView *webView=(UIWebView *)self.scrollView;
                //                    webView.scrollView.contentOffset=CGPointMake(webView.scrollView.contentOffset.x, webView.scrollView.contentOffset.y+44);
                //                }
            }
            self.isHidden= NO;
        
    }
    
    //隐藏
    if (translation.y <= -20) {
        if (!self.isHidden) {

                //                if ([self.scrollView isKindOfClass:[UIScrollView class]]) {
                //                    UIScrollView *scrollView=(UIScrollView *)self.scrollView;
                //                    scrollView.contentOffset=CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y-44);
                //                }else if ([self.scrollView isKindOfClass:[UIWebView class]]){
                //                    UIWebView *webView=(UIWebView *)self.scrollView;
                //                    webView.scrollView.contentOffset=CGPointMake(webView.scrollView.contentOffset.x, webView.scrollView.contentOffset.y-44);
                //                }

            [UIView animateWithDuration:0.2 animations:^{
                tabView.alpha = 0;
                
            }];
            self.isHidden=YES;
        }
    }
    
    
    
}
- (void)setViews:(int)tag{
    if (tag == 2) {
        [self requestPost:newscId+1 andTagView:100];

    }else{
        if ((newscId-1)>0) {
            [self requestPost:newscId-1 andTagView:100];
        }else{
             self.titleLabelup.text = @"这已经是第一条了";
        }
        
    }
    

       }
- (void)setViewContent{
    self.titleLabel.text = title;
   

    
    NSURL *photourl = [NSURL URLWithString:imgNext];
    //url请求实在UI主线程中进行的
    UIImage *images = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];//通过网络url获取uiimage
  
     self.imageView.image = images;

}
- (void)setViewContentup{
    self.titleLabelup.text = title;
    
    
    
    NSURL *photourl = [NSURL URLWithString:imgNext];
    //url请求实在UI主线程中进行的
    UIImage *images = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];//通过网络url获取uiimage
    
    self.imageViewup.image = images;
    
}
@end
