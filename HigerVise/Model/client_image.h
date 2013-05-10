#import <Foundation/Foundation.h>

@interface client_image : NSObject

@property (nonatomic, strong) NSNumber * image_id;
@property (nonatomic, strong) NSString * reference_id;
@property (nonatomic, strong) NSNumber * image_type;
@property (nonatomic, strong) NSString * image_type_name;
@property (nonatomic, strong) NSString * image_url;
@property (nonatomic, strong) NSString * image_thum_url;
@property (nonatomic, strong) NSString * image_title;
@property (nonatomic, strong) NSString * image_desc;
@property (nonatomic, strong) NSNumber * image_parent_id;
@property (nonatomic, strong) NSNumber * data_version;

@end

@interface client_image_group : NSObject

@property (nonatomic, strong) NSNumber * image_type;
@property (nonatomic, strong) NSString * image_type_name;
@property (nonatomic, strong) NSArray * images;

@end