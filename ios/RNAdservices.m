#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNAdServices, NSObject)

RCT_EXTERN_METHOD(getAttributionToken:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getAttributionData:(NSString)token
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

@end
