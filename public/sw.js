if(!self.define){let e,s={};const i=(i,n)=>(i=new URL(i+".js",n).href,s[i]||new Promise((s=>{if("document"in self){const e=document.createElement("script");e.src=i,e.onload=s,document.head.appendChild(e)}else e=i,importScripts(i),s()})).then((()=>{let e=s[i];if(!e)throw new Error(`Module ${i} didn’t register its module`);return e})));self.define=(n,a)=>{const c=e||("document"in self?document.currentScript.src:"")||location.href;if(s[c])return;let r={};const o=e=>i(e,c),t={module:{uri:c},exports:r,require:o};s[c]=Promise.all(n.map((e=>t[e]||o(e)))).then((e=>(a(...e),r)))}}define(["./workbox-588899ac"],(function(e){"use strict";importScripts(),self.skipWaiting(),e.clientsClaim(),e.precacheAndRoute([{url:"/_next/static/chunks/117-49deaf96f16728b8.js",revision:"49deaf96f16728b8"},{url:"/_next/static/chunks/132-8a1a7959ee8744aa.js",revision:"8a1a7959ee8744aa"},{url:"/_next/static/chunks/420-557ff6eb6c05d4ca.js",revision:"557ff6eb6c05d4ca"},{url:"/_next/static/chunks/framework-2c79e2a64abdb08b.js",revision:"2c79e2a64abdb08b"},{url:"/_next/static/chunks/main-f044560c7a838c55.js",revision:"f044560c7a838c55"},{url:"/_next/static/chunks/pages/_app-ec45ff5270447aee.js",revision:"ec45ff5270447aee"},{url:"/_next/static/chunks/pages/_error-54de1933a164a1ff.js",revision:"54de1933a164a1ff"},{url:"/_next/static/chunks/pages/about-3b4786879aaeb2cf.js",revision:"3b4786879aaeb2cf"},{url:"/_next/static/chunks/pages/exercises-832aacc68b5c684c.js",revision:"832aacc68b5c684c"},{url:"/_next/static/chunks/pages/exercises/%5BexerciseId%5D-45844cefd0ff6b3c.js",revision:"45844cefd0ff6b3c"},{url:"/_next/static/chunks/pages/index-2df6a3f1f746b76a.js",revision:"2df6a3f1f746b76a"},{url:"/_next/static/chunks/pages/settings-ced355e38c4ba0ab.js",revision:"ced355e38c4ba0ab"},{url:"/_next/static/chunks/polyfills-c67a75d1b6f99dc8.js",revision:"837c0df77fd5009c9e46d446188ecfd0"},{url:"/_next/static/chunks/webpack-8fa1640cc84ba8fe.js",revision:"8fa1640cc84ba8fe"},{url:"/_next/static/css/77e13d565a160697.css",revision:"77e13d565a160697"},{url:"/_next/static/moHvdTsORbiMvSU188lha/_buildManifest.js",revision:"a20e4377b56aef7bee30e0629287d059"},{url:"/_next/static/moHvdTsORbiMvSU188lha/_ssgManifest.js",revision:"b6652df95db52feb4daf4eca35380933"},{url:"/favicon.ico",revision:"3a9129f4b858e4bf7c892805eb1ef60b"},{url:"/icons/favicon.png",revision:"4fff0dc9ec4d2aecb24a1f4f2ca48753"},{url:"/icons/mushroom-144.png",revision:"f14869022d3abd5b792b5e29408b38ca"},{url:"/icons/mushroom-192.png",revision:"d905a768339f17551a368fff2e2403cf"},{url:"/icons/mushroom-256.png",revision:"40b5b39df2f96078bd2cf5593ce9f28b"},{url:"/icons/mushroom-32.png",revision:"64286faa24b15c99c902ec6237e4fba4"},{url:"/icons/mushroom-36.png",revision:"d6450ab23dcb0cb5cbf3f664e2d2facc"},{url:"/icons/mushroom-384.png",revision:"bfbed75279333115b72508a2f4fe918c"},{url:"/icons/mushroom-48.png",revision:"fbfa1561fc795ec6346536bfeebedd6e"},{url:"/icons/mushroom-512.png",revision:"ac3c23b1a3d9c06fdf8c7d2b72c20b96"},{url:"/icons/mushroom-72.png",revision:"813483d8db655a7d6a01ce06ebe7e52b"},{url:"/icons/mushroom-96.png",revision:"e2fd57f6d85ea3b79d368e74877bae87"},{url:"/img/champignon.png",revision:"0d4a52909d2dabf5799045bafbd1f397"},{url:"/img/empty-star.png",revision:"7ece07951b47ecf13e32632b3b6339a0"},{url:"/img/ep_naturalwhite.png",revision:"110a9bd244348e59bb22d05153184c8a"},{url:"/img/flat.png",revision:"3e6b29d2ed34d31a9ed18bb76c033ac1"},{url:"/img/green-champignon.png",revision:"a057155f55df21c5ee79992d79bd6591"},{url:"/img/green-log.png",revision:"8691b9ce00c588c54b09c9533c1937f4"},{url:"/img/green-mushroom-cluster.png",revision:"397265db28be83318e4a78f9e383ade5"},{url:"/img/lil.png",revision:"b7c06fc08f30d976121cfb1fc2ed0501"},{url:"/img/log.png",revision:"b2b92063b3b5cfde20ca97688d722b1a"},{url:"/img/logo-dark.png",revision:"9b0bb3b3ab1b4239185343d3d2895df0"},{url:"/img/logo.png",revision:"5cb20c5383f40d240ea0a2b00661ab2e"},{url:"/img/mushroom-cluster.png",revision:"db2a44cd1e8ebaacb29e8f9f744b3b81"},{url:"/img/panel-2.png",revision:"e100fc82f51392c917fe12e4d8821118"},{url:"/img/panel.png",revision:"5c080809daee28d28b32a3dcee8ff3f2"},{url:"/img/round-mushroom.png",revision:"5d83a43cee581eaed75a69cd76eca2d4"},{url:"/img/star.png",revision:"492f5fd48a664612ec46a516182cbd49"},{url:"/manifest.json",revision:"c3c8a3dd33ee72746af2b852929daea2"},{url:"/svg/circled_check.svg",revision:"6d8f347c8f980de9d2f22ad7b6b684ce"},{url:"/svg/circled_ex.svg",revision:"1686137e200dc07d93f10bd15beb0cee"},{url:"/svg/down_caret.svg",revision:"1f0b09652e909a8c93cbe98dbd71250f"},{url:"/svg/filter.svg",revision:"20ce27f0bcc45e2f5f7bdc00c429e494"},{url:"/svg/left_arrow.svg",revision:"9d06bbce6653e49c5522c954fe257116"},{url:"/svg/option_lines.svg",revision:"734c8c3b883a7d91591161705453da6b"},{url:"/svg/right_arrow.svg",revision:"1d1b4ea18bbe8e565757cb3b7e06cc8e"},{url:"/svg/star_fill.svg",revision:"3e68c540ada29dd15bb23da483a3937c"},{url:"/svg/star_outline.svg",revision:"9e61ba83da07e34270a93ae5cb127ccb"},{url:"/svg/user.svg",revision:"d6686e2916a194cbff1e84b939a66089"}],{ignoreURLParametersMatching:[]}),e.cleanupOutdatedCaches(),e.registerRoute("/",new e.NetworkFirst({cacheName:"start-url",plugins:[{cacheWillUpdate:async({request:e,response:s,event:i,state:n})=>s&&"opaqueredirect"===s.type?new Response(s.body,{status:200,statusText:"OK",headers:s.headers}):s}]}),"GET"),e.registerRoute(/^https:\/\/fonts\.(?:gstatic)\.com\/.*/i,new e.CacheFirst({cacheName:"google-fonts-webfonts",plugins:[new e.ExpirationPlugin({maxEntries:4,maxAgeSeconds:31536e3})]}),"GET"),e.registerRoute(/^https:\/\/fonts\.(?:googleapis)\.com\/.*/i,new e.StaleWhileRevalidate({cacheName:"google-fonts-stylesheets",plugins:[new e.ExpirationPlugin({maxEntries:4,maxAgeSeconds:604800})]}),"GET"),e.registerRoute(/\.(?:eot|otf|ttc|ttf|woff|woff2|font.css)$/i,new e.StaleWhileRevalidate({cacheName:"static-font-assets",plugins:[new e.ExpirationPlugin({maxEntries:4,maxAgeSeconds:604800})]}),"GET"),e.registerRoute(/\.(?:jpg|jpeg|gif|png|svg|ico|webp)$/i,new e.StaleWhileRevalidate({cacheName:"static-image-assets",plugins:[new e.ExpirationPlugin({maxEntries:64,maxAgeSeconds:86400})]}),"GET"),e.registerRoute(/\/_next\/image\?url=.+$/i,new e.StaleWhileRevalidate({cacheName:"next-image",plugins:[new e.ExpirationPlugin({maxEntries:64,maxAgeSeconds:86400})]}),"GET"),e.registerRoute(/\.(?:mp3|wav|ogg)$/i,new e.CacheFirst({cacheName:"static-audio-assets",plugins:[new e.RangeRequestsPlugin,new e.ExpirationPlugin({maxEntries:32,maxAgeSeconds:86400})]}),"GET"),e.registerRoute(/\.(?:mp4)$/i,new e.CacheFirst({cacheName:"static-video-assets",plugins:[new e.RangeRequestsPlugin,new e.ExpirationPlugin({maxEntries:32,maxAgeSeconds:86400})]}),"GET"),e.registerRoute(/\.(?:js)$/i,new e.StaleWhileRevalidate({cacheName:"static-js-assets",plugins:[new e.ExpirationPlugin({maxEntries:32,maxAgeSeconds:86400})]}),"GET"),e.registerRoute(/\.(?:css|less)$/i,new e.StaleWhileRevalidate({cacheName:"static-style-assets",plugins:[new e.ExpirationPlugin({maxEntries:32,maxAgeSeconds:86400})]}),"GET"),e.registerRoute(/\/_next\/data\/.+\/.+\.json$/i,new e.StaleWhileRevalidate({cacheName:"next-data",plugins:[new e.ExpirationPlugin({maxEntries:32,maxAgeSeconds:86400})]}),"GET"),e.registerRoute(/\.(?:json|xml|csv)$/i,new e.NetworkFirst({cacheName:"static-data-assets",plugins:[new e.ExpirationPlugin({maxEntries:32,maxAgeSeconds:86400})]}),"GET"),e.registerRoute((({url:e})=>{if(!(self.origin===e.origin))return!1;const s=e.pathname;return!s.startsWith("/api/auth/")&&!!s.startsWith("/api/")}),new e.NetworkFirst({cacheName:"apis",networkTimeoutSeconds:10,plugins:[new e.ExpirationPlugin({maxEntries:16,maxAgeSeconds:86400})]}),"GET"),e.registerRoute((({url:e})=>{if(!(self.origin===e.origin))return!1;return!e.pathname.startsWith("/api/")}),new e.NetworkFirst({cacheName:"others",networkTimeoutSeconds:10,plugins:[new e.ExpirationPlugin({maxEntries:32,maxAgeSeconds:86400})]}),"GET"),e.registerRoute((({url:e})=>!(self.origin===e.origin)),new e.NetworkFirst({cacheName:"cross-origin",networkTimeoutSeconds:10,plugins:[new e.ExpirationPlugin({maxEntries:32,maxAgeSeconds:3600})]}),"GET")}));
