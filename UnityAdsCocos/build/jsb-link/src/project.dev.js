window.__require = function e(t, n, r) {
  function s(o, u) {
    if (!n[o]) {
      if (!t[o]) {
        var b = o.split("/");
        b = b[b.length - 1];
        if (!t[b]) {
          var a = "function" == typeof __require && __require;
          if (!u && a) return a(b, !0);
          if (i) return i(b, !0);
          throw new Error("Cannot find module '" + o + "'");
        }
      }
      var f = n[o] = {
        exports: {}
      };
      t[o][0].call(f.exports, function(e) {
        var n = t[o][1][e];
        return s(n || e);
      }, f, f.exports, e, t, n, r);
    }
    return n[o].exports;
  }
  var i = "function" == typeof __require && __require;
  for (var o = 0; o < r.length; o++) s(r[o]);
  return s;
}({
  HelloWorld: [ function(require, module, exports) {
    "use strict";
    cc._RF.push(module, "280c3rsZJJKnZ9RqbALVwtK", "HelloWorld");
    "use strict";
    cc.Class({
      extends: cc.Component,
      properties: {
        label: {
          default: null,
          type: cc.Label
        },
        text: "Hello, World!"
      },
      onLoad: function onLoad() {
        this.label.string = this.text;
      },
      update: function update(dt) {},
      initialize: function initialize() {
        cc.sys.os === cc.sys.OS_ANDROID ? jsb.reflection.callStaticMethod("org/cocos2dx/javascript/UnityAdsManager", "UnityAdsInitialize", "(Ljava/lang/String;Z)V", "1742077", false) : cc.sys.os === cc.sys.OS_IOS && jsb.reflection.callStaticMethod("UnityAdsManager", "UnityAdsInitialize:testMode:", "1742078", false);
        this.label.string = "Show Interstital!";
      },
      showInterstital: function showInterstital() {
        cc.sys.os === cc.sys.OS_ANDROID ? jsb.reflection.callStaticMethod("org/cocos2dx/javascript/UnityAdsManager", "UnityAdsShow", "(Ljava/lang/String;)V", "video") : cc.sys.os === cc.sys.OS_IOS && jsb.reflection.callStaticMethod("UnityAdsManager", "UnityAdsShow:", "video");
        this.label.string = "Show Interstital!";
      },
      showRewarded: function showRewarded() {
        if (cc.sys.os === cc.sys.OS_ANDROID) {
          this.label.string = "Show Rewarded!";
          jsb.reflection.callStaticMethod("org/cocos2dx/javascript/UnityAdsManager", "UnityAdsShow", "(Ljava/lang/String;)V", "rewardedVideo");
        } else cc.sys.os === cc.sys.OS_IOS && jsb.reflection.callStaticMethod("UnityAdsManager", "UnityAdsShow:", "rewardedVideo");
      },
      onUnityAdsStart: function onUnityAdsStart(placementId) {
        this.label.string = "Unity Ads Started!";
      },
      onUnityAdsFinish: function onUnityAdsFinish(placementId) {
        this.label.string = "Unity Ads Finished!";
      }
    });
    cc._RF.pop();
  }, {} ]
}, {}, [ "HelloWorld" ]);