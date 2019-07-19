cc.Class({
    extends: cc.Component,

    properties: {
        label: {
            default: null,
            type: cc.Label
        },
        // defaults, set visually when attaching this script to the Canvas
        text: 'Hello, World!'
    },

    // use this for initialization
    onLoad: function() {
        this.label.string = this.text;
    },

    // called every frame
    update: function(dt) {

    },

    initialize: function() {
        if (cc.sys.os === cc.sys.OS_ANDROID) {
            jsb.reflection.callStaticMethod("org/cocos2dx/javascript/UnityAdsManager", "UnityAdsInitialize", "(Ljava/lang/String;Z)V", "1742077", false);

        } else if (cc.sys.os === cc.sys.OS_IOS) {
            jsb.reflection.callStaticMethod("UnityAdsManager", "UnityAdsInitialize:testMode:", "1742078", false);
        }

        this.label.string = "Show Interstital!";
    },

    showInterstital: function() {
        if (cc.sys.os === cc.sys.OS_ANDROID) {
            jsb.reflection.callStaticMethod("org/cocos2dx/javascript/UnityAdsManager", "UnityAdsShow", "(Ljava/lang/String;)V", "video");

        } else if (cc.sys.os === cc.sys.OS_IOS) {
            jsb.reflection.callStaticMethod("UnityAdsManager", "UnityAdsShow:", "video");
        }

        this.label.string = "Show Interstital!";
    },

    showRewarded: function() {
        if (cc.sys.os === cc.sys.OS_ANDROID) {
            this.label.string = "Show Rewarded!";
            jsb.reflection.callStaticMethod("org/cocos2dx/javascript/UnityAdsManager", "UnityAdsShow", "(Ljava/lang/String;)V", "rewardedVideo");
        } else if (cc.sys.os === cc.sys.OS_IOS) {
            jsb.reflection.callStaticMethod("UnityAdsManager", "UnityAdsShow:", "rewardedVideo");
        }
    },


    onUnityAdsStart: function(placementId) {
        this.label.string = "Unity Ads Started!";
    },

    onUnityAdsFinish: function(placementId) {
        this.label.string = "Unity Ads Finished!";
    },

});