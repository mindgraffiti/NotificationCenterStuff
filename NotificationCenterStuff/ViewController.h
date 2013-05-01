//
//  ViewController.h
//  NotificationCenterStuff
//
//  Created by Thuy Copeland on 4/29/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
- (IBAction)buttonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@end
