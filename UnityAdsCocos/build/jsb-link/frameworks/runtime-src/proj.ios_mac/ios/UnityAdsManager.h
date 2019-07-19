//
//  UnityAdsManager.h
//  hello_world-mobile
//
//  Created by Callie on 2019/7/19.
//

#import <Foundation/Foundation.h>
#import <UnityAds/UnityAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnityAdsManager : NSObject<UnityAdsDelegate, UnityAdsBannerDelegate>

+(UIViewController *) viewController;
+(id)sharedUnityAdsManager;
@property(strong, nonatomic) UIView *bannerView;

+(void)UnityAdsInitialize:(NSString *)gameId testMode:(BOOL)testMode;
+(void)UnityAdsShow:(NSString *)placementId;
+(BOOL)UnityAdsIsReady:(NSString *)placementId;
+(void)UnityAdsShowBanner:(NSString *)placementId;
+(void)UnityAdsHideBanner;
+(BOOL)UnityAdsBannerShown:(NSString *)placementId;
+(BOOL)UnityAdsGetDebugMode;
+(NSString *)UnityAdsGetPlacementState:(NSString *)placementId;
+(NSString *)UnityAdsGetVersion;
+(BOOL)UnityAdsIsInitialized;
+(BOOL)UnityAdsIsSupported;
+(void)UnityAdsSetDebugMode:(BOOL)debugMode;

@end

NS_ASSUME_NONNULL_END
