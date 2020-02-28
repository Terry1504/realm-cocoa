////////////////////////////////////////////////////////////////////////////
//
// Copyright 2014 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#import "RLMTestObjects.h"
#import <Realm/RLMObject_Private.h>

#pragma mark - Abstract Objects
#pragma mark -

#pragma mark OneTypeObjects

@implementation StringObject
@end

@implementation IntObject
@end

@implementation AllIntSizesObject
@end

@implementation FloatObject
@end

@implementation DoubleObject
@end

@implementation BoolObject
@end

@implementation DateObject
@end

@implementation BinaryObject
@end

@implementation DecimalObject
@end

@implementation UTF8Object
@end

@implementation IndexedStringObject
+ (NSArray *)indexedProperties {
    return @[@"stringCol"];
}
@end

@implementation LinkStringObject
@end

@implementation LinkIndexedStringObject
@end

@implementation RequiredPropertiesObject
+ (NSArray *)requiredProperties {
    return @[@"stringCol", @"binaryCol"];
}
@end

@implementation IgnoredURLObject
+ (NSArray *)ignoredProperties {
    return @[@"url"];
}
@end

@implementation EmbeddedIntObject
@end

#pragma mark AllTypesObject

@implementation AllTypesObject
+ (NSDictionary *)linkingObjectsProperties {
    return @{@"linkingObjectsCol": [RLMPropertyDescriptor descriptorWithClass:LinkToAllTypesObject.class propertyName:@"allTypesCol"]};
}

+ (NSArray *)requiredProperties {
    return @[@"stringCol", @"dateCol", @"binaryCol", @"decimalCol", @"objectIdCol"];
}

+ (NSDictionary *)values:(int)i stringObject:(StringObject *)so {
    char str[] = "a";
    str[0] += i - 1;
    return @{
        @"boolCol": @(i % 2),
        @"cBoolCol": @(i % 2),
        @"intCol": @(i),
        @"floatCol": @(1.1f * i),
        @"doubleCol": @(1.11 * i),
        @"stringCol": @(str),
        @"binaryCol": [@(str) dataUsingEncoding:NSUTF8StringEncoding],
        @"dateCol": [NSDate dateWithTimeIntervalSince1970:i],
        @"longCol": @((long long)i * INT_MAX + 1),
        @"decimalCol": [[RLMDecimal128 alloc] initWithNumber:@(i)],
        @"objectIdCol": [RLMObjectId objectId],
        @"objectCol": so ?: NSNull.null,
    };
}
@end

@implementation ArrayOfAllTypesObject
@end

@implementation LinkToAllTypesObject
@end

@implementation AllOptionalTypes
@end
@implementation AllPrimitiveArrays
+ (NSArray *)requiredProperties {
    return @[@"intObj", @"floatObj", @"doubleObj", @"boolObj", @"stringObj",
             @"dateObj", @"dataObj", @"decimalObj", @"objectIdObj"];
}
@end
@implementation AllOptionalPrimitiveArrays
@end

@implementation AllOptionalTypesPK
+ (NSString *)primaryKey {
    return @"pk";
}
+ (NSDictionary *)defaultPropertyValues {
    return @{@"pk": NSUUID.UUID.UUIDString};
}
@end

#pragma mark - Real Life Objects
#pragma mark -

#pragma mark EmployeeObject

@implementation EmployeeObject
@end

#pragma mark CompanyObject

@implementation CompanyObject
@end

@implementation PrimaryEmployeeObject
+ (NSString *)primaryKey {
    return @"name";
}
@end

@implementation LinkToPrimaryEmployeeObject
@end

@implementation PrimaryCompanyObject
+ (NSString *)primaryKey {
    return @"name";
}
@end

@implementation ArrayOfPrimaryCompanies
@end

#pragma mark LinkToCompanyObject

@implementation LinkToCompanyObject
@end

#pragma mark DogObject

@class OwnerObject;

@implementation DogObject
+ (NSDictionary *)linkingObjectsProperties
{
    return @{ @"owners": [RLMPropertyDescriptor descriptorWithClass:OwnerObject.class propertyName:@"dog"] };
}
@end

#pragma mark OwnerObject

@implementation OwnerObject

- (BOOL)isEqual:(id)other
{
    return [self isEqualToObject:other];
}

@end

#pragma mark - Specific Use Objects
#pragma mark -

#pragma mark CustomAccessorsObject

@implementation CustomAccessorsObject
@end

#pragma mark BaseClassStringObject

@implementation BaseClassStringObject
@end

#pragma mark CircleObject

@implementation CircleObject
@end

#pragma mark CircleArrayObject

@implementation CircleArrayObject
@end

#pragma mark ArrayPropertyObject

@implementation ArrayPropertyObject
@end

#pragma mark DynamicTestObject

@implementation DynamicTestObject
@end

#pragma mark AggregateObject

@implementation AggregateObject
@end
@implementation AggregateArrayObject
@end

#pragma mark PrimaryStringObject

@implementation PrimaryStringObject
+ (NSString *)primaryKey {
    return @"stringCol";
}
+ (NSArray *)requiredProperties {
    return @[@"stringCol"];
}
@end

@implementation PrimaryNullableStringObject
+ (NSString *)primaryKey {
    return @"stringCol";
}
@end

@implementation PrimaryIntObject
+ (NSString *)primaryKey {
    return @"intCol";
}
@end

@implementation PrimaryInt64Object
+ (NSString *)primaryKey {
    return @"int64Col";
}
@end

@implementation PrimaryNullableIntObject
+ (NSString *)primaryKey {
    return @"optIntCol";
}
@end


#pragma mark ReadOnlyPropertyObject

@interface ReadOnlyPropertyObject ()
@property (readwrite) int readOnlyPropertyMadeReadWriteInClassExtension;
@end

@implementation ReadOnlyPropertyObject
- (NSNumber *)readOnlyUnsupportedProperty {
    return nil;
}
@end

#pragma mark IntegerArrayPropertyObject

@implementation IntegerArrayPropertyObject
@end

@implementation NumberObject
@end

@implementation NumberDefaultsObject
+ (NSDictionary *)defaultPropertyValues {
    return @{@"intObj" : @1,
             @"floatObj" : @2.2f,
             @"doubleObj" : @3.3,
             @"boolObj" : @NO};
}
@end

@implementation RequiredNumberObject
+ (NSArray *)requiredProperties {
    return @[@"intObj", @"floatObj", @"doubleObj", @"boolObj"];
}
@end

#pragma mark CustomInitializerObject

@implementation CustomInitializerObject

- (instancetype)init {
    self = [super init];
    if (self) {
        self.stringCol = @"test";
    }
    return self;
}

@end

#pragma mark AbstractObject

@implementation AbstractObject
@end

#pragma mark PersonObject

@implementation PersonObject

+ (NSDictionary *)linkingObjectsProperties
{
    return @{ @"parents": [RLMPropertyDescriptor descriptorWithClass:PersonObject.class propertyName:@"children"] };
}

- (BOOL)isEqual:(id)other
{
    if (![other isKindOfClass:[PersonObject class]]) {
        return NO;
    }

    PersonObject *otherPerson = other;
    return [self.name isEqual:otherPerson.name] && self.age == otherPerson.age && [self.children isEqual:otherPerson.children];
}

@end

@implementation RenamedProperties1
+ (NSString *)_realmObjectName {
    return @"Renamed Properties";
}
+ (NSDictionary *)_realmColumnNames {
    return @{@"propA": @"prop 1",
             @"propB": @"prop 2"};
}
+ (NSDictionary *)linkingObjectsProperties {
    return @{@"linking1": [RLMPropertyDescriptor descriptorWithClass:LinkToRenamedProperties1.class propertyName:@"linkA"],
             @"linking2": [RLMPropertyDescriptor descriptorWithClass:LinkToRenamedProperties2.class propertyName:@"linkD"]};
}
@end

@implementation RenamedProperties2
+ (NSString *)_realmObjectName {
    return @"Renamed Properties";
}
+ (NSDictionary *)_realmColumnNames {
    return @{@"propC": @"prop 1",
             @"propD": @"prop 2"};
}
+ (NSDictionary *)linkingObjectsProperties {
    return @{@"linking1": [RLMPropertyDescriptor descriptorWithClass:LinkToRenamedProperties1.class propertyName:@"linkA"],
             @"linking2": [RLMPropertyDescriptor descriptorWithClass:LinkToRenamedProperties2.class propertyName:@"linkD"]};
}
@end

@implementation LinkToRenamedProperties1
+ (NSString *)_realmObjectName {
    return @"Link To Renamed Properties";
}
+ (NSDictionary *)_realmColumnNames {
    return @{@"linkA": @"Link A",
             @"linkB": @"Link B"};
}
@end

@implementation LinkToRenamedProperties2
+ (NSString *)_realmObjectName {
    return @"Link To Renamed Properties";
}
+ (NSDictionary *)_realmColumnNames {
    return @{@"linkC": @"Link A",
             @"linkD": @"Link B"};
}
@end

@implementation RenamedPrimaryKey
+ (NSString *)primaryKey {
    return @"pk";
}
+ (NSDictionary *)_realmColumnNames {
    return @{@"pk": @"Primary Key",
             @"value": @"Value"};
}
@end

#pragma mark FakeObject

@implementation FakeObject
+ (bool)_realmIgnoreClass { return true; }
@end

@implementation FakeEmbeddedObject
+ (bool)_realmIgnoreClass { return true; }
@end

#pragma mark ComputedPropertyNotExplicitlyIgnoredObject

@implementation ComputedPropertyNotExplicitlyIgnoredObject

- (NSURL *)URL {
    return [NSURL URLWithString:self._URLBacking];
}

- (void)setURL:(NSURL *)URL {
    self._URLBacking = URL.absoluteString;
}

@end
