

static NSString *const errorDomain = @"com.LabWork4.serializer";


typedef NS_ENUM(NSInteger, ErrorCode)
{
    unsupportedInputParametr = 101,
    unsupportedObject = 102,
    unsupportedKeyType = 103,
    unsupportedContentsOfNSValue = 104
};