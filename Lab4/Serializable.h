#ifndef Lab4_SerializatorProtocol_h
#define Lab4_SerializatorProtocol_h

@protocol Serializable <NSObject>

-(NSString*) serializeWithError:(NSError *__autoreleasing *) error;

@end


#endif
