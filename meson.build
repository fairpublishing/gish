project('Gish', 'c')

# Uncomment and modify this line to set a hardcoded data path
# add_global_arguments('-DDATAPATH="/usr/share/games/gish"', language : 'c')

sdl_dep        = dependency('sdl')
openal_dep     = dependency('openal')
opengl_dep     = dependency('gl')
ogg_dep        = dependency('ogg')
vorbis_dep     = dependency('vorbis')
vorbisfile_dep = dependency('vorbisfile')
zlib_dep       = dependency('zlib')
png_dep        = dependency('libpng')
thread_dep     = dependency('threads')

libm  = meson.get_compiler('c').find_library('m', required : false)
libdl = meson.get_compiler('c').find_library('dl', required : false)

# Added because if OpenAL is compiled as a static library it needs stdc++
# but OpenAL pkg file does not list stdc++ as a requirement
libstdcpp = meson.get_compiler('c').find_library('stdc++')

gish_link_args = []
if meson.get_compiler('c').get_id() == 'gcc'
    # We may include '-static-libstdc++' but it gets dynamically linked to
    # stdc++ anyway.
    gish_link_args += ['-static-libgcc']
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

executable('gish',
    sources : gish_src,
    dependencies : [
        opengl_dep,
        zlib_dep,
        png_dep,
        sdl_dep,
        openal_dep,
        ogg_dep, vorbis_dep, vorbisfile_dep,
        thread_dep,
        libm, libdl, libstdcpp
    ],
    link_args : gish_link_args,
    install : true
)

