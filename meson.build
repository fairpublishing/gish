project('Gish', 'c', 'cpp')

gish_deps = [
    dependency('sdl2'),
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
        '-framework', 'ForceFeedback',
    ]
endif

subdir('src')

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

