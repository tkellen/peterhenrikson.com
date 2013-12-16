require.config({

  // override data-main from script tag during debug mode
  baseUrl: '/',

  // automatically require on page load in debug mode
  deps: ['cs!site/index'],

  // automatically require this for production build
  insertRequire: ['cs!site/index'],

  // map bower components to nice paths
  paths: {
    jquery: 'components/jquery/jquery',
    'amd-loader': 'components/amd-loader/amd-loader',
    'coffee-script': 'components/coffee-script/index',
    text: 'components/requirejs-plugins/lib/text',
    json: 'components/requirejs-plugins/src/json',
    cjs: 'components/cjs/cjs',
    cs: 'components/require-cs/cs',
    scrollto: 'components/jquery.scrollTo/jquery.scrollTo',
    placeholder: 'components/jquery-placeholder/jquery.placeholder',
    waypoints: 'components/jquery-waypoints/waypoints',
    waypoints_sticky: 'components/jquery-waypoints/shortcuts/sticky-elements/waypoints-sticky',
    backstretch: 'components/jquery-backstretch/jquery.backstretch',
    forms: 'components/jquery-form/jquery.form'
  },

  shim: {
    waypoints_sticky: ['waypoints'],
    waypoints: ['jquery'],
    scrollto: ['jquery'],
    wookmark: ['jquery'],
    forms: ['jquery'],
    placeholder: ['jquery'],
    backstretch: ['jquery']
  },

  // modules not included in optimized build
  stubModules: ['amd-loader', 'coffee-script', 'text', 'json', 'cjs', 'cs']

});
