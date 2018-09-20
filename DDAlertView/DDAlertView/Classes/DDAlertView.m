//
//  DDAlertView.m
//  DDAlertView
//
//  Created by 陈丁丁 on 2018/9/20.
//  Copyright © 2018年 陈丁丁. All rights reserved.
//

#import "DDAlertView.h"
#import "CNPPopupController.h"
@implementation DDAlertView
+(CNPPopupController *)show:(NSString*)title
                           detailTitle:(NSString*)detailTitle
                           commitTitle:(NSString*)commitTitle
                           commitBlock:(void(^)(void))commitBlock{
    return [self show:title detailTitle:detailTitle cancelTitle:@"取消" commitTitle:commitTitle commitBlock:commitBlock];
}
+(CNPPopupController *)show:(NSString*)title
                           detailTitle:(NSString*)detailTitle
                           cancelTitle:(NSString*)cancleTitle
                           commitTitle:(NSString*)commitTitle
                           commitBlock:(void(^)(void))commitBlock{
    return [self show:title detailTitle:detailTitle cancelTitle:cancleTitle commitTitle:commitTitle cancelBlock:^{
        
    } commitBlock:commitBlock];
}
+(CNPPopupController *)show:(NSString*)title
                           detailTitle:(NSString*)detailTitle
                           cancelTitle:(NSString*)cancleTitle
                           commitTitle:(NSString*)commitTitle
                           cancelBlock:(void(^)(void))cancelBlock
                           commitBlock:(void(^)(void))commitBlock{
    return [self show:title detailTitle:detailTitle cancelTitle:cancleTitle cancelColor:[UIColor colorWithRed:153.00/255 green:153.00/255 blue:153.00/255 alpha:1] commitTitle:commitTitle cancelBlock:cancelBlock commitBlock:commitBlock shouldDismissOnBackgroundTouch:NO];
}
+(CNPPopupController *)show:(NSString*)title
                           detailTitle:(NSString*)detailTitle
                           cancelTitle:(NSString*)cancleTitle
                           cancelColor:(UIColor*)cancleColor
                           commitTitle:(NSString*)commitTitle
                           cancelBlock:(void(^)(void))cancelBlock
                           commitBlock:(void(^)(void))commitBlock
        shouldDismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch
{
    __block CNPPopupController* popupController = nil;
    float buttonHeight=50;
    //弹出提示框
    float screenWidth=[UIScreen mainScreen].bounds.size.width;
    float popViewWidth=screenWidth-64-16;
    UIView *customView0 = [[UIView alloc] init];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 20, popViewWidth-32, 16)];
    titleLabel.numberOfLines = 0;
    titleLabel.text =  NSLocalizedString(title,@"");
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [customView0 addSubview:titleLabel];
    float detailTitleHeight=0;
    float totalHeight=52;
    if (detailTitle) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.lineSpacing=5;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGSize size = [detailTitle boundingRectWithSize:CGSizeMake(popViewWidth-32,10000.0f)
                                                options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        UILabel * contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(16, 50 , popViewWidth-32, size.height)];
        contentLabel.text=detailTitle;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:detailTitle];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [detailTitle length])];
        contentLabel.attributedText = attributedString;
        contentLabel.numberOfLines=0;
        contentLabel.textAlignment=NSTextAlignmentCenter;
        contentLabel.font=[UIFont systemFontOfSize:16];
        contentLabel.textColor=[UIColor colorWithRed:51.00/255 green:51.00/255 blue:51.00/255 alpha:1];
        detailTitleHeight=size.height;
        [customView0 addSubview:contentLabel];
        totalHeight=totalHeight+detailTitleHeight;
    }else{
        totalHeight=totalHeight-16;
    }
    customView0.frame=CGRectMake(16, 0, popViewWidth, totalHeight);
    
    UIView *customView = [[UIView alloc] init];
    float cancelWidth=0;
    if (cancleTitle) {
        cancelWidth=popViewWidth/2;
        CNPPopupButton *cancelButton = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, popViewWidth/2+1, buttonHeight)];
        [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        cancelButton.layer.borderColor=[UIColor colorWithRed:237.00/255 green:237.00/255 blue:237.00/255 alpha:1].CGColor;
        cancelButton.layer.borderWidth=1;
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancelButton setTitle:cancleTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:cancleColor forState:UIControlStateNormal];
        cancelButton.selectionHandler = ^(CNPPopupButton *button){
            [popupController dismissPopupControllerAnimated:YES];
            NSLog(@"点击了取消");
            if (cancelBlock) {
                cancelBlock();
            }
        };
        [customView addSubview:cancelButton];
    }
    CNPPopupButton *commitbutton = [[CNPPopupButton alloc] initWithFrame:CGRectMake( cancelWidth, 0, popViewWidth-cancelWidth, buttonHeight)];
    commitbutton.layer.borderWidth=1;
    commitbutton.layer.borderColor=[UIColor colorWithRed:237.00/255 green:237.00/255 blue:237.00/255 alpha:1].CGColor;
    commitbutton.titleLabel.font = [UIFont systemFontOfSize:16];
    [commitbutton setTitle:commitTitle forState:UIControlStateNormal];
    [commitbutton setTitleColor:[UIColor colorWithRed:0 green:153.00/255 blue:1 alpha:1] forState:UIControlStateNormal];
    commitbutton.selectionHandler = ^(CNPPopupButton *button){
        [popupController dismissPopupControllerAnimated:YES];
        if (commitBlock) {
            commitBlock();
        }
    };
    customView.frame=CGRectMake(16, 0, popViewWidth, buttonHeight);
    [customView addSubview:commitbutton];
    
    
    popupController=[[CNPPopupController alloc] initWithContents:@[customView0, customView]];
    popupController.theme = [CNPPopupTheme defaultTheme];
    popupController.theme.popupStyle = CNPPopupStyleCentered;
    popupController.theme.popupContentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    popupController.theme.movesAboveKeyboard=YES;
    popupController.theme.shouldDismissOnBackgroundTouch=shouldDismissOnBackgroundTouch;
    [popupController presentPopupControllerAnimated:YES];
    return popupController;
}
@end
