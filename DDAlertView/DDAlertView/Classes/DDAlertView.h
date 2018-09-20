//
//  DDAlertView.h
//  DDAlertView
//
//  Created by 陈丁丁 on 2018/9/20.
//  Copyright © 2018年 陈丁丁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDAlertView : NSObject
+(id)show:(NSString*)title
                detailTitle:(NSString*)detailTitle
                commitTitle:(NSString*)commitTitle
                commitBlock:(void(^)(void))commitBlock;
+(id)show:(NSString*)title
                detailTitle:(NSString*)detailTitle
                cancelTitle:(NSString*)cancleTitle
                commitTitle:(NSString*)commitTitle
                commitBlock:(void(^)(void))commitBlock;
+(id)show:(NSString*)title
                detailTitle:(NSString*)detailTitle
                cancelTitle:(NSString*)cancleTitle
                commitTitle:(NSString*)commitTitle
                cancelBlock:(void(^)(void))cancelBlock
                commitBlock:(void(^)(void))commitBlock;
+(id)show:(NSString*)title
                detailTitle:(NSString*)detailTitle
                cancelTitle:(NSString*)cancleTitle
                cancelColor:(UIColor*)cancleColor
                commitTitle:(NSString*)commitTitle
                cancelBlock:(void(^)(void))cancelBlock
                commitBlock:(void(^)(void))commitBlock
shouldDismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch;
@end

NS_ASSUME_NONNULL_END
