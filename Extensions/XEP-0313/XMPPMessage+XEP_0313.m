//
//  XMPPMessage+XEP_0313.m
//  XMPPFramework
//
//  Created by Chris Ballinger on 10/23/17.
//  Copyright © 2017 Chris Ballinger. All rights reserved.
//

#import "XMPPMessage+XEP_0313.h"
#import "NSXMLElement+XEP_0297.h"
#import "XMPPJID.h"
#import "NSXMLElement+XMPP.h"
#import "XMPPMessageArchiveManagement.h"

@implementation XMPPMessage (XEP_0313)

- (NSXMLElement *)receivedMessageArchiveResult {

	NSXMLElement *resultElement = self.mamResult;
	
	return [resultElement elementForName:@"forwarded"];
}

- (NSXMLElement*) mamResult {
    NSXMLElement *result = [self elementForName:@"result" xmlns:XMLNS_XMPP_MAM];
    return result;
}

- (BOOL)isMessageArchive {
	if ([self receivedMessageArchiveResult]) {
		return YES;
	}
	return NO;
}

- (NSString *)resultId {

	NSXMLElement *resultElement = self.mamResult;
	if(resultElement) {
		return [resultElement attributeStringValueForName:@"id"];
	}

	return nil;
}

- (NSXMLElement *)delayElement {
	NSXMLElement *resultElement = self.mamResult;
	return [[resultElement elementForName:@"forwarded"] elementForName: @"delay"];
}

- (NSString *)delayStamp {
	NSXMLElement *delay = [self delayElement];
	if (delay) {
		return [delay attributeStringValueForName:@"stamp"];
	}
	return nil;
}

- (XMPPMessage *)messageForForwardedArchiveMessage {
	if (self.mamResult) {
		NSXMLElement *resultElement = self.mamResult;
		DDXMLElement *delayElement = [self delayElement];
		DDXMLElement *internalMessage = [resultElement forwardedMessage];
		
		NSString *resultId = [resultElement attributeStringValueForName:@"id"];
		
        // TODO: [pwe] this method is modifying receiver's "internalMessage" element
        // before fixing, evaluate the impact as it's being called on received messages distributed via multidelegation
		XMPPMessage *message = [XMPPMessage messageFromElement:internalMessage];
		if (delayElement) {
			[message addChild:[delayElement copy]];
		}
		if (resultId) {
			[message addAttributeWithName:@"resultId" stringValue:resultId];
		}
		
		return message;
	}
	return self;
}

@end
