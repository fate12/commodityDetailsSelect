//
//  AttributeView.m
//  商品详情选择
//
//  Created by 刘元元 on 2017/8/19.
//  Copyright © 2017年 刘元元. All rights reserved.
//
#define IS_IPHONE_4_OR_LESS  ([[UIScreen mainScreen] bounds].size.height < 568)
#define IS_IPHONE_5  ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE_6  ([[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_IPHONE_6P  ([[UIScreen mainScreen] bounds].size.height == 736.0)
#import "AttributeView.h"
#import "AppDelegate.h"
@interface AttributeView(){
    
    NSArray *source;
    
    float minW;//按钮最小宽度
    float minH;//按钮最小高度；
    float viewWidth;//view宽度
    UIButton *selectBtn;//被选中的按钮
    float addSpace;//按钮添加的距离
    AppDelegate *appdel;
    
}
@end
@implementation AttributeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.btnBorder = 0.5;
        self.borderColor = [UIColor blackColor];
        self.colorOfFont = [UIColor blackColor];
        self.sizeOfFont = 10;
        self.spaceX = 15 * appdel.autoSizeScaleX;
        self.spaceY = 15 * appdel.autoSizeScaleY;
        self.originX = 15 * appdel.autoSizeScaleX;
        self.originY = 15 * appdel.autoSizeScaleY;
        self.radiusG = 3 * appdel.autoSizeScaleX;
        addSpace = 15 * appdel.autoSizeScaleX;

   }
    return self;
}

-(void)setAttributeSource:(NSArray *)attributeSource{
    
    source = attributeSource;
    
    //记录当前的按钮的位置大小状况；
    float currentX = 0;
    float currentY = 0;
    float currentW = 0;
    float currentH = 0;
    
    float x = 0;
    float y = 0;

    viewWidth = self.frame.size.width;
    
    [self valueOfMinWAndMinH];
    
    for (int i = 0; i < source.count; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 10 + i;
        
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(chick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5 * appdel.autoSizeScaleX, 0, 5 * appdel.autoSizeScaleX);//约束文字显示
        /*
         设置的按钮的样式
         */
        
        if (_radiusG > 0) {
            btn.layer.cornerRadius = _radiusG;
            btn.clipsToBounds = YES;
            btn.layer.masksToBounds = YES;
        }
        if (_btnBorder > 0.0) {
            btn.layer.borderWidth = _btnBorder;
        }
        if (_borderColor != nil) {
            btn.layer.borderColor = [_borderColor CGColor];
        }
        
        [btn setTitleColor:_colorOfFont forState:UIControlStateNormal];
        [btn setTitle:source[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [self sizeFont:_sizeOfFont];
        btn.titleLabel.numberOfLines = 2;
        
        
        /*计算按钮位置,最多两排*/
        
        CGSize size = [self getViewSizeWithText:[NSString stringWithFormat:@"%@",source[i]] viewSize:CGSizeMake(viewWidth - 2 *_originX - addSpace, minH * 2) fontSize:[self sizeFont:_sizeOfFont]];//viewWidth - 20 - distance 因为按钮的宽度+distance
        //设置两个汉字为最小宽度
        size.width = size.width > minW ? size.width:minW;
    

        
        if (i == 0) {//
            x = _originX;
            y = _originY;
        }
        else if (i > 0 && (currentX + currentW  + _spaceX + size.width + addSpace) > viewWidth - 2*_originX) {//如果超出了屏幕宽度
            
            x = _originX;
            y = currentY  + _spaceY + currentH;
            
        }
        else{
            //如果是两行文字，就单独一排
            if (size.height > minH || currentH > minH + addSpace) {
                
                x = _originX;
                y = currentY  + _spaceY + currentH;
            }
            else{
                x = currentX + _spaceX + currentW;
                y = currentY;
            }
            
        }
        btn.frame = CGRectMake(x, y, size.width + addSpace, size.height + addSpace);
        
        //
        currentX = btn.frame.origin.x;
        currentY = btn.frame.origin.y;
        currentW = btn.frame.size.width;
        currentH = btn.frame.size.height;
        
    }
    
    
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] init];
    [dictM setObject:[NSString stringWithFormat:@"%d",_attributeTags] forKey:@"tag"];
    [dictM setObject:[NSString stringWithFormat:@"%f",currentH + currentY] forKey:@"currentH"];
    
    
    
    //    NSLog(@"%@", NSStringFromCGRect(viewRect));
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unloadFrame" object:nil userInfo:dictM];

  
}
//计算一个按钮的最小宽度。

-(void)valueOfMinWAndMinH{
    
    //设置为三个字长度
    CGSize size = [self getViewSizeWithText:@"自定义"
                                   viewSize:CGSizeZero
                                   fontSize:[self sizeFont:_sizeOfFont]];
    minW = size.width;
    minH = size.height;
    
}

-(void)chick:(UIButton *)sender{
    
    if (sender != selectBtn) {
        
        sender.selected = YES;
        selectBtn.selected = NO;
        //
        sender.layer.borderColor = [[UIColor redColor] CGColor];
        selectBtn.layer.borderColor = [[UIColor blackColor] CGColor];
        
        selectBtn = sender;
    }
    else{
        selectBtn.selected = YES;
    }
    
    if (_myBlock) {
        self.myBlock(sender);
    }
    
}

-(UIFont *)sizeFont:(int)size{
    
    UIFont *sizeFont;
    if (IS_IPHONE_6P) {
        sizeFont = [UIFont systemFontOfSize:size + 4];
    }
    else if (IS_IPHONE_6) {
        sizeFont = [UIFont systemFontOfSize:size + 2];
    }
    else{
        sizeFont = [UIFont systemFontOfSize:size];
    }
    return sizeFont;
    
}
-(CGSize)getViewSizeWithText:(NSString *)aText viewSize:(CGSize)constraintSize fontSize:(UIFont *)font
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *attributes = @{NSFontAttributeName: font, NSParagraphStyleAttributeName : paragraphStyle };
    
    CGRect frame = [aText boundingRectWithSize:constraintSize
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes
                                       context:nil];
    
    return frame.size;
}

@end
