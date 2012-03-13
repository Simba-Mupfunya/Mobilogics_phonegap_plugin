#import "Mobilogics.h"

@implementation Mobilogics
@synthesize callbackId;
@synthesize connectionCallbackId;

- (void) start:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    BarcodeBuilder *builder = [[BarcodeBuilder alloc] init];
    [[Connection sharedInstance] setBuilder:builder];
    [[Connection sharedInstance] addAccessoryDidConnectNotification:self];
    [[Connection sharedInstance] addAccessoryDidDisconnectNotification:self];
    [[Connection sharedInstance] addReceiveCommandHandler:self];
}

- (void)stop:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    [[Connection sharedInstance] removeAccessoryDidConnectNotification:self];
    [[Connection sharedInstance] removeAccessoryDidDisconnectNotification:self];
    [[Connection sharedInstance] removeReceiveCommandHandler:self];
}

- (void)scan:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    self.callbackId = [arguments objectAtIndex:0];
    if ([[Connection sharedInstance] isConnected])
        [[Connection sharedInstance] execute:[ScanShot sharedInstance]];
}

- (void)addConnectionListener:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    self.connectionCallbackId = [arguments objectAtIndex:0];
}

- (void)connectNotify 
{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    NSString *jsString = [result toSuccessCallbackString:connectionCallbackId];
    [self.webView stringByEvaluatingJavaScriptFromString:jsString];
}

- (void)disconnectNotify
{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    NSString *jsString = [result toErrorCallbackString:connectionCallbackId];
    [self.webView stringByEvaluatingJavaScriptFromString:jsString];
}

- (BOOL)isHandler:(NSObject<CommandReceiver> *)command {
    return [command isKindOfClass:[ScanShotReceiver class]];
}

- (void)handleRequest:(NSObject<CommandReceiver> *)command {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[command getReceiveString]];
    NSString *jsString = [result toSuccessCallbackString:callbackId];
    [self.webView stringByEvaluatingJavaScriptFromString:jsString];
}


@end