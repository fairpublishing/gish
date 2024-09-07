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
    if get_option('bundle')
        gish_src += 'macosbundle.m'
        gish_c_args += '-DGISH_USE_BUNDLE'
    endif
endif

# The following can be added below in c_args: '-DDATAPATH="/usr/share/games/gish"'
# to change the data directory.
# We use the option link_language : 'cpp'
# because if OpenAL is compiled as a static library it needs stdc++
# but OpenAL pkg file does not list stdc++ as a requirement.
# It seems the better is to make Meson use g++ to link the executable.
# In this way the -static-libstdc++ is actually honored.
executable('gish',
    sources : gish_src,
    dependencies : gish_deps,
    c_args: gish_c_args,
    link_args : gish_link_args,
    link_language : 'cpp',
    win_subsystem: 'windows',
    install : true
)

