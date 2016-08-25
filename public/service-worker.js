var CACHE_KEY = 'blog-cache-v1';

self.addEventListener('install', e => {

  var cached_files = [
    "/index",
    "/new",
    "/manifest.json",
    "/bower_components/app-layout/app-drawer-layout/app-drawer-layout.html",
    "/bower_components/app-layout/app-drawer/app-drawer.html",
    "/bower_components/app-layout/app-header-layout/app-header-layout.html",
    "/bower_components/app-layout/app-header/app-header.html",
    "/bower_components/app-layout/app-scroll-effects/app-scroll-effects-behavior.html",
    "/bower_components/app-layout/app-scroll-effects/app-scroll-effects.html",
    "/bower_components/app-layout/app-scroll-effects/effects/blend-background.html",
    "/bower_components/app-layout/app-scroll-effects/effects/fade-background.html",
    "/bower_components/app-layout/app-scroll-effects/effects/material.html",
    "/bower_components/app-layout/app-scroll-effects/effects/parallax-background.html",
    "/bower_components/app-layout/app-scroll-effects/effects/resize-snapped-title.html",
    "/bower_components/app-layout/app-scroll-effects/effects/resize-title.html",
    "/bower_components/app-layout/app-scroll-effects/effects/waterfall.html",
    "/bower_components/app-layout/app-toolbar/app-toolbar.html",
    "/bower_components/app-layout/helpers/helpers.html",
    "/bower_components/app-route/app-location.html",
    "/bower_components/app-route/app-route-converter-behavior.html",
    "/bower_components/app-route/app-route.html",
    "/bower_components/idb-node/idb-node.html",
    "/bower_components/iron-a11y-keys-behavior/iron-a11y-keys-behavior.html",
    "/bower_components/iron-autogrow-textarea/iron-autogrow-textarea.html",
    "/bower_components/iron-behaviors/iron-button-state.html",
    "/bower_components/iron-behaviors/iron-control-state.html",
    "/bower_components/iron-flex-layout/iron-flex-layout.html",
    "/bower_components/iron-form-element-behavior/iron-form-element-behavior.html",
    "/bower_components/iron-icon/iron-icon.html",
    "/bower_components/iron-icons/iron-icons.html",
    "/bower_components/iron-iconset-svg/iron-iconset-svg.html",
    "/bower_components/iron-input/iron-input.html",
    "/bower_components/iron-location/iron-location.html",
    "/bower_components/iron-media-query/iron-media-query.html",
    "/bower_components/iron-meta/iron-meta.html",
    "/bower_components/iron-selector/iron-multi-selectable.html",
    "/bower_components/iron-pages/iron-pages.html",
    "/bower_components/iron-location/iron-query-params.html",
    "/bower_components/iron-resizable-behavior/iron-resizable-behavior.html",
    "/bower_components/iron-scroll-target-behavior/iron-scroll-target-behavior.html",
    "/bower_components/iron-selector/iron-selectable.html",
    "/bower_components/iron-selector/iron-selection.html",
    "/bower_components/iron-selector/iron-selector.html",
    "/bower_components/marked-element/marked-element.html",
    "/bower_components/marked-element/marked-import.html",
    "/bower_components/marked/lib/marked.js",
    "/bower_components/node-uuid/uuid.js",
    "/bower_components/paper-behaviors/paper-button-behavior.html",
    "/bower_components/paper-behaviors/paper-inky-focus-behavior.html",
    "/bower_components/paper-behaviors/paper-ripple-behavior.html",
    "/bower_components/paper-button/paper-button.html",
    "/bower_components/paper-icon-button/paper-icon-button.html",
    "/bower_components/paper-input/paper-input.html",
    "/bower_components/paper-input/paper-input-behavior.html",
    "/bower_components/paper-input/paper-input-char-counter.html",
    "/bower_components/paper-input/paper-input-container.html",
    "/bower_components/paper-input/paper-input-error.html",
    "/bower_components/paper-input/paper-textarea.html",
    "/bower_components/paper-material/paper-material-shared-styles.html",
    "/bower_components/paper-ripple/paper-ripple.html",
    "/bower_components/paper-styles/color.html",
    "/bower_components/paper-styles/default-theme.html",
    "/bower_components/paper-styles/shadow.html",
    "/bower_components/polymer/polymer-micro.html",
    "/bower_components/polymer/polymer-mini.html",
    "/bower_components/polymer/polymer.html",
    "/src/blog-app.html",
    "/src/blog-edit.html",
    "/src/blog-icons.html",
    "/src/blog-index.html",
    "/src/blog-new.html",
    "/src/blog-unit.html",
  ];

  e.waitUntil(
    caches.open(CACHE_KEY).then(cache => {
      return cache.addAll(cached_files);
    }).catch(e => console.log(e)));
});


self.addEventListener('fetch', e => {

  e.respondWith(
    caches.open(CACHE_KEY).then(cache => {
      return cache.match(e.request).then(response => {
        return response || fetch(e.request.clone()).then(response => {
          cache.put(e.request, response.clone());
          return response;
        });
      });
    })
  );
});
