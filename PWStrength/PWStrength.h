//
//  PWStrength.h
//  PWStrength
//
//  1/7/14.
//
//

#import <Foundation/Foundation.h>

typedef struct _PWSResult {
  BOOL valid;
  float complexity;
} PWSResult;

@interface PWStrength : NSObject

@property(nonatomic, assign) float validComplexity;

+ (PWSResult)validateWithPassword:(NSString *)password;

@end
