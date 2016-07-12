//
//  Serializable.h
//  Serializer
//

@class NSMutableString;
@class NSError;

@protocol Serializable <NSObject>

- (NSString *)serializeWithError:(NSError *__autoreleasing*)error;

@end