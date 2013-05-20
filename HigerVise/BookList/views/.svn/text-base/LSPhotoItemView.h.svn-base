//
//  LSPhotoItemView.h
//  Locoso
//
//  Created by zhiwei ma on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSPhotoItemView;
@protocol LSPhotoItemViewDelegate
- (void)didDeleteItem:(LSPhotoItemView*)aItemView;
- (void)didClickItem:(LSPhotoItemView*)aItemView;
@end

typedef enum
{
    LSPhotoItemViewStateNormal,
    LSPhotoItemViewStateDelete
}LSPhotoItemViewState;

@interface LSPhotoItemView : UIView
{
    id<LSPhotoItemViewDelegate> _delegate;
    LSPhotoItemViewState _state;
    UIImageView* _imageView;
    UILabel* _textLabel;
    UIButton* _deleteButton;
}
@property (nonatomic, assign) id<LSPhotoItemViewDelegate> delegate;
@property (nonatomic, assign) LSPhotoItemViewState state;
@property (nonatomic, retain) UIImageView* imageView;
@property (nonatomic, retain) UILabel* textLabel;
@end
