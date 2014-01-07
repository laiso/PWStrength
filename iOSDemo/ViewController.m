//
//  ViewController.m
//  iOSDemo
//
//  1/7/14.
//
//

#import "ViewController.h"

#import "PWStrength.h"

@interface ViewController ()
@property(nonatomic, weak) IBOutlet UILabel *statusLabel;
@property(nonatomic, weak) IBOutlet UIProgressView *progressView;
@end

@implementation ViewController

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
  textField.text = @"";
  return [self textField:textField shouldChangeCharactersInRange:NSMakeRange(0, textField.text.length) replacementString:textField.text];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  NSString *subString = [textField.text stringByReplacingCharactersInRange:range withString:string];
  
  PWSResult result = [PWStrength validateWithPassword:subString];
  
  [self.progressView setProgress:result.complexity animated:YES];
  self.progressView.progressTintColor = (result.valid)? [UIColor greenColor]: [UIColor redColor];
  
  NSUInteger displayValue = result.complexity * 100;
  NSString *displayValid = (result.valid)? @"YES": @"NO";
  self.statusLabel.text = [NSString stringWithFormat:@"Complexity: %lu %%, Valid: %@", (unsigned long)displayValue, displayValid];
  
  return YES;
}

@end
