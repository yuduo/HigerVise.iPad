#import <Foundation/Foundation.h>

@interface client_dialogue_master : NSObject

@property (nonatomic, strong) NSString * dialogue_master_id;
@property (nonatomic, strong) NSNumber * dialogue_class_id;
@property (nonatomic, strong) NSNumber * dialogue_master_type;
@property (nonatomic, strong) NSNumber * dialogue_master_limit_time;
@property (nonatomic, strong) NSString * dialogue_master_title;
@property (nonatomic, strong) NSString * dialogue_master_desc;
@property (nonatomic, strong) NSString * dialogue_master_remark;
@property (nonatomic, strong) NSNumber * dialogue_master_status;
@property (nonatomic, strong) NSNumber * dialogue_master_result;
@property (nonatomic, strong) NSNumber * dialogue_master_index;
@property (nonatomic, strong) NSNumber * is_read;
@property (nonatomic, strong) NSNumber * is_attention;
@property (nonatomic, strong) NSNumber * is_share;
@property (nonatomic, strong) NSNumber * is_used;
@property (nonatomic, strong) NSString * create_userid;
@property (nonatomic, strong) NSString * create_time;
@property (nonatomic, strong) NSString * update_userid;
@property (nonatomic, strong) NSString * update_time;
@property (nonatomic, strong) NSNumber * data_version;

@end