project('Gish', 'c')

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

# Added because if OpenAL is compiled as a static library it needs stdc++
# but OpenAL pkg file does not list stdc++ as a requirement
gish_deps += cc.find_library('stdc++')

gish_link_args = []
if cc.get_id() == 'gcc'
    # We may include '-static-libstdc++' but it gets dynamically linked to
    # stdc++ anyway.
    gish_link_args += ['-static-libgcc']
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

if host_machine.system() == 'darwin'
    add_languages('objc')
    gish_src += 'video/macosdpi.m'
endif

# The following can be added below in c_args: '-DDATAPATH="/usr/share/games/gish"'
# to change the data directory.
executable('gish',
    sources : gish_src,
    dependencies : gish_deps,
    link_args : gish_link_args,
    win_subsystem: 'windows',
    install : true
)

foreach dirname : ['animation', 'level', 'music', 'sound', 'texture']
    install_subdir(dirname, install_dir : get_option('prefix'))
endforeach

