//
//  DropboxController.h
//  Hourglass
//
//  Created by Sven A. Schmidt on 05.10.10.
//  Copyright 2010 abstracture GmbH & Co. KG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DropboxSDK.h"

static NSString *kAccountInfoLoaded __attribute__ ((unused)) = @"AccountInfoLoaded";

@interface DropboxController : NSObject<DBLoginControllerDelegate, DBRestClientDelegate> {

}

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) DBRestClient *restClient;

+ (id)sharedInstance;

@end