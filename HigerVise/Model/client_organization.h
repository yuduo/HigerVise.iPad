#import <Foundation/Foundation.h>

@interface client_organization : NSObject

@property (nonatomic, strong) NSNumber * organization_id;
@property (nonatomic, strong) NSString * organization_code;
@property (nonatomic, strong) NSString * organization_name;
@property (nonatomic, strong) NSNumber * organization_type;
@property (nonatomic, strong) NSNumber * organization_parent_id;
@property (nonatomic, strong) NSString * organization_parent_code;
@property (nonatomic, strong) NSNumber * organization_parent_type;
@property (nonatomic, strong) NSNumber * data_version;

@end