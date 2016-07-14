//
//  Serializable.h
//  Serializer
//


@protocol Serializable <NSObject>

- (NSString *)serializeWithError:(NSError *__autoreleasing*)error;

@end