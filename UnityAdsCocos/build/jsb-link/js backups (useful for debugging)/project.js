window.__require = function t(i, e, n) {
function r(l, a) {
if (!e[l]) {
if (!i[l]) {
var s = l.split("/");
s = s[s.length - 1];
if (!i[s]) {
var c = "function" == typeof __require && __require;
if (!a && c) return c(s, !0);
if (o) return o(s, !0);
throw new Error("Cannot find module '" + l + "'");
}
}
var u = e[l] = {
exports: {}
};
i[l][0].call(u.exports, function(t) {
return r(i[l][1][t] || t);
}, u, u.exports, t, i, e, n);
}
return e[l].exports;
}
for (var o = "function" == typeof __require && __require, l = 0; l < n.length; l++) r(n[l]);
return r;
}({
HelloWorld: [ function(t, i, e) {
"use strict";
cc._RF.push(i, "280c3rsZJJKnZ9RqbALVwtK", "HelloWorld");
cc.Class({
extends: cc.Component,
properties: {
label: {
default: null,
type: cc.Label
},
text: "Hello, World!"
},
onLoad: function() {
this.label.string = this.text;
},
update: function(t) {},
initialize: function(t) {
if (cc.sys.isMobile) {
null === t && (t = "1742077");
jsb.reflection.callStaticMethod("org/cocos2dx/javascript/UnityAdsManager", "initialize", "(Ljava/lang/String;)V", t);
this.label.string = "Unity Ads Initialize!";
}
},
showInterstital: function(t) {
if (cc.sys.isMobile) {
jsb.reflection.callStaticMethod("org/cocos2dx/javascript/UnityAdsManager", "showInterstitial", "(Ljava/lang/String;)V", t);
this.label.string = "Show Interstital!";
}
},
showRewarded: function(t) {
if (cc.sys.isMobile) {
jsb.reflection.callStaticMethod("org/cocos2dx/javascript/UnityAdsManager", "showRewarded", "(Ljava/lang/String;)V", t);
this.label.string = "Show Rewarded!";
}
}
});
cc._RF.pop();
}, {} ]
}, {}, [ "HelloWorld" ]);