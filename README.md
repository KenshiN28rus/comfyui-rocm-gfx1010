![GitHub release](https://img.shields.io/github/v/release/KenshiN28rus/comfyui-rocm-gfx1010)
![GitHub stars](https://img.shields.io/github/stars/KenshiN28rus/comfyui-rocm-gfx1010)
![GitHub forks](https://img.shields.io/github/forks/KenshiN28rus/comfyui-rocm-gfx1010)
![License](https://img.shields.io/github/license/KenshiN28rus/comfyui-rocm-gfx1010)
![GitHub issues](https://img.shields.io/github/issues/KenshiN28rus/comfyui-rocm-gfx1010)

# ComfyUI на AMD RX 5700 XT (gfx1010) с ROCm 6.2
...
# ComfyUI на AMD RX 5700 XT (gfx1010) с ROCm 6.2

Docker-образ с **PyTorch 2.8**, собранным специально для **AMD RDNA1 (gfx1010)** — архитектуры, которую AMD официально не поддерживает в современных версиях ROCm.

## 🎯 Что это

Готовое решение для запуска **ComfyUI** на видеокартах AMD RDNA1:
- RX 5700 XT
- RX 5700
- RX 5600 XT
- RX 5500 XT

Без override на gfx1030, без шума на картинках, с **правильными ядрами** для gfx1010.

## 📦 Что внутри

- **PyTorch 2.8.0** — собран из исходников с `PYTORCH_ROCM_ARCH=gfx1010`
- **torchvision 0.23.0** — собран из исходников
- **torchaudio 2.8.0** — собран из исходников
- **ROCm 6.2** — проверенная версия для RDNA1
- **ComfyUI** — последняя версия
- **ComfyUI-Manager V3.41** — с защитой от обновления PyTorch

## ⚡ Производительность

| Модель | Разрешение | Шаги | Время |
|--------|-----------|------|-------|
| SD 1.5 | 512×512 | 20 | 15–30 сек |
| SDXL | 1024×1024 | 20 | 1.5–2 мин |
| SDXL Turbo | 1024×1024 | 8 | 35–50 сек |

## 🚀 Быстрый старт

### Требования

- **Ubuntu 24.04** (или другая с ROCm 6.2 на хосте)
- **Docker** и **Docker Compose**
- **AMD RX 5700 XT** или другая RDNA1
- **8+ ГБ VRAM**, **16+ ГБ RAM**

### Шаг 1. Установи ROCm на хост

```bash
wget https://repo.radeon.com/amdgpu-install/6.4.2.1/ubuntu/noble/amdgpu-install_6.4.60402-1_all.deb
sudo apt install ./amdgpu-install_6.4.60402-1_all.deb
sudo amdgpu-install --usecase=rocm --no-dkms
sudo usermod -a -G render,video $USER
sudo reboot
