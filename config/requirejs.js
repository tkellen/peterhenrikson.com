require.config({

  // override data-main from script tag during debug mode
  baseUrl: '/components',

  // automatically require on page load in debug mode
  deps: ['cs!site/index'],

  // automatically require this for production build
  insertRequire: ['cs!site/index'],

  // map bower components to nice paths
  paths: {
    site: '../lib/peterhenrikson/scripts',
    jquery: 'jquery/jquery',
    'amd-loader': 'amd-loader/amd-loader',
    'coffee-script': 'coffee-script/index',
    text: 'requirejs-plugins/lib/text',
    json: 'requirejs-plugins/src/json',
    cjs: 'cjs/cjs',
    cs: 'require-cs/cs',
    scrollto: 'jquery.scrollTo/jquery.scrollTo',
    placeholder: 'jquery-placeholder/jquery.placeholder',
    parsley: 'parsleyjs/parsley',
    humane: 'humane-js/humane',
    forms: 'jquery-form/jquery.form',
    swiper: 'swiper/dist/idangerous.swiper-2.4',
    cycle: 'cycle/jquery.cycle.lite',
    masonry: 'masonry/masonry',
  },

  shim: {
    scrollto: ['jquery'],
    wookmark: ['jquery'],
    forms: ['jquery'],
    placeholder: ['jquery'],
    parsley: ['jquery'],
    swiper: ['jquery'],
    cycle: ['jquery'],
    masonry: ['jquery']
  },

  // modules not included in optimized build
  stubModules: ['amd-loader', 'coffee-script', 'text', 'json', 'cjs', 'cs']

});
