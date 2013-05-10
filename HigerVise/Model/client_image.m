#import "client_image.h"

@implementation client_image

@synthesize image_id;
@synthesize reference_id;
@synthesize image_type;
@synthesize image_type_name;
@synthesize image_url;
@synthesize image_thum_url;
@synthesize image_title;
@synthesize image_desc;
@synthesize image_parent_id;
@synthesize data_version;

@end

@implementation client_image_group

@synthesize image_type;
@synthesize image_type_name;
@synthesize images;

@end