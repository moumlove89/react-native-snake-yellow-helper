#import "RNSnakeYellowHelper.h"

#import <RNSnakeUM/RNSnakeUM.h>
#import <RNSnakeEngine/RNSnakeEngine.h>
#import <RNSnakeInfo/RNSnakeInfo.h>
#import <TInstallSDK/TInstallSDK.h>
#import <react-native-orientation-locker/Orientation.h>

@implementation RNSnakeYellowHelper

static RNSnakeYellowHelper *instance = nil;

+ (instancetype)yellowCloud_shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (UIInterfaceOrientationMask)yellowCloud_getOrientation {
    return [Orientation getOrientation];
}

- (BOOL)yellowCloud_tryOtherWayQueryScheme:(NSURL *)url {
    if ([[url scheme] containsString:@"myapp"]) {
        NSDictionary *queryParams = [[RNSnakeInfo shared] dictFromQueryString:[url query]];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:queryParams forKey:@"queryParams"];
        
        NSString *paramValue = queryParams[@"paramName"];
        if ([paramValue isEqualToString:@"IT6666"]) {
            [[RNSnakeInfo shared] saveValueForAff:nil];
            return YES;
        }
    }
    return NO;
}

- (BOOL)yellowCloud_tryThisWay:(void (^)(void))changeVcBlock {
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [[RNSnakeInfo shared] saveValueForAff:nil];
    if ([ud boolForKey:[[RNSnakeInfo shared] getBundleId]]) {
        return YES;
    } else {
        [self yellowCloud_initInstallWithVcBlock:changeVcBlock];
        return NO;
    }
}

- (void)yellowCloud_initInstallWithVcBlock:(void (^)(void))changeVcBlock {
  [TInstall initInstall:[[RNSnakeInfo shared] getValueFromKey:@"tInstall"]
                 setHost:[[RNSnakeInfo shared] getValueFromKey:@"tInstallHost"]];
    
  [TInstall getWithInstallResult:^(NSDictionary * _Nullable data) {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:[data objectForKey:@"raf"] forKey:@"raf"];
      
    NSString * _Nullable affC = [data valueForKey:@"affCode"];
    if (affC.length == 0) {
        affC = [data valueForKey:@"affcode"];
      if (affC.length == 0) {
          affC = [data valueForKey:@"aff"];
      }
    }
    if (affC.length != 0) {
        [[RNSnakeInfo shared] saveValueForAff:affC];
        changeVcBlock();
    }
  }];
}

- (UIViewController *)yellowCloud_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    UIViewController *rootViewController = [[RNSnakeEngine shared] changeRootController:application withOptions:launchOptions];
    [[RNSnakeUM shared] setUMengKey:[[RNSnakeInfo shared] getValueFromKey:@"uMengAppKey"]
                            umChannel:[[RNSnakeInfo shared] getValueFromKey:@"uMengAppChannel"]
                          withOptions:launchOptions];
    return rootViewController;
}


@end
