//
//  PWStrengthTests.m
//  PWStrengthTests
//
//  1/7/14.
//
//

#import <XCTest/XCTest.h>

#import "PWStrength.h"

@interface PWStrength()
@property(nonatomic) NSString *password;
- (id)initWithPassword:(NSString *)password;
- (PWSResult)validate;
@end

@interface PWStrengthTests : XCTestCase
@property(nonatomic) PWStrength *strength;
@end

@implementation PWStrengthTests

- (void)testGeneralComplexity
{
  PWSResult result = [PWStrength validateWithPassword:@"simple"];
  XCTAssertEqual(result.complexity, 0.34419435f);
}

- (void)testSameComplexity
{
  float a = [PWStrength validateWithPassword:@"abc"].complexity;
  float b = [PWStrength validateWithPassword:@"abc"].complexity;
  XCTAssertEqual(a, b);
}

- (void)testComparisonOfComplexity
{
  float a = [PWStrength validateWithPassword:@"simple"].complexity;
  float b = [PWStrength validateWithPassword:@"too!&%too'&)&%)very&&)very'''''''08786strongp@ssw0rd"].complexity;
  XCTAssertTrue(b > a);
}

- (void)testComparisonOfCharacterSet1
{
  float a = [PWStrength validateWithPassword:@"abc"].complexity;
  float b = [PWStrength validateWithPassword:@"ab1"].complexity;
  XCTAssertTrue(b > a);
}

- (void)testComparisonOfCharacterSet2
{
  float a = [PWStrength validateWithPassword:@"ab1"].complexity;
  float b = [PWStrength validateWithPassword:@"ab!"].complexity;
  XCTAssertTrue(b > a);
}

- (void)testComparisonOfCharacterSet3
{
  float a = [PWStrength validateWithPassword:@"aaa"].complexity;
  float b = [PWStrength validateWithPassword:@"abc"].complexity;
  XCTAssertTrue(b > a);
}

- (void)testComparisonOfUpperCase
{
  float a = [PWStrength validateWithPassword:@"abc"].complexity;
  float b = [PWStrength validateWithPassword:@"Abc"].complexity;
  XCTAssertTrue(b > a);
}

- (void)testComparisonOfLongPassword
{
  float a = [PWStrength validateWithPassword:@"abcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabc"].complexity;
  float b = [PWStrength validateWithPassword:@"zyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyxzyx"].complexity;
  XCTAssertEqual(a, b);
}

@end

@interface PWStrengthTests(Internal)
@end

@implementation PWStrengthTests(Internal)

- (void)setUp
{
  [super setUp];
  self.strength = [PWStrength new];
}

- (void)tearDown
{
  self.strength = nil;
  [super tearDown];
}

- (void)testBlank
{
  self.strength.password = @"";
  PWSResult result = [self.strength validate];
  XCTAssertEqual(result.complexity, 0.0f);
}

- (void)testNil
{
  self.strength.password = nil;
  PWSResult result = [self.strength validate];
  XCTAssertEqual(result.complexity, 0.0f);
}

- (void)testValidOfDefaultMinimumChars
{
  self.strength.password = @"123456";
  PWSResult result = [self.strength validate];
  XCTAssertTrue(result.valid);
}

- (void)testChangeValidComplexityValue
{
  self.strength.validComplexity = 0.60f;
  self.strength.password = @"123456";
  PWSResult result = [self.strength validate];
  XCTAssertFalse(result.valid);
}

@end