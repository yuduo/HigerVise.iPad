//
//  LSMessageListTableViewCellCell.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSMessageListTableViewCellCell.h"
#import "RJLabel.h"
#import "LSDefine.h"

#define LSMessageListTableViewCellCellVGap 5
#define LSMessageListTableViewComponentVGap 3
#define LSSingleLineLabelHeight 20
#define LSReplyBgExtendHeight 10

@implementation LSMessageListTableViewCellCell
+ (CGFloat)minumumHeight:(LSDataMessage*)aMessage
{
    CGFloat height = LSMessageListTableViewCellCellVGap;
    
    CGSize contentSize = [UILabel fitSize:300 text:aMessage.content font:LSFontNormal numberOfLines:2 lineBreakMode:UILineBreakModeTailTruncation];
    height += contentSize.height + LSMessageListTableViewComponentVGap;
    height += LSSingleLineLabelHeight + LSMessageListTableViewCellCellVGap;
    
    if ([aMessage.replyContent length] > 0)
    {
        contentSize = [UILabel fitSize:300 text:aMessage.replyContent font:LSFontNormal numberOfLines:2 lineBreakMode:UILineBreakModeTailTruncation];
        height += contentSize.height + LSReplyBgExtendHeight;
    }
    return height;
}

- (void)dealloc
{
    [_lbContent release];
    [_lbSenderName release];
    [_lbTime release];
    [_lbReply release];
    [super dealloc];
}

- (void)updateWithData:(LSDataMessage*)aMessage
{
    CGPoint startPoint = CGPointMake(10, LSMessageListTableViewCellCellVGap);
    CGFloat sendernameLableWith = 130;
    
    CGSize contentSize = [UILabel fitSize:290 text:aMessage.content font:LSFontNormal numberOfLines:2 lineBreakMode:UILineBreakModeTailTruncation];
    CGRect tmpRect = CGRectMake(startPoint.x,startPoint.y,290,contentSize.height);
    if (nil == _lbContent)
    {
        _lbContent = [[UILabel alloc] initWithFrame:tmpRect];
        _lbContent.numberOfLines = 0;
        _lbContent.font = LSFontNormal;
        _lbContent.textColor = LSCOLOR_BLACK;
        [self.contentView addSubview:_lbContent];
    }
    else 
    {
        _lbContent.frame = tmpRect;
    }
    _lbContent.text = aMessage.content;
    
    startPoint.y += contentSize.height + LSMessageListTableViewComponentVGap;
    tmpRect = CGRectMake(startPoint.x,startPoint.y,sendernameLableWith,LSSingleLineLabelHeight);
    if (nil == _lbSenderName)
    {
        _lbSenderName = [[UILabel alloc] initWithFrame:tmpRect];
        _lbSenderName.font = LSFontSmall;
        _lbSenderName.textColor = LSCOLOR_6A6A6A;
        [self.contentView addSubview:_lbSenderName];
    }
    else 
    {
        _lbSenderName.frame = tmpRect;
    }
    _lbSenderName.text = aMessage.senderuaname;
    
    startPoint.x += sendernameLableWith + 3;
    tmpRect = CGRectMake(startPoint.x, startPoint.y, 150, LSSingleLineLabelHeight);
    if (nil == _lbTime)
    {
        _lbTime = [[UILabel alloc] initWithFrame:tmpRect];
        _lbTime.font = LSFontSmall;
        _lbTime.textColor = LSCOLOR_6A6A6A;
        _lbTime.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_lbTime];
    }
    else 
    {
        _lbTime.frame = tmpRect;
    }
    _lbTime.text = aMessage.createtime;
    
    if ([aMessage.replyContent length] > 0)
    {
        startPoint.x = 10;
        startPoint.y += LSSingleLineLabelHeight + LSMessageListTableViewComponentVGap;
        contentSize = [UILabel fitSize:300 text:aMessage.replyContent font:LSFontNormal numberOfLines:2 lineBreakMode:UILineBreakModeTailTruncation];
        tmpRect = CGRectMake(0, startPoint.y, 320, contentSize.height + LSReplyBgExtendHeight);
        if (nil == _vReplyBg)
        {
            _vReplyBg = [[UIView alloc] initWithFrame:tmpRect];
            _vReplyBg.backgroundColor = LSCOLOR_FEFDED;
            [self.contentView addSubview:_vReplyBg];
            
            tmpRect = CGRectMake(startPoint.x, startPoint.y, 300, contentSize.height);
            _lbReply = [[UILabel alloc] initWithFrame:tmpRect];
            _lbReply.center = _vReplyBg.center;
            _lbReply.backgroundColor = LSCOLOR_CLEAR;
            _lbReply.numberOfLines = 0;
            _lbReply.font = LSFontNormal;
            _lbReply.textColor = LSCOLOR_EB7A00;
            [self.contentView addSubview:_lbReply];
        }
        else 
        {
            _vReplyBg.hidden = NO;
            _vReplyBg.frame = tmpRect;
            
            tmpRect = CGRectMake(startPoint.x, startPoint.y, 300, contentSize.height);
            _lbReply.hidden = NO;
            _lbReply.frame = tmpRect;
        }
        _lbReply.text = aMessage.replyContent;
    }
    else 
    {
        _vReplyBg.hidden = YES;
        _lbReply.hidden = YES;
    }
}
@end
