//
//  UnityAdsManager.m
//  hello_world-mobile
//
//  Created by Callie on 2019/7/19.
//

#import "UnityAdsManager.h"
#import "AppController.h"

static BOOL bannerShown = NO;

@implementation UnityAdsManager

+ (UIViewController* ) viewController {
    
    UIApplication* app = [UIApplication sharedApplication];
    AppController* controller = (AppController*)[app delegate];
    UIViewController* rootController = [controller.window rootViewController];
    return rootController;
}

+ (id)sharedUnityAdsManager {
    static UnityAdsManager *sharedUnityAdsManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUnityAdsManager = [[self alloc] init];
    });
    return sharedUnityAdsManager;
}

- (void)unityAdsDidError:(UnityAdsError)error withMessage:(nonnull NSString *)message {
    NSLog(@"[UnityAds] unityAdsDidError error:%ld , message:%@ ", (long)error, message);
}

- (void)unityAdsDidFinish:(nonnull NSString *)placementId withFinishState:(UnityAdsFinishState)state {
    
    NSLog(@"[UnityAds] unityAdsDidFinish placementId:%@ , withFinishState:%ld ", placementId, (long)state);
}

- (void)unityAdsDidStart:(nonnull NSString *)placementId {
    
    NSLog(@"[UnityAds] unityAdsDidStart placementId:%@ ", placementId);
}

- (void)unityAdsReady:(nonnull NSString *)placementId {
    
    NSLog(@"[UnityAds] unityAdsReady placementId:%@ ", placementId);
}

- (void)unityAdsBannerDidClick:(nonnull NSString *)placementId {
    
    NSLog(@"[UnityAds] unityAdsBannerDidClick placementId:%@ ", placementId);
}

- (void)unityAdsBannerDidError:(nonnull NSString *)message {
    NSLog(@"[UnityAds] unityAdsBannerDidError message:%@ ", message);
}

- (void)unityAdsBannerDidHide:(nonnull NSString *)placementId {
    
    NSLog(@"[UnityAds] unityAdsBannerDidHide placementId:%@ ", placementId);
}

- (void)unityAdsBannerDidLoad:(nonnull NSString *)placementId view:(nonnull UIView *)view {
    
    NSLog(@"[UnityAds] unityAdsBannerDidLoad placementId:%@ ", placementId);
}

- (void)unityAdsBannerDidShow:(nonnull NSString *)placementId {
    
    NSLog(@"[UnityAds] unityAdsBannerDidShow placementId:%@ ", placementId);
}

- (void)unityAdsBannerDidUnload:(nonnull NSString *)placementId {
    
    NSLog(@"[UnityAds] unityAdsBannerDidUnload placementId:%@ ", placementId);
}

+(void)UnityAdsInitialize:(NSString *)gameId testMode:(BOOL)testMode{
    NSLog(@"[UnityAds] UnityAdsInit");
    
    UnityAdsManager* bridge = [UnityAdsManager sharedUnityAdsManager];
//    NSString* gameID = [NSString stringWithFormat:@"%@", gameId];
    [UnityAdsBanner setDelegate:bridge];
    [UnityAds initialize:gameId delegate:bridge testMode:testMode];
}
+(BOOL)UnityAdsIsReady:(NSString *)placementId{
//    NSString* placementId = [NSString stringWithFormat:@"%s", parameter];
    bool isReady = [UnityAds isReady:placementId];
    NSLog(@"[UnityAds] UnityAdsIsReady for placement=%@ readyState=%@", placementId, isReady?@"True":@"False");
    return isReady;
}

+(void)UnityAdsShow:(NSString *)placementId{
    if([UnityAds isReady:placementId])
    {
        [UnityAds show:[UnityAdsManager viewController] placementId:placementId];
        
        NSLog(@"[UnityAds] UnityAdsShow for placement=%@ ", placementId);
    }else
    {
        
        NSLog(@"[UnityAds] UnityAds show failed! Placement is Not Ready for placement=%@ ", placementId);
    }
    
}
+(void)UnityAdsShowBanner:(NSString *)placementId{
    [UnityAdsBanner loadBanner:placementId];
}
+(void)UnityAdsHideBanner{
    [UnityAdsBanner destroy];
}

+(BOOL)UnityAdsBannerShown:(NSString *)placementId{
    return bannerShown;
}
+(BOOL)UnityAdsGetDebugMode{
    NSLog(@"[UnityServices] UnityAdsGetDebugMode");
    return [UnityServices getDebugMode];
}
+(NSString *)UnityAdsGetPlacementState:(NSString *)placementId{
    NSLog(@"[UnityMonetization] UnityAdsGetPlacementState");
    UnityAdsPlacementState state = [UnityAds getPlacementState:placementId];
    switch(state){
        case kUnityAdsPlacementStateReady:
        return @"kUnityAdsPlacementStateReady";
        case kUnityAdsPlacementStateNoFill:
        return @"kUnityAdsPlacementStateNoFill";
        case kUnityAdsPlacementStateWaiting:
        return @"kUnityAdsPlacementStateWaiting";
        case kUnityAdsPlacementStateDisabled:
        return @"kUnityAdsPlacementStateDisabled";
        case kUnityAdsPlacementStateNotAvailable:
        return @"kUnityAdsPlacementStateNotAvailable";
    }
}

+(NSString *)UnityAdsGetVersion{
    NSLog(@"[UnityServices] UnityAdsGetVersion");
    NSString * ret = [UnityServices getVersion];
    return ret;
}

+(BOOL)UnityAdsIsInitialized{
    NSLog(@"[UnityServices] UnityAdsIsInitialized");
    return [UnityServices isInitialized];
}
+(BOOL)UnityAdsIsSupported{
    NSLog(@"[UnityServices] UnityAdsIsSupported");
    return [UnityServices isSupported];
}
+(void)UnityAdsSetDebugMode:(BOOL)debugMode{
    NSLog(@"[UnityServices] UnityAdsSetDebugMode");
    [UnityServices setDebugMode:debugMode];
}


@end

//#pragma Unity Ads Manager
//
//void UnityAdsInitialize(const char *gameIdParameter, bool testMode){
//    NSLog(@"[UnityMonetization] UnityAdsInit");
//
//    UnityAdsManager* bridge = [UnityAdsManager sharedUnityAdsManager];
//    NSString* gameId = [NSString stringWithFormat:@"%s", gameIdParameter];
//    [UnityAdsBanner setDelegate:bridge];
//    [UnityAds initialize:gameId delegate:bridge testMode:testMode];
//}
//
//
//bool UnityAdsIsReady(const char *placementId){
//
//}
//
//void UnityAdsShow(const char *placementId){
//
//}
//
//void UnityAdsShowBanner(const char *placementId){
//
//}
//
//void UnityAdsHideBanner(){
//
//}
//
//bool UnityAdsBannerShown(const char *placementId){
//
//}
//
//bool UnityAdsGetDebugMode(){
//
//}
//
//std::string UnityAdsGetPlacementState(const char *placementId){
//
//}
//
//+(NSString *)UnityAdsGetVersion;
//+(BOOL)UnityAdsIsInitialized;
//+(BOOL)UnityAdsIsSupported;
//+(void)UnityAdsSetDebugMode:(BOOL)debugMode;
