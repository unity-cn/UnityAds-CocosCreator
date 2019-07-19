package org.cocos2dx.javascript;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxJavascriptJavaBridge;

import android.app.Activity;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.util.Log;

import com.unity3d.ads.UnityAds;
import com.unity3d.ads.IUnityAdsListener;
import com.unity3d.services.banners.UnityBanners;
import com.unity3d.services.banners.IUnityBannerListener;
import com.unity3d.services.banners.view.BannerPosition;
import com.unity3d.services.core.log.DeviceLog;

public class UnityAdsManager {

    public static Cocos2dxActivity activity;
    public static UnityAdsListener unityAdsListener = new UnityAdsListener();
    public static boolean bannerShown;
    private static View bannerView;

//    public static native void reward(String placementId);

    public static void UnityAdsInitialize(String gameId, boolean testMode) {
        Log.d("Unity cocos2dx Sample", "[UnityAds Demo] UnityAdsInitialize");
        if (gameId == null || gameId.isEmpty()) {
            Log.d("Unity cocos2dx Sample", "[UnityAds Demo] UnityAdsInitialize failed, no gameId specified");
            return;
        }
        UnityBanners.setBannerListener(unityAdsListener);
        UnityAds.initialize(activity, gameId, unityAdsListener, testMode);
    }

    public static boolean UnityAdsIsReady(String placementId) {
        Log.d("Unity cocos2dx Sample", "[UnityAds Demo] UnityAdsIsReady");
        if (placementId == null || placementId.isEmpty()) {
            return UnityAds.isReady();
        }
        return UnityAds.isReady(placementId);
    }

    public static void UnityAdsShow(final String placementId) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (placementId == null || placementId.isEmpty()) {
                    UnityAds.show(activity);
                } else {
                    UnityAds.show(activity, placementId);
                }
            }
        });
    }

    public static void UnityAdsShowBanner(final String placementId) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {

                if (bannerShown) return;
                UnityBanners.setBannerPosition(BannerPosition.BOTTOM_CENTER);
                UnityBanners.loadBanner(activity, placementId);
            }
        });
    }

    public static void UnityAdsHideBanner() {
        if (!bannerShown) return;
        UnityBanners.destroy();
    }

    public static boolean UnityAdsBannerShown(String placementId) {
        return bannerShown;
    }

    // Other methods, excluded methods that are unreasonable to expose to cpp layer

    public static boolean UnityAdsGetDebugMode() {
        Log.d("Unity cocos2dx Sample", "[UnityAds Demo] UnityAdsGetDebugMode");
        return UnityAds.getDebugMode();
    }

    public static String UnityAdsGetPlacementState(String placementId) {
        if (placementId == null || placementId.isEmpty()) {
            return UnityAds.getPlacementState().toString();
        }
        return UnityAds.getPlacementState(placementId).toString();
    }

    public static String UnityAdsGetVersion() {
        return UnityAds.getVersion();
    }

    public static boolean UnityAdsIsInitialized() {
        return UnityAds.isInitialized();
    }

    public static boolean UnityAdsIsSupported() {
        return UnityAds.isSupported();
    }

    public static void UnityAdsSetDebugMode(boolean debugMode) {
        UnityAds.setDebugMode(debugMode);
    }


    private static class UnityAdsListener implements IUnityAdsListener, IUnityBannerListener {
        @Override
        public void onUnityBannerLoaded(String placementId, View view) {

            DeviceLog.debug("[UnityAds Cocos Demo] onUnityBannerLoaded for placement: " + placementId);
            bannerView = view;
            ((ViewGroup) (UnityAdsManager.activity.getWindow().getDecorView().getRootView())).addView(view);

        }

        @Override
        public void onUnityBannerUnloaded(String placementId) {
            DeviceLog.debug("[UnityAds Cocos Demo] onUnityBannerUnloaded for placement: " + placementId);
            bannerView = null;
        }

        @Override
        public void onUnityBannerShow(String placementId) {
            DeviceLog.debug("[UnityAds Cocos Demo] onUnityBannerShow for placement: " + placementId);
            UnityAdsManager.bannerShown = true;
        }

        @Override
        public void onUnityBannerClick(String placementId) {
            DeviceLog.debug("[UnityAds Cocos Demo] onUnityBannerClick for placement: " + placementId);

        }

        @Override
        public void onUnityBannerHide(String placementId) {
            DeviceLog.debug("[UnityAds Cocos Demo] onUnityBannerHide for placement: " + placementId);
            UnityAdsManager.bannerShown = false;
        }

        @Override
        public void onUnityBannerError(String placementId) {
            DeviceLog.debug("[UnityAds Cocos Demo] onUnityBannerError for placement: " + placementId);

        }
        
        @Override
        public void onUnityAdsReady(String placementId){
            Log.d("UnityAds Cocos Demo", "onUnityAdsReady for placement: " + placementId);
        }

        @Override
        public void onUnityAdsStart(final String placementId){
            Log.d("UnityAds Cocos Demo", "onUnityAdsStart for placement: " + placementId);
            activity.runOnGLThread(new Runnable() {
                @Override
                public void run() {
                    Cocos2dxJavascriptJavaBridge.evalString("var hello_world = require('HelloWorld'); hello_world.prototype.onUnityAdsStart(\"" + placementId + "\")");
                }
            });
        }

        @Override
        public void onUnityAdsFinish(String placementId, UnityAds.FinishState state){
            Log.d("UnityAds Cocos Demo", "onUnityAdsFinish for placement: " + placementId + " withState: " + state.toString());
        }

        @Override
        public void onUnityAdsError(UnityAds.UnityAdsError error, String message){
            Log.d("UnityAds Cocos Demo", "UnityAdsError : " + error.toString() + " message: " + message);
        }
    }
}

