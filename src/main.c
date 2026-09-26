/*
 * Soul Essence NextOS native host entry point.
 *
 * This is deliberately a buildable integration shell, not a fake gameplay
 * implementation. The Unity/ELF/JNI bridge must be connected to the exact
 * NextOS nxloader ABI before a physical-release claim is made.
 */

#define _GNU_SOURCE

#include <SDL2/SDL.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/utsname.h>

static void usage(const char *argv0)
{
    fprintf(stderr, "usage: %s <game-dir> [args...]\n", argv0);
}

int main(int argc, char **argv)
{
    if (argc < 2) {
        usage(argv[0]);
        return 2;
    }

    const char *game_dir = argv[1];

    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_GAMECONTROLLER | SDL_INIT_EVENTS) != 0) {
        fprintf(stderr, "[soul-essence] SDL_Init failed: %s\n", SDL_GetError());
        return 1;
    }

    fprintf(stderr, "[soul-essence] NextOS native host\n");
    fprintf(stderr, "[soul-essence] game-dir=%s\n", game_dir);
    fprintf(stderr, "[soul-essence] SDL=%d.%d.%d\n",
            SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL);

#if defined(__aarch64__)
    fprintf(stderr, "[soul-essence] architecture=aarch64\n");
#else
    fprintf(stderr, "[soul-essence] architecture=unexpected\n");
#endif

    /*
     * Do not silently pretend that Unity is running. The real adapter will
     * replace this shell with the framework nxloader/JNI lifecycle:
     *
     *   libmain.so
     *     -> libunity.so
     *     -> JNI_OnLoad
     *     -> initJni
     *     -> nativeRecreateGfxState
     *     -> nativeSendSurfaceChangedEvent
     *     -> nativeResume
     *     -> nativeRender
     *
     * and will resolve libil2cpp.so/libAkSoundEngine.so through the NextOS
     * Android compatibility layer.
     */

    SDL_Quit();
    return 0;
}
