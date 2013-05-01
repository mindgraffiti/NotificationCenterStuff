//
//  ViewController.m
//  NotificationCenterStuff
//
//  Created by Thuy Copeland on 4/29/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UITextField *activeField;
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
        
        // NSLog(@"keyboard shown");
        // Now we want to scroll the view. So why doesn't this work?
        // self.myScrollView.frame.size.height = 10;
        // because the frame property is read-only!
        
        // so instead, let's assign a new frame.
        CGRect frame = self.myScrollView.frame;
        // and manipulate the frame
        frame.size.height -= keyboardRect.size.height;
        self.myScrollView.frame = frame;
        
        // set up where the vertical position should be
        int y = self.activeField.frame.origin.y - self.myScrollView.frame.size.height / 2 - self.activeField.frame.size.height / 2;
        
        [UIView animateWithDuration:0.3f animations:^{
            // then position the active field
            self.myScrollView.contentOffset = CGPointMake(0, y);
        }];
        
    }];
    
    // this is the listener for the event where we hid the keyboard
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        // so now that the keyboard is dismissing, let's redraw the scrollView area to its original size
        NSDictionary *userInfo = [note userInfo];
        CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGRect frame = self.myScrollView.frame;
        frame.size.height += keyboardRect.size.height;
        [UIView animateWithDuration:0.45f animations:^{
            // then position the frame
            self.myScrollView.frame = frame;
        }];
        
        // NSLog(@"keyboard hidden");
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
    
    // 3. for a cleaner way to say this, you could:
    // self.myScrollView.contentSize = self.myScrollView.frame.size;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // if they are in the last field,
    if (textField.tag == 3) {
        // says the textfield is no longer the main focus
        [textField resignFirstResponder];
    } else {
        // move the view to the next textField based on the tag
        UIView *next = [self.view viewWithTag:textField.tag + 1];
        [next becomeFirstResponder];
    }
    
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    // put the textfield in the middle of the scrollView so you can see it easily
    // set the activeField to the thing that got sent to us
    self.activeField = textField;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
