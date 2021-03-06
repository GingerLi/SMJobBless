//
//  Helper.m
//  SMJobBless
//
//  Created by itisdev on 7/24/14.
//
//

#import "Helper.h"
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
@implementation Helper

@synthesize listener=_listener;
-(void)dealloc
{
    [_listener release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        // Set up our XPC listener to handle requests on our Mach service.
        _listener = [[NSXPCListener alloc] initWithMachServiceName:kHelperToolMachServiceName];
        [_listener setDelegate:self];
    }
    return self;
}

- (void)run
{
    // Tell the XPC listener to start processing requests.
    NSLog(@"Helper running...");
    [self.listener resume];
    
    // Run the run loop forever.
    
    [[NSRunLoop currentRunLoop] run];
}
- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection
// Called by our XPC listener when a new connection comes in.  We configure the connection
// with our protocol and ourselves as the main object.
{
    assert(listener == self.listener);
#pragma unused(listener)
    assert(newConnection != nil);
    
    newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(HelperProtocol)];
    newConnection.exportedObject = self;
    [newConnection resume];
    
    return YES;
}
-(void)whoAreYouWithReply:(void(^)(NSString * str))reply{
    NSLog(@"I am helper");
    NSLog(@"Hello world! uid = %d, euid = %d, pid = %d\n", (int)getuid(),(int)geteuid(), (int)getpid());
    reply(@"haha");
}
@end
