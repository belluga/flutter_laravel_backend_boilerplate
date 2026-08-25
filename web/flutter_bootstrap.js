{{flutter_js}}
{{flutter_build_config}}

var appDataJS = {
    'hostname': window.location.hostname,
    'href': window.location.href,
    'port': window.location.port,
  };

function hideSplashScreen() {
  const splashScreen = document.getElementById('splash-screen');
  if (splashScreen) {
    splashScreen.remove();
  }
}

function hideSplashWhenReady() {
  let attempts = 0;
  const interval = window.setInterval(() => {
    attempts += 1;
    if (document.querySelector('flt-glass-pane') || attempts >= 120) {
      window.clearInterval(interval);
      hideSplashScreen();
    }
  }, 250);
}

_flutter.loader.load({
  config: {
    useLocalCanvasKit: true,
    canvasKitBaseUrl: 'canvaskit/',
    canvasKitVariant: 'full',
  },
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    await appRunner.runApp();
    hideSplashWhenReady();
  }
});
