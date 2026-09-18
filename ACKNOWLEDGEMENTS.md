# Acknowledgements

## Special Thanks

- **[Efenstor](https://github.com/Efenstor)** — за его неоценимый вклад в поддержку AMD RDNA1 (gfx1010):

  - **[PyTorch-ROCm-gfx1010](https://github.com/Efenstor/PyTorch-ROCm-gfx1010)** — оригинальный гайд по сборке PyTorch для gfx1010. Именно из него взята идея сборки с `PYTORCH_ROCM_ARCH=gfx1010`.

  - **[PyTorch-ROCm-gfx1010-Debian13](https://github.com/Efenstor/PyTorch-ROCm-gfx1010-Debian13)** — обновлённая версия гайда, на основе которой собирался PyTorch 2.8. Несмотря на название «Debian13», его наработки полностью применимы к **Ubuntu 24.04**, на которой тестировался этот проект.

  - Его **rocBLAS-библиотеки для gfx1010** (`rocblas_library_gfx1010.tar.gz`) используются в `Dockerfile` и `Dockerfile.prebuilt` для обеспечения работы GPU-ядер.

  - Его **патч `5465fcc9`** для `composable_kernel` решает проблему зависания сборки PyTorch на HIP-ядрах (ошибка `1x16x1x16`).

Без его наработок этот проект был бы невозможен. Спасибо!

## 🖥️ Проверено на

- **ОС хоста:** Ubuntu 24.04
- **GPU:** AMD RX 5700 XT (gfx1010, RDNA1)
- **ROCm:** 6.2
- **PyTorch:** 2.8.0
- **Docker:** 29.1.3

## 📄 Лицензии сторонних компонентов

- **PyTorch** — BSD-3-Clause
- **ComfyUI** — GPL-3.0
- **ComfyUI-Manager** — GPL-3.0
- **ROCm** — MIT
