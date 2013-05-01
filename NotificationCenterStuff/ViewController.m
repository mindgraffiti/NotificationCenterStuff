//
//  ViewController.m
//  NotificationCenterStuff
//
//  Created by Thuy Copeland on 4/29/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad // "Loaded, not presented!"
{
    [super viewDidLoad];
    
    // NOTE: the removeObserver: method DOES NOT remove blocks.
    /*[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSLog(@"application about to resign active");
    }]; */
    
    // this is the listener for the event where we see the keyboard
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        NSLog(@"%@",[note userInfo]);
        /* Now I want to give space to the keyboard, 
           and use a scrollView for the rest of the screen space. */
        // Let's pull the user's device info. Stuff it in a dictionary.
        NSDictionary *userInfo = [note userInfo];
        // let's save the keyboard info. Now we can refer to it to size the frame!
        CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        
        NSLog(@"keyboard shown");
        // Now we want to scroll the view. So why doesn't this work?
        // self.myScrollView.frame.size.height = 10;
        // because the frame property is read-only!
        
        // so instead, let's assign a new frame.
        CGRect frame = self.myScrollView.frame;
        // and manipulate the frame
        frame.size.height -= keyboardRect.size.height;
        self.myScrollView.frame = frame;
    }];
    
    // this is the listener for the event where we hid the keyboard
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        // so now that the keyboard is dismissing, let's redraw the scrollView area to its original size
        NSDictionary *userInfo = [note userInfo];
        CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGRect frame = self.myScrollView.frame;
        frame.size.height += keyboardRect.size.height;
        self.myScrollView.frame = frame;
        NSLog(@"keyboard hidden");
    }];
    
    
}

- (IBAction)buttonPressed:(id)sender
{
    // post a notification that our object was listening for
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification" object:self];
    // alternative way to use this
    /*
    NSMutableDictionary *myMetadata = [[NSMutableDictionary alloc] init];
    [myMetadata setObject:@"some data" forKey:@"some key"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification" object:self userInfo:myMetadata];
     */
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // if you are limiting the size of your scrollView, do this:
    // 1. measure the size of the scrollView
     CGSize size = self.myScrollView.frame.size;
    // 2. set the content size based on the scrollView's frame
    self.myScrollView.contentSize = size;
    
    // 3. a cleaner way to say this is:
    // self.myScrollView.contentSize = self.myScrollView.frame.size;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // dismiss the keyboard when the textfield is no longer the main focus
    [textField resignFirstResponder];
    
    return NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
