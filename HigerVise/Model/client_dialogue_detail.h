#import <Foundation/Foundation.h>

@interface client_dialogue_detail : NSObject

@property (nonatomic, strong) NSString * dialogue_detail_id;
@property (nonatomic, strong) NSString * dialogue_master_id;
@property (nonatomic, strong) NSNumber * dialogue_detail_type;
@property (nonatomic, strong) NSString * dialogue_detail_message;
@property (nonatomic, strong) NSNumber * is_send;
@property (nonatomic, strong) NSNumber * is_used;
@property (nonatomic, strong) NSString * create_userid;
@property (nonatomic, strong) NSString * create_time;
@property (nonatomic, strong) NSString * update_userid;
@property (nonatomic, strong) NSString * update_time;
@property (nonatomic, strong) NSNumber * data_version;

@end