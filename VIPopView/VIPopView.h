//
//  VIPopView.h
//  VIPopView
//
//  Created by JM on 16/1/28.
//  Copyright © 2016年 xvv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIPopView : UIView

/**
 *  <#Description#>
 *
 *  @param frame       视图在window层的位置
 *  @param titleArray  文字数组
 *  @param imageArr    图片数组
 *  @param anchorPoint 锚点：CGPointMake(0, 0) -左上角；CGPointMake(1, 0)-右上角；CGPointMake(0, 1)-左下角；CGPointMake(0, 1)-右下角
 *  @param action      action description
 *
 *  @return return value description
 */
+ (instancetype)initPopViewWithFrame:(CGRect)frame
                            titleArr:(NSArray *)titleArray
                            imageArr:(NSArray *)imageArr
                 anchorPoint:(CGPoint)anchorPoint
           didSelectedAction:(void(^)(NSInteger index))action;
@end
