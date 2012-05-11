//
//  SkinTest.m
//  UsefulTests
//
//  Created by Kevin O'Neill on 11/12/11.
//

#import <GHUnitIOS/GHUnit.h>

#import <UsefulBits/Skin.h>
#import <UsefulBits/UIColor+Hex.h>


@interface SkinTest : GHTestCase
@end

@implementation SkinTest

- (void)testLoadSkin
{
  Skin *skin = [Skin skin];

  GHAssertNotNil(skin, @"failed to create skin");
}

#pragma mark - Properties

- (void)testLoadsStringProperty
{
  Skin *skin = [Skin skin];
  id value = [skin propertyNamed:@"string"];

  GHAssertNotNil(value, @"should have provided a value");
  GHAssertTrue([value isKindOfClass:[NSString class]], @"expected an instance of NSString");
  GHAssertEqualStrings(@"a string", value, nil);
}

- (void)testLoadsNumberProperty
{
  Skin *skin = [Skin skin];
  id value = [skin propertyNamed:@"number"];

  GHAssertNotNil(value, @"should have provided a value");
  GHAssertTrue([value isKindOfClass:[NSNumber class]], @"expected an instance of NSNumber");
  GHAssertEqualObjects([NSNumber numberWithInteger:42], value, nil);
}

- (void)testLoadsNilForMissingProperty
{
  Skin *skin = [Skin skin];
  id value = [skin propertyNamed:@"missing"];

  GHAssertNil(value, @"should not have provided a value");
}

- (void)testReferenceToNumberProperty
{
  Skin *skin = [Skin skin];
  id value = [skin propertyNamed:@"number-reference"];

  GHAssertNotNil(value, @"should have provided a value");
  GHAssertTrue([value isKindOfClass:[NSNumber class]], @"expected an instance of NSNumber");
  GHAssertEqualObjects([NSNumber numberWithInteger:42], value, nil);
}

#pragma mark - References

- (void)testResolvesCompoundFontLocalReference
{
  Skin *skin = [Skin skin];
  UIFont *font = [skin fontNamed:@"local-reference"];

  GHAssertNotNil(font, @"local-reference not loaded");
  GHAssertEquals(13.f, [font pointSize], @"expected the font to be 12pt");
  GHAssertEqualStrings(@"Helvetica-Bold", [font fontName], @"expected helvetica bold");
}

#pragma mark - Colors

- (void)testResolvesMissingColor
{
  Skin *skin = [Skin skin];
  UIColor *missing = [skin colorNamed:@"missing"];

  GHAssertNotNil(missing, @"should have provided default color");
  GHAssertEqualObjects([UIColor cyanColor], missing, @"missing should be cyan");
}

- (void)testResolvesHexColor
{
  Skin *skin = [Skin skin];
  UIColor *grey = [skin colorNamed:@"grey"];

  GHAssertNotNil(grey, @"should have provided grey");
  GHAssertEqualObjects([UIColor colorWithHex:0x7f7f7f], grey, @"should be grey");
}

- (void)testResolvesPatternColor
{
  Skin *skin = [Skin skin];
  UIColor *pattern = [skin colorNamed:@"pattern"];

  GHAssertNotNil(pattern, @"should created pattern color");
  GHAssertNotEqualObjects([UIColor cyanColor], pattern, @"pattern should not be cyan");
}

- (void)testResolvesReferenceColor
{
  Skin *skin = [Skin skin];
  UIColor *grey = [skin colorNamed:@"default-color"];

  GHAssertNotNil(grey, @"should have resolved to grey");
  GHAssertEqualObjects([UIColor colorWithHex:0x7f7f7f], grey, @"should be grey");
}

- (void)testResolvesMultiReferenceColor
{
  Skin *skin = [Skin skin];
  UIColor *grey = [skin colorNamed:@"reference-to-reference"];

  GHAssertNotNil(grey, @"should have resolved to grey");
  GHAssertEqualObjects([UIColor colorWithHex:0x7f7f7f], grey, @"should be grey");
}

#pragma mark - Images

- (void)testResolvesImages
{
  Skin *skin = [Skin skin];
  UIImage *image = [skin imageNamed:@"background"];

  GHAssertNotNil(image, @"should have provided image");
}

- (void)testResolvesStretchableImages
{
  Skin *skin = [Skin skin];
  UIImage *image = [skin imageNamed:@"stretchable"];

  GHAssertNotNil(image, @"should have provided image");
  GHAssertEquals([image leftCapWidth], 5, @"incorrect horizontal cap");
  GHAssertEquals([image topCapHeight], 7, @"incorrect vertical cap");
}


- (void)testResolvesReferenceStretchableImages
{
  Skin *skin = [Skin skin];
  UIImage *image = [skin imageNamed:@"stretchable-reference"];

  GHAssertNotNil(image, @"should have provided image");
  GHAssertEquals([image leftCapWidth], 5, @"incorrect horizontal cap");
  GHAssertEquals([image topCapHeight], 7, @"incorrect vertical cap");
}

- (void)testResolvesNilForMissingImages
{
  Skin *skin = [Skin skin];
  UIImage *image = [skin imageNamed:@"missing"];

  GHAssertNil(image, @"should not have provided image");
}

#pragma mark - Fonts

- (void)testResolvesSystemFont
{
  Skin *skin = [Skin skin];
  UIFont *font = [skin fontNamed:@"base-font"];

  GHAssertNotNil(font, @"base-font not loaded");
  GHAssertEquals(14.f, [font pointSize], @"expected the font to be 14pt");
}

- (void)testResolvesBoldFont
{
  Skin *skin = [Skin skin];
  UIFont *font = [skin fontNamed:@"bold-font"];

  GHAssertNotNil(font, @"bold-font not loaded");
  GHAssertEquals(14.f, [font pointSize], @"expected the font to be 14pt");
  GHAssertEqualStrings(@"Helvetica-Bold", [font fontName], @"expected helvetica bold");
}

- (void)testResolvesConfiguredFont
{
  Skin *skin = [Skin skin];
  UIFont *font = [skin fontNamed:@"system-font-italic"];

  GHAssertNotNil(font, @"system-font-italic not loaded");
  GHAssertEquals(11.f, [font pointSize], @"expected the font to be 11pt");
}

#pragma mark - Unresolved References

- (void)testUnresolvePropertyReferencesAreNil
{
  Skin *skin = [Skin skinForSection:@"unresolved"];
  id unresolved_value = [skin propertyNamed:@"unresolved"];
  
  GHAssertNil(unresolved_value, @"unresolved values should be nil");
}

- (void)testUnresolveColorReferencesAreCyan
{
  Skin *skin = [Skin skinForSection:@"unresolved"];
  id unresolved_value = [skin colorNamed:@"unresolved"];
  
  GHAssertNotNil(unresolved_value, @"unresolved values should	not be nil");
  GHAssertEquals(unresolved_value, [UIColor cyanColor], @"unresolved values should be cyanpo");
}

- (void)testUnresolveImageReferencesAreNil
{
  Skin *skin = [Skin skinForSection:@"unresolved"];
  id unresolved_value = [skin imageNamed:@"unresolved"];
  
  GHAssertNil(unresolved_value, @"unresolved values should be nil");
}

- (void)testUnresolveFontReferencesAreNil
{
  Skin *skin = [Skin skinForSection:@"unresolved"];
  id unresolved_value = [skin fontNamed:@"unresolved"];
  
  GHAssertNil(unresolved_value, @"unresolved values should be nil");
}

#pragma mark - Broken

- (void)testBrokenThrows
{
  GHAssertThrows([Skin skinForSection:@"broken-section"], @"should have detected recursion");
}

#pragma mark - Inheritence

- (void)testOverridesStringProperty
{
  Skin *skin = [Skin skinForSection:@"subsection"];
  id value = [skin propertyNamed:@"string"];

  GHAssertNotNil(value, @"should have provided a value");
  GHAssertTrue([value isKindOfClass:[NSString class]], @"expected an instance of NSString");
  GHAssertEqualStrings(@"a new string", value, nil);
}

- (void)testReferenceParentProperty
{
  Skin *skin = [Skin skinForSection:@"subsection"];
  UIColor *grey = [skin colorNamed:@"parent-reference-color"];

  GHAssertNotNil(grey, @"should have provided grey");
  GHAssertEqualObjects([UIColor colorWithHex:0x7f7f7f], grey, @"should be grey");
}

- (void)testResolvesSectionPatternColors
{
  Skin *skin = [Skin skinForSection:@"subsection"];
  UIColor *pattern = [skin colorNamed:@"pattern"];

  GHAssertNotNil(pattern, @"should have provided pattern");
  GHAssertNotEqualObjects([UIColor cyanColor], pattern, @"should be pattern");
}

- (void)testResolvesSectionImages
{
  Skin *skin = [Skin skinForSection:@"subsection"];
  UIImage *image = [skin imageNamed:@"sub-image"];

  GHAssertNotNil(image, @"should have provided image");
}

- (void)testResolvesInheritedImages
{
  Skin *skin = [Skin skinForSection:@"subsection"];
  UIImage *image = [skin imageNamed:@"background"];

  GHAssertNotNil(image, @"should have provided image");
}

- (void)testResolvesInheritedStretchableImages
{
  Skin *skin = [Skin skinForSection:@"subsection"];
  UIImage *image = [skin imageNamed:@"subsection-stretchable-reference"];

  GHAssertNotNil(image, @"should have provided image");
  GHAssertEquals([image leftCapWidth], 5, @"incorrect horizontal cap");
  GHAssertEquals([image topCapHeight], 7, @"incorrect vertical cap");
}

- (void)testMergedSectionsOveride
{
  Skin *skin = [[Skin skinForSection:@"subsection"] merge:[Skin skinForSection:@"merge-me"]];
  
  id value = [skin propertyNamed:@"string"];
  
  GHAssertNotNil(value, @"should have provided a value");
  GHAssertTrue([value isKindOfClass:[NSString class]], @"expected an instance of NSString");
  GHAssertEqualStrings(@"a merged string", value, nil);
}

- (void)testMergedSectionsResolveOutstandingReferences
{
  Skin *base = [Skin skinForSection:@"subsection"];
  Skin *skin = [base merge:[Skin skinForSection:@"merge-me"]];
  
  id unresolved_value = [base propertyNamed:@"unresolved"];
  id resolved_value = [skin propertyNamed:@"unresolved"];

  GHAssertNil(unresolved_value, @"unresolved values should be nil");
  GHAssertNotNil(resolved_value, @"should have provided a value");
  GHAssertTrue([resolved_value isKindOfClass:[NSString class]], @"expected an instance of NSString");
  GHAssertEqualStrings(@"no i'm not", resolved_value, nil);
}

- (void)testUnresolvedReferencesAreNil
{

}

@end
