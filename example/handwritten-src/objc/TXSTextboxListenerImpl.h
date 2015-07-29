#import "TXSTextboxListener.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TXSTextboxListenerImpl : NSObject <TXSTextboxListener>

- (id)initWithUITextView:(UITextView *)textView;

@end
