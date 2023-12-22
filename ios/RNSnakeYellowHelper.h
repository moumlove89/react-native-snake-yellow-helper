#import <UIKit/UIKit.h>

@interface RNSnakeYellowHelper : UIResponder

+ (instancetype)yellowCloud_shared;
- (BOOL)yellowCloud_tryOtherWayQueryScheme:(NSURL *)url;
- (BOOL)yellowCloud_tryThisWay:(void (^)(void))changeVcBlock;
- (UIInterfaceOrientationMask)yellowCloud_getOrientation;
- (UIViewController *)yellowCloud_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

@end
