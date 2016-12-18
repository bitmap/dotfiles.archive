// Constants
const backgroundColor = 'rgba(0,0,0,.2)';
const foregroundColor = 'rgba(255,255,255,.8)';

// Colors
const RED = '#f2777a';
const GREEN = '#66cccc';
const YELLOW = '#ffcc66';
const BLUE = '#6699cc';
const MAGENTA = '#cc99cc';
const LIGHT_GRAY = '#f2f2f2';
const DARK_GRAY = '#595959'

// Mapped Colors
const colors = {
  black: backgroundColor,
  red: RED,
  green: GREEN,
  yellow: YELLOW,
  blue: BLUE,
  magenta: MAGENTA,
  cyan: BLUE,
  white: LIGHT_GRAY,
  lightBlack: DARK_GRAY,
  lightRed: RED,
  lightGreen: GREEN,
  lightYellow: YELLOW,
  lightBlue: BLUE,
  lightMagenta: MAGENTA,
  lightCyan: BLUE,
  colorCubes: '#fff',
  grayscale: foregroundColor
};

module.exports = {
  config: {
    // default font size in pixels for all tabs
    fontSize: 16,

    // font family with optional fallbacks
    fontFamily: 'Source Code Pro',

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: YELLOW,

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'BEAM',

    // color of the text
    foregroundColor: foregroundColor,

    // terminal background color
    backgroundColor: backgroundColor,

    // border color (window, tabs)
    borderColor: 'rgba(0,0,0,0)',

    // custom css to embed in the main window
    css: `
    .hyper_main {
      border: 0 !important;
    }
    .header_header {
      background: rgba(0, 0, 0, 0.1) !important;
    }
    .splitpane_divider {
      background-color: rgba(0, 0, 0, 0.2) !important;
    }
    `,

    // custom css to embed in the terminal window
    termCSS: '',

    // set to `true` if you're using a Linux set up
    // that doesn't shows native menus
    // default: `false` on Linux, `true` on Windows (ignored on macOS)
    showHamburgerMenu: '',

    // set to `false` if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` on windows and Linux (ignored on macOS)
    showWindowControls: '',

    // custom padding (css format, i.e.: `top right bottom left`)
    padding: '12px 14px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: colors,

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: '',

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {},

    // set to false for no bell
    bell: false,

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: false

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    'hyperline',
    'hyper-blink'
  ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [
    `hyper-macos-dark-vibrancy`,
  ]
};
