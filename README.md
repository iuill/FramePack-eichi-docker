# 概要

以下リポジトリのdocker版

- https://github.com/git-ai-code/FramePack-eichi


# 実行方法

ビルド方法
```console
docker compose build
```

すべてのサービスを立ち上げる場合
```console
docker compose up -d
```

一部のサービスのみ立ち上げる場合
```console
docker-compose up framepack_lllyasviel_f1 framepack_eichi_f1 -d
```

ブラウザで以下アクセスする例
- http://localhost:8022
