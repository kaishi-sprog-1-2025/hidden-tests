# システムプログラミング基礎Ⅰ課題1:ブロックテスト用非公開テスト

## 非公開テストの運用（教員向け）
1. 教員用の private リポジトリ（例：`hidden-tests`）を作成し、以下の構造でテストを置きます。
   ```
   hidden-tests/
   ├── q1/*.in *.out
   ├── q2/*.in *.out
   ├── q3/*.in *.out
   └── q4/*.in *.out
   ```
2. GitHub Actions 用に **読み取り権限のあるトークン** を作成し、Classroomテンプレ側に Secret を追加します。
   - Secret名：`HIDDEN_TOKEN`
3. `.github/workflows/autograde.yml` の `HIDDEN_REPO` を教員のリポジトリに変更します。

## 使い方（Make）
```bash
make build        # q1〜q4 をビルド
make test         # 公開テスト（60点）
make test-hidden  # 非公開テスト（hidden-tests がある場合のみ）
make test-all     # 公開＋非公開（best effort）
make clean        # 生成物削除
```