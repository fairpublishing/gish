This is FreeGish modified to compile and run on Windows, macOS and Linux
using Meson with gcc and clang and using the same workflow.

# How to compile

You can compile on Linux, Windows and macOS using [Lhelper](https://github.com/franko/lhelper)
and [Meson](https://mesonbuild.com/).

Once they are both installed issue the commands:

    lhelper activate build
    meson setup .build
    meson compile -C .build

On Windows we suggest using MSYS2 and work in the MinGW64 environment.

# How to play

Copy the executable `gish` or `gish.exe` from `.build` and run `./gish` or `gish.exe`.
There are some assets included (codenamed the *FreeGish* project), making Gish a completely free game! There is also one level available, `freegish.lvl`, you'll find it under "Custom Levels". Try it and replace what you don't like.

If you own the original assets, you may also copy those into this directory. You'll need:

- animation
- level
- music
- sound
- texture
- tile01 ... tile07

