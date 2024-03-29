#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <Barcode/BarcodeFramework.h>
#import <DevTool/DevToolFramework.h>

@interface Mobilogics : CDVPlugin <ReceiveCommandHandler, NotificationHandler> {

}

@property (copy) NSString *callbackId;
@property (copy) NSString *connectionCallbackId;

- (void)start:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void)stop:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void)scan:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void)addConnectionListener:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end