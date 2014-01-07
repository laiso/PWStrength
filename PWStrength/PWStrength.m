//
//  PWStrength.m
//  PWStrength
//
//  1/7/14.
//
//

#import <math.h>

#import "PWStrength.h"

@interface PWStrength()
@property(nonatomic) NSString *password;
@end

@implementation PWStrength

+ (PWSResult)validateWithPassword:(NSString *)password
{
  return [PWStrength validateWithPassword:password minimusComplexity:0.0];
}

+ (PWSResult)validateWithPassword:(NSString *)password minimusComplexity:(float)complexity
{
  PWStrength* strength = [[PWStrength alloc] initWithPassword:password];
  if(complexity > 0.0){
    strength.validComplexity = complexity;
  }
  return [strength validate];
}

- (id)initWithPassword:(NSString *)password
{
  self = [super init];
  if(!self){
    return nil;
  }
  
  _password = password;
  _validComplexity = 0.49f; // Default
  
  return self;
}

#pragma mark - Complexify-ObjC

/**
 * Original code is the implementation at Complexify-ObjC
 * https://github.com/mertdumenci/Complexify-ObjC/blob/master/Complexify-ObjC.m
 */
#define NUMBER_OF_CHARSETS 7
static int charsetsArray[NUMBER_OF_CHARSETS][2] = {
  {0x0030, 0x0039}, // Nubrs
  {0x0041, 0x005A}, // Uppercase
  {0x0061, 0x007A}, // Lowercase
  {0x0021, 0x002F}, // Punctuation
  {0x003A, 0x0040}, // Punctuation
  {0x005B, 0x0060}, // Punctuation
  {0x007B, 0x007E}, // Punctuation
};

- (PWSResult)validate
{
  PWSResult result;
  result.valid = NO;
  result.complexity = 0.0f;
  
  if(!self.password.length){
    return result;
  }
  
  result.complexity += [self additionalComplexityByUniqueChars];
  if(result.complexity < 0.5f){
    return result;
  }
  
  for (NSInteger i = NUMBER_OF_CHARSETS - 1; i >= 0; i--) {
    result.complexity += [self additionalComplexityWithCharset:charsetsArray[i]];
  }
  
  result.complexity = log(pow(result.complexity*100, self.password.length))/100.0f;
  
  result.complexity = (result.complexity > 1.0)? 1.0: result.complexity;
  
  result.valid = (result.complexity > self.validComplexity)? YES: NO;
  
  return result;
}

- (float)additionalComplexityWithCharset:(int[])charset
{
  for (NSInteger i = self.password.length - 1; i >= 0; i--) {
    if (charset[0] <= [self.password characterAtIndex:i] && [self.password characterAtIndex:i] <= charset[1]) {
      return (charset[1] - charset[0]) / 10.0;
    }
  }
  
  return 0;
}

- (float)additionalComplexityByUniqueChars
{
  NSMutableSet *set = [NSMutableSet set];
  [self.password enumerateSubstringsInRange:NSMakeRange(0, self.password.length)
                                    options:NSStringEnumerationByComposedCharacterSequences
                                 usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
    [set addObject:substring];
  }];
  
  return set.count / 10.0;
}

@end
