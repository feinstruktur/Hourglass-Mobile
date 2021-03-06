//
//  DirectoryViewController.h
//  Hourglass
//
//  Created by Sven A. Schmidt on 05.10.10.
//  Copyright 2010 abstracture GmbH & Co. KG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropboxController.h"


static NSString *kFileChosen __attribute__ ((unused)) = @"FileChosen";


@interface DirectoryViewController : UITableViewController<DBRestClientDelegate, UIAlertViewDelegate> {

}

@property (nonatomic, retain) DBRestClient *restClient;
@property (nonatomic, retain) NSArray *metadata;

- (void)loadMetadata:(NSString*)path;


@end
