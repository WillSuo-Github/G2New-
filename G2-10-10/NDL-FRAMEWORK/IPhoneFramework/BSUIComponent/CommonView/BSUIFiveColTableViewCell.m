//
//  BSUIFiveColTableViewCell.m
//  KTAPP
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSUIFiveColTableViewCell.h"
#import "BSUIFrameworkHeader.h"

@interface BSUIFiveColTableViewCell()

@property (nonatomic,strong) NSArray *bsContentArray;

@end

@implementation BSUIFiveColTableViewCell

@synthesize bsContentArray;

@synthesize imgButton;//Button
@synthesize titleLabel;



- (void)awakeFromNib {
    // Initialization code
    NSLog(@"awakeFromNib");
}
- (void) layoutSubviews {
    [super layoutSubviews];
    self.backgroundView.frame = CGRectMake(9, 0, 302, 44);
    //self.selectedBackgroundView.frame = CGRectMake(9, 0, 302, 44);
    //self.contentView.frame=CGRectMake(9, 0, 302, 44);
    [super layoutSubviews];
}
/**
 *NIB或者故事板方式调用方法
 */
-(UITableViewCell *)viewCellWithBSContentObject:(NSArray *)bscArray{
    //获取当前行所展现数据的数组
    self.bsContentArray=bscArray;
    if((self.bsContentArray==nil)||(self.bsContentArray.count==0)){
        [self.imgButton removeFromSuperview];
        [self.titleLabel removeFromSuperview];
        [self.contentView removeFromSuperview];
        return self;
    }else if (self.bsContentArray.count==1) {
        BSTableContentObject *bs=bscArray[0];
        if(bs.display!=nil){
            //[cellLb setFont:titleLabel.font];
            [self.contentView addSubview:bs.display];
            [bs.display sizeToFit];
            return self;
        }
        
    }
    @try {
        
        [self setContentMode:UIViewContentModeCenter];
        BSTableContentObject *bs=(BSTableContentObject *)bscArray[0];
        //第一个列数据
        [self.imgButton setImage:[UIImage imageNamed:[bs colImageName]] forState:UIControlStateNormal];
        
        [self.imgButton addTarget:self action:@selector(imgButton:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self.imgButton setTag:0];
        [self.titleLabel setText:bs.colTitle];
        
          //第二个展现元素
        int tagIndex=1;
        for (tagIndex=1; tagIndex<bsContentArray.count; tagIndex++) {
            
            bs=(BSTableContentObject *)bscArray[tagIndex];
            CGRect imgRect=self.imgButton.frame;
            int imgRowWith=imgRect.size.width;
            //int rowHight=imgRect.size.height;
            //横向间隙,屏幕总宽度-总元素数量*每个元素宽度
            int imgRowHZ=(SCREEN_WIDTH-imgRowWith*bs.colCapatibilty-imgRect.origin.x)/(bs.colCapatibilty);

            CGRect lbRect=self.titleLabel.frame;//坐标开始位置
            int lbRowWith=self.titleLabel.size.width;
            //int rowHight=imgRect.size.height;
            //横向间隙,屏幕总宽度-总元素数量*每个元素宽度
            int lbRowHZ=(SCREEN_WIDTH-lbRowWith*bs.colCapatibilty-lbRect.origin.x)/(bs.colCapatibilty);

            UIButton *cellBtn = [[UIButton alloc]initWithFrame:BSRectMake(imgRect.origin.x+(imgRowWith+imgRowHZ)*tagIndex,
                                                                          imgRect.origin.y ,
                                                                          imgRect.size.width,imgRect.size.height)];
            
            [cellBtn setImage:[UIImage imageNamed:[bs colImageName]] forState:UIControlStateNormal];
            [cellBtn addTarget:self action:@selector(imgButton:)
                     forControlEvents:UIControlEventTouchUpInside];

            [cellBtn setTag:tagIndex];
            [self.contentView addSubview:cellBtn];
            
            UILabel *cellLb=[[UILabel alloc ]initWithFrame:BSRectMake(lbRect.origin.x+(lbRowWith+lbRowHZ+36)*tagIndex,
                                                                      lbRect.origin.y ,
                                                                      lbRect.size.width,lbRect.size.height) ];
            cellLb.textAlignment = NSTextAlignmentLeft;
            [cellLb setText:bs.colTitle];
            [cellLb setFont:titleLabel.font];
            [self.contentView addSubview:cellLb];
        }

    }
    @catch (NSException *exception) {
        NSLog(@"MultFiveColl TableViewCell Error:%@",exception.reason);
    }
    @finally {
        return self;
    }
    
}

/**
 *手工编码的调用方法
 */
-(UITableViewCell *)viewCellWithHandBSContentObject:(NSArray *)bscArray{
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}



- (void )imgButton:(UIButton *)bsButton{
     NSLog(@"点击动作\t%ld",(long)bsButton.tag);
     BSTableContentObject *bs= (BSTableContentObject *) [ bsContentArray objectAtIndex:bsButton.tag];
    if (bs.vcClass ||bs.colClass) {
         [BSContentObjectNavigation navigatingControllWithStorybord:bs.callerViewController       bsContentObject:bs];
    }
   
}
@end
