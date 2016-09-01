# VIPopView
一行代码添加有动画效果的弹窗，可以设置其锚点
![image](https://github.com/viawei/VIPopView/blob/master/VIPopView/PopGIF.gif)

使用方法：

/**
 *  Description
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
