#import <Foundation/Foundation.h>

@interface client_dialogue_attach : NSObject

@property (nonatomic, strong) NSString * dialogue_attach_id;
@property (nonatomic, strong) NSString * dialogue_master_id;
@property (nonatomic, strong) NSString * dialogue_detail_id;
@property (nonatomic, strong) NSString * attach_title;
@property (nonatomic, strong) NSString * attach_desc;
@property (nonatomic, strong) NSString * attach_url;
@property (nonatomic, strong) NSString * attach_thum_url;
@property (nonatomic, strong) NSNumber * is_used;
@property (nonatomic, strong) NSString * create_userid;
@property (nonatomic, strong) NSString * create_time;
@property (nonatomic, strong) NSString * update_userid;
@property (nonatomic, strong) NSString * update_time;
@property (nonatomic, strong) NSNumber * data_version;

@end