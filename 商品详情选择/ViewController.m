//
//  ViewController.m
//  商品详情选择
//
//  Created by 刘元元 on 2017/8/19.
//  Copyright © 2017年 刘元元. All rights reserved.
//

#import "ViewController.h"
#import "AttributeView.h"
#import "AppDelegate.h"
@interface ViewController (){
    
    float originX;//AttributeView的起始坐标
    float originY;
    AttributeView *attribute;
    UIScrollView *scrollView;
    AppDelegate *appdel;
    NSArray *classfyArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    originY = 15 * appdel.autoSizeScaleY;
    originX = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unload:) name:@"unloadFrame" object:nil];
    NSArray *source = @[@[@"海贼王",@"火影"],@[@"银魂",@"死神",@"妖精的尾巴",@"死亡笔记",@"食梦者"],@[@"银之匙",@"光能使者",@"四驱兄弟",@"足球小将",@"overload"],@[@"叛逆的鲁鲁修",@"铁马少年",@"棋魂",@"食戟之灵",@"我们仍未知道那天所看见的花的名字,我们仍未知道那天所看见的花的名字"],@[@"机巧少女不会受伤",@"恋爱禁止的世界",@"只有神知道的世界"],@[@"狼少女与黑王子",@"只要你告诉我",@"好想急死你好想急死你好想急死你好想急死你好想急死你好想急死你"]];
    
    classfyArr = @[@"热血",@"运动",@"少女",@"校园",@"励志",@"恋爱"];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];
    for (int i = 0; i < source.count; i ++) {
        
        attribute = [[AttributeView alloc] initWithFrame:self.view.frame];
        attribute.tag = 100 + i;
        attribute.attributeTags = i + 100;
        attribute.attributeSource = source[i];
        
        //block处理点击事件
        __weak typeof(ViewController) *weakSelf = self;
        attribute.myBlock  = ^(UIButton * sender) {
            [weakSelf chick:sender];
        };
        
         [scrollView addSubview:attribute];
        
    }
    
}

-(void)chick:(UIButton *)sender{
    NSLog(@"%@",sender.titleLabel.text);
}
//通知
-(void)unload:(NSNotification *)notify{
    
    NSDictionary *dict = notify.userInfo;
    int currentIdx = [[dict objectForKey:@"tag"] intValue];
    float currentH = [[dict objectForKey:@"currentH"] floatValue];
    UIView *view = [attribute viewWithTag:currentIdx];
    //
    UILabel *lab = [[UILabel alloc] init];
    lab.text = [NSString stringWithFormat:@"%@",classfyArr[currentIdx - 100]];
    lab.font = [attribute sizeFont:12];
    lab.backgroundColor = [UIColor whiteColor];
    lab.frame = CGRectMake(15 * appdel.autoSizeScaleY, originY, self.view.frame.size.width, 20 * appdel.autoSizeScaleY);
    [scrollView addSubview:lab];
    //
    view.frame = CGRectMake(originX, lab.frame.origin.y + lab.frame.size.height, self.view.frame.size.width,currentH + 15 * appdel.autoSizeScaleY);
    originY = view.frame.origin.y + currentH + 30 * appdel.autoSizeScaleY;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, originY);

}

@end
