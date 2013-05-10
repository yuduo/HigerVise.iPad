#import <Foundation/Foundation.h>

@interface client_user : NSObject

@property (nonatomic, strong) NSNumber * user_id;
@property (nonatomic, strong) NSString * user_empid;
@property (nonatomic, strong) NSString * user_name;
@property (nonatomic, strong) NSString * user_real_name;
@property (nonatomic, strong) NSString * user_level;
@property (nonatomic, strong) NSString * user_area;
@property (nonatomic, strong) NSNumber * user_area_type;
@property (nonatomic, strong) NSNumber * user_type;
@property (nonatomic, strong) NSString * user_email;
@property (nonatomic, strong) NSString * user_phone;
@property (nonatomic, strong) NSString * user_mobile;
@property (nonatomic, strong) NSString * user_picture_url;
@property (nonatomic, strong) NSNumber * data_version;

@end