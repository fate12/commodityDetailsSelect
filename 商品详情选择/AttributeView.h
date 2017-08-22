//
//  AttributeView.h
//  商品详情选择
//
//  Created by 刘元元 on 2017/8/19.
//  Copyright © 2017年 刘元元. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AttributeView : UIView
@property (nonatomic , assign) int attributeTags;
@property (nonatomic , strong) NSArray *attributeSource;//数据源


/**
  字体大小
 */
@property (nonatomic , assign) int sizeOfFont;

/**
 字体颜色
 */
@property (nonatomic , strong) UIColor *colorOfFont;

/**
 按钮边框宽度
 */
@property (nonatomic , assign) float btnBorder;

/**
 按钮间的间距X
 */
@property (nonatomic , assign) float spaceX;

/**
 按钮间的间距Y
 */
@property (nonatomic , assign) float spaceY;

/**
 第一个按钮的x
 */
@property (nonatomic , assign) float originX;

/**
 第一个按钮的y
 */
@property (nonatomic , assign) float originY;

/**
 边框颜色
 */
@property (nonatomic , strong) UIColor *borderColor;

/**
 按钮圆角处理
 */
@property (nonatomic , assign) float radiusG;

@property (copy, nonatomic)void(^myBlock)(UIButton *);
-(UIFont *)sizeFont:(int)size;
@end
