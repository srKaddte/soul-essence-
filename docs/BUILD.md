# GitHub Actions build

The workflow is `.github/workflows/build-soul-essence.yml`.

It performs:

1. checkout;
2. clone of `NextOs-Ports/nextos-framework`;
3. nxproject validation;
4. `nxgenerator` generation;
5. relevant framework regression tests;
6. AArch64 cross-compilation;
7. ELF inspection;
8. BYO-data package assembly;
9. SHA-256 generation.

## Run manually

GitHub:

`Actions` → `Build Soul Essence NextOS` → `Run workflow`.

The default framework ref is `main`.

For reproducible builds, replace `main` with the exact framework commit after we freeze the dependency.

## Important

The current `src/main.c` is intentionally a buildable host shell. It does not claim to boot the game.

The next native implementation stage must connect the exact Soul Essence APK payload to:

- nxloader / Android ELF loader;
- JNI shim;
- Unity 2019.4 lifecycle;
- EGL/GLES2;
- controller input;
- Wwise/OpenSL ES.

A successful GitHub Actions build is therefore a **build/toolchain validation**, not proof of gameplay on R36S.
