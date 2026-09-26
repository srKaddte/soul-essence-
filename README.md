# Soul Essence — NextOS / R36S

Projeto de port AArch64 para NextOS/PortMaster do **Soul Essence v6.0**.

## Estado atual

Este repositório separa:

1. código público do adapter;
2. framework NextOS usado durante o build;
3. dados proprietários fornecidos pelo usuário (BYO-data).

O APK do jogo **não é distribuído neste repositório**.

O workflow `.github/workflows/build-soul-essence.yml` pode ser executado pelo GitHub Actions com **Run workflow**.

## Como usar

1. Crie um repositório no GitHub.
2. Copie todos os arquivos deste projeto para ele.
3. Faça `git push`.
4. Abra **Actions → Build Soul Essence NextOS**.
5. Escolha **Run workflow**.
6. Deixe `framework_ref` como `main`, salvo se estivermos fixando outro commit.
7. Deixe `build_native` ativado.
8. Ao terminar, baixe o artefato `soul-essence-nextos-aarch64`.

## Importante

O build AArch64 só deve ser considerado um port físico depois de o adapter nativo específico do Soul Essence passar pelos testes no R36S.

O workflow não coloca o APK proprietário dentro do artefato público.

## Perfil conhecido do APK

O payload analisado anteriormente possui:

- ARM64 / `arm64-v8a`;
- Unity 2019.4.9f1;
- IL2CPP;
- `libmain.so`;
- `libunity.so`;
- `libil2cpp.so`;
- `libAkSoundEngine.so`;
- Wwise/OpenSL ES.

Esses dados são usados como contrato de integração, não como substituto do teste físico.

## Estrutura

```text
.
├── .github/
│   └── workflows/
│       └── build-soul-essence.yml
├── port/
│   └── Soul Essence NextOS.sh
├── scripts/
│   └── BUILD-AARCH64.sh
├── src/
│   ├── main.c
│   └── ...
├── nxproject.json
├── CMakeLists.txt
├── LICENSE
└── README.md
```

## Próxima etapa

Depois que o Actions gerar o primeiro artefato, o teste real será feito no R36S. Os logs de `nxloader`, JNI, EGL/GLES, áudio e `nativeRender` serão usados para fechar os pontos específicos do APK.
