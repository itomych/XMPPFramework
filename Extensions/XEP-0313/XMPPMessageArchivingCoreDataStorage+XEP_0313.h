//
//  XMPPMessageArchivingCoreDataStorage+XEP_0313.h
//  Mangosta
//
//  Created by Piotr Wegrzynek on 23/05/2017.
//  Copyright © 2017 Inaka. All rights reserved.
//

#import "XMPPOneToOneChat+XEP_0313.h"
#import "XMPPMessage+XEP_0313.h"
#import "XMPPMessageArchivingCoreDataStorage.h"

@interface XMPPMessageArchivingCoreDataStorage (XEP_0313) <XMPPMessageArchiveManagementAwareOneToOneChatDelegate>

- (void)xmppOneToOneChat:(XMPPOneToOneChat *)sender didReceiveArchivedMessage:(XMPPMessage *)message;

@end
