project('Gish', 'c', 'cpp')

gish_deps = [
    dependency('sdl'),
    dependency('openal'),
    dependency('gl'),
    dependency('ogg'),
    dependency('vorbis'),
    dependency('vorbisfile'),
    dependency('zlib'),
    dependency('libpng'),
    dependency('threads'),
]

cc = meson.get_compiler('c')

if host_machine.system() == 'windows'
    gish_deps += cc.find_library('dxguid', required: true)
    gish_deps += cc.find_library('winmm', required: true)
else
    gish_deps += cc.find_library('m', required : false)
    gish_deps += cc.find_library('dl', required : false)
endif

gish_c_args = []
gish_link_args = []
if cc.get_id() == 'gcc'
    gish_link_args += ['-static-libgcc', '-static-libstdc++']
endif

if host_machine.system() == 'darwin'
    gish_link_args += [
        '-framework', 'CoreAudio',
        '-framework', 'AudioToolbox',
        '-framework', 'IOKit',
        '-framework', 'Carbon',
    ]
endif

gish_src = [
    'audio/audio.c',
    'game/ai.c',
    'game/animation.c',
    'game/block.c',
    'game/boss.c',
    'game/config.c',
    'game/credits.c',
    'game/custom.c',
    'game/damage.c',
    'game/debug.c',
    'game/editor.c',
    'game/game.c',
    'game/gameaudio.c',
    'game/gamemenu.c',
    'game/gameobject.c',
    'game/gametexture.c',
    'game/high.c',
    'game/level.c',
    'game/lighting.c',
    'game/logic.c',
    'game/mainmenu.c',
    'game/mappack.c',
    'game/music.c',
    'game/objedit.c',
    'game/objfunc.c',
    'game/options.c',
    'game/physics.c',
    'game/player.c',
    'game/prerender.c',
    'game/random.c',
    'game/record.c',
    'game/render.c',
    'game/replay.c',
    'game/ropeedit.c',
    'game/setup.c',
    'game/socket.c',
    'game/sprite.c',
    'game/vsmode.c',
    'input/joystick.c',
    'input/keyboard.c',
    'input/mouse.c',
    'math/intersec.c',
    'math/vector.c',
    'menu/menu.c',
    'parser/parser.c',
    'physics/bond.c',
    'physics/object.c',
    'physics/particle.c',
    'sdl/endian.c',
    'sdl/event.c',
    'sdl/file.c',
    'sdl/video.c',
    'video/glfunc.c',
    'video/opengl.c',
    'video/text.c',
    'video/texture.c',
    'main.c',
]

# Added because if OpenAL is compiled as a static library it needs stdc++
# but OpenAL pkg file does not list stdc++ as a requirement.
# It seems the better is to make Meson use g++ to link the executable so
# we add a dummy c++ source file.
# In this way the -static-libstdc++ is actually honored.
gish_src += 'dummy.cpp'

if host_machine.system() == 'darwin'
    add_languages('objc')
    gish_src += 'video/macosdpi.m'
    if get_option('bundle')
        gish_src += 'macosbundle.m'
        gish_c_args += '-DGISH_USE_BUNDLE'
    endif
endif

# The following can be added below in c_args: '-DDATAPATH="/usr/share/games/gish"'
# to change the data directory.
executable('gish',
    sources : gish_src,
    dependencies : gish_deps,
    c_args: gish_c_args,
    link_args : gish_link_args,
    win_subsystem: 'windows',
    install : true
)

if host_machine.system() == 'darwin'
    conf_data = configuration_data({
        'version': meson.project_version(),
        'macos_target': get_option('macos_target'),
        'app_name': 'FreeGish',
        'app_exe': 'gish',
    })
    configure_file(
        input : 'resources/Info.plist.in',
        output : 'Info.plist',
        configuration : conf_data,
        install : true,
        install_dir : 'Contents'
    )
    install_data('resources/icon.icns', install_dir : 'Contents/Resources')
    data_dir = 'Contents/Resources'
else
    data_dir = get_option('prefix')
endif

foreach dirname : ['animation', 'level', 'music', 'sound', 'texture']
    install_subdir(dirname, install_dir : data_dir)
endforeach

