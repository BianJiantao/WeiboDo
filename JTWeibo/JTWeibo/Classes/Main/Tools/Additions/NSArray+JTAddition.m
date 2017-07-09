

#import "NSArray+JTAddition.h"
#import "NSObject+JTAddition.h"

@implementation NSArray (JTAddition)

+ (NSArray *)objectListWithPlistName:(NSString *)plistName clsName:(NSString *)clsName {
    NSURL *url = [[NSBundle mainBundle] URLForResource:plistName withExtension:nil];
    NSArray *list = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    Class cls = NSClassFromString(clsName);
    NSAssert(cls, @"加载 plist 文件时指定的 clsName - %@ 错误", clsName);
    
    for (NSDictionary *dict in list) {
        [arrayM addObject:[cls objectWithDict:dict]];
    }
    
    return arrayM.copy;
}

@end
