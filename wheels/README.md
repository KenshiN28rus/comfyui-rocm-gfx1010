# Папка для wheel-файлов

Скачай wheel-файлы из [Releases](https://github.com/KenshiN28rus/comfyui-rocm-gfx1010/releases) и положи их **сюда**:

- `torch-2.8.0a0+gitba56102-cp310-cp310-linux_x86_64.whl`
- `torchvision-0.23.0a0+824e8c8-cp310-cp310-linux_x86_64.whl`
- `torchaudio-2.8.0a0+6e1c7fe-py3.10-linux-x86_64.egg.tar.gz`

Затем запусти:

```bash
docker compose -f docker-compose.prebuilt.yml build
docker compose -f docker-compose.prebuilt.yml up -d

### Шаг 3. Добавь `.gitignore` для wheel-файлов

Чтобы **тяжёлые wheel-файлы не попали в git** (они уже в Releases), добавь правило в `.gitignore`:

```bash
cat >> ~/comfyui-rocm-gfx1010/.gitignore << 'EOF'

# Release files (хранятся в GitHub Releases, не в репозитории)
release-files/
wheels/*.whl
wheels/*.egg
wheels/*.tar.gz
