//
//  StatusBarController.m
//  Hourglass
//
//  Created by Sven A. Schmidt on 06.10.10.
//  Copyright 2010 abstracture GmbH & Co. KG. All rights reserved.
//

#import "StatusBarController.h"
#import "DropboxController.h"


@implementation StatusBarController

@synthesize statusLabel;
@synthesize syncButton;
@synthesize progressView;


#pragma mark -
#pragma mark Workers
#pragma mark -

// load notification handlers

- (void)fileLoadingStarted:(NSNotification *)notification {
  NSString *filename = [[NSUserDefaults standardUserDefaults] stringForKey:@"DropboxFileName"];
  filename = [filename lastPathComponent];
  self.statusLabel.text = [NSString stringWithFormat:@"Loading: %@ ... (0%%)", filename];
  [self.progressView startAnimating];
  self.syncButton.hidden = YES;
}


- (void)fileLoaded:(NSNotification *)notification {
  NSString *filename = [[NSUserDefaults standardUserDefaults] stringForKey:@"DropboxFileName"];
  self.statusLabel.text = [filename lastPathComponent];
  [self.progressView stopAnimating];
  self.syncButton.hidden = NO;
}


- (void)fileLoadProgress:(NSNotification *)notification {
  NSString *filename = [[NSUserDefaults standardUserDefaults] stringForKey:@"DropboxFileName"];
  filename = [filename lastPathComponent];
  NSNumber *progress = [[notification userInfo] objectForKey:@"progress"];
  self.statusLabel.text = [NSString stringWithFormat:@"Loading: %@ ... (%.0f%%)", filename, [progress floatValue]*100];
}


// save notification handlers

- (void)fileSavingStarted:(NSNotification *)notification {
  NSString *filename = [[NSUserDefaults standardUserDefaults] stringForKey:@"DropboxFileName"];
  filename = [filename lastPathComponent];
  self.statusLabel.text = [NSString stringWithFormat:@"Saving: %@ ... (0%%)", filename];
  [self.progressView startAnimating];
  self.syncButton.hidden = YES;
}


- (void)fileSaved:(NSNotification *)notification {
  NSString *filename = [[NSUserDefaults standardUserDefaults] stringForKey:@"DropboxFileName"];
  self.statusLabel.text = [filename lastPathComponent];
  [self.progressView stopAnimating];
  self.syncButton.hidden = NO;
}


- (void)fileSaveProgress:(NSNotification *)notification {
  NSString *filename = [[NSUserDefaults standardUserDefaults] stringForKey:@"DropboxFileName"];
  filename = [filename lastPathComponent];
  NSNumber *progress = [[notification userInfo] objectForKey:@"progress"];
  self.statusLabel.text = [NSString stringWithFormat:@"Saving: %@ ... (%.0f%%)", filename, [progress floatValue]*100];
}


// button handler


- (void)syncButtonTapped {
  NSLog(@"Sync");
  [[DropboxController sharedInstance] saveFile];
}


#pragma mark -
#pragma mark Application Lifecycle
#pragma mark -


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    // notification handlers
    // load
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fileLoadingStarted:)
                                                 name:kFileLoadingStarted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fileLoaded:)
                                                 name:kFileLoaded object:nil];  
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fileLoadProgress:)
                                                 name:kFileLoadProgress object:nil];  
    // save
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fileSavingStarted:)
                                                 name:kFileSavingStarted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fileSaved:)
                                                 name:kFileSaved object:nil];  
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fileSaveProgress:)
                                                 name:kFileSaveProgress object:nil];  
  }
  return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIGestureRecognizer *gr = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(syncButtonTapped)] autorelease];
  [self.syncButton addGestureRecognizer:gr];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
