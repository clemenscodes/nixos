let
  w3championsUrl = "https://github.com/w3champions/launcher-e-release/releases/download/1.3.35/W3Champions_1.3.35_x64-setup.exe";
  # bnet = ''
  #   - task:
  #       arch: win64
  #       description: 'Installing Blizzard App. An installer will open.
  #
  #         ------------------------------
  #
  #         To progress, manually continue installation in that window.'
  #       exclude_processes: Battle.net.exe Agent.exe "Battle.net Helper.exe"
  #       executable: setup
  #       name: wineexec
  #   - task:
  #       name: winekill
  #       prefix: $GAMEDIR
  # '';
in ''
  description: 'Installs Battle.net + W3Champions in a virtual desktop.
    Once inside of the virtual desktop, double click the W3Champions icon to start it up.
    NOTE: The Play button in the W3Champions launcher does not work.
    Launch Warcraft III: Reforged from the BNet client after starting the W3Champions launcher.'
  game_slug: warcraft-iii-reforged
  gogslug: '''
  humblestoreid: '''
  installer_slug: warcraft-iii-reforged-battlenet-w3champion
  name: 'Warcraft III: Reforged'
  notes: "**CONFIGURE AND INSTALL THE DEPENDENCIES FIRST**\r\nInstructions for Vulkan\
    \ support: https://github.com/lutris/lutris/wiki/Installing-drivers\r\n\r\nInstructions\
    \ for proper functionality of Battle.Net (+ common problems) https://github.com/lutris/lutris/wiki/Game:-Blizzard-App\r\
    \n\r\nIf the game is laggy you can switch between different windowmodes from the\
    \ command line. This script defaults to fullscreen.\r\n-windowmode fullscreen\r\n\
    -windowmode windowed\r\n\r\nMore info on command line options can be found here:\r\
    \nhttps://us.forums.blizzard.com/en/warcraft3/t/1-31-0-patch-notes/5721"
  runner: wine
  script:
    files:
    - setup: http://dist.blizzard.com/downloads/bna-installers/322d5bb9ae0318de3d4cde7641c96425/retail.1/Battle.net-Setup-enUS.exe
    - w3champions: ${w3championsUrl}
    game:
      arch: win64
      args: --exec="launch W3"
      exe: drive_c/Program Files (x86)/Battle.net/Battle.net.exe
      prefix: $GAMEDIR
    installer:
    - task:
        arch: win64
        description: Creating 64bit Wine prefix.
        name: create_prefix
        prefix: $GAMEDIR
    - task:
        app: arial
        arch: win64
        description: Installing Arial font...
        name: winetricks
        prefix: $GAMEDIR
        silent: true
    - task:
        arch: win64
        description: Setting Windows 7 mode for Wine
        key: Version
        name: set_regedit
        path: HKEY_CURRENT_USER\Software\Wine
        prefix: $GAMEDIR
        value: win7
    - task:
        name: winekill
        prefix: $GAMEDIR
    - write_json:
        data:
          Client:
            GameLaunchWindowBehavior: '0'
            GameSearch:
              BackgroundSearch: 'true'
            HardwareAcceleration: 'false'
            Sound:
              Enabled: 'false'
            Streaming:
              StreamingEnabled: 'false'
          w3:
            AdditionalLaunchArguments: -windowmode fullscreen
        description: Writing a Battle.Net config file
        file: $GAMEDIR/drive_c/users/$USER/Application Data/Battle.net/Battle.net.config
    - task:
        arch: win64
        description: 'Wine Staging: Enabling DXVA2'
        key: backend
        name: set_regedit
        path: HKEY_CURRENT_USER\Software\Wine\DXVA2
        prefix: $GAMEDIR
        value: va
    - task:
        name: winekill
        prefix: $GAMEDIR
    - task:
        arch: win64
        description: 'Installing w3champions...

          ------------------------------

          To progress, ensure that w3champions is closed by right clicking on the tray
          icon and selecting exit.'
        name: wineexec
        executable: w3champions
    - task:
        name: winekill
        prefix: $GAMEDIR
    system:
      env:
        DXVK_STATE_CACHE_PATH: $GAMEDIR
        STAGING_SHARED_MEMORY: 1
        __GL_SHADER_DISK_CACHE: 1
        __GL_SHADER_DISK_CACHE_PATH: $GAMEDIR
      exclude_processes: Agent.exe "Battle.net Helper.exe"
    wine:
      Desktop: true
      overrides:
        nvapi: disabled
        nvapi64: disabled
  slug: warcraft-iii-reforged-battlenet-w3champion
  steamid: null
  version: Battle.net + w3champions
  year: 2020
''
