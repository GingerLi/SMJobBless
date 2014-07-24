//
//  Helper.h
//  SMJobBless
//
//  Created by itisdev on 7/24/14.
//
//

#import <Foundation/Foundation.h>

#define kHelperToolMachServiceName @"com.ginger.bsd.SMJobBlessHelper"

@protocol HelperProtocol
@required
- (void)whoAreYouWithReply:(void(^)(NSString * str))reply;
@end

@interface Helper : NSObject<HelperProtocol, NSXPCListenerDelegate>
{
    NSXPCListener * _listener;
}
@property (atomic, strong, readwrite) NSXPCListener *    listener;
- (id)init;
- (void)run;
@end
