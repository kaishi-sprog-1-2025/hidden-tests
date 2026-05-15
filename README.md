# システムプログラミング基礎Ⅰ 第4回 ブロックテスト用非公開テスト
# hidden-tests（教員用）

## 概要

このリポジトリは、GitHub Classroom 課題の **非公開テスト（hidden tests）** を管理するためのものです。

学生には公開しません。

---

# 目的

公開テスト（public tests）だけでは、

* 特定ケースだけ通る
* 偶然正しい
* 境界値に弱い

などの問題があります。

hidden tests では、

* 負数
* 0
* 境界値
* 複数パターン

などを確認します。

---

# ディレクトリ構成

```text id="3fjlwm"
hidden-tests/
├── Makefile
├── run_hidden.sh
├── q1/
├── q2/
├── q3/
└── q4/
```

各ディレクトリには：

```text id="t01e6u"
01.in
01.out
02.in
02.out
...
```

を配置します。

---

# 使用方法

## 1. assignment-template を clone

```bash id="1fd3zl"
git clone <assignment-template>
```

---

## 2. assignment-template を build

```bash id="jlwm0o"
cd assignment-template
make build
```

実行ファイル：

```text id="5rf78n"
q1/main
q2/main
...
```

を作成します。

---

## 3. hidden-tests を clone

```bash id="jlwmz9"
git clone <hidden-tests>
```

---

## 4. hidden tests を実行

```bash id="8wpc2o"
cd hidden-tests
make test
```

---

# TARGET の変更

デフォルトでは：

```text id="v47w1e"
../assignment-template
```

を参照します。

別の場所を使う場合：

```bash id="v9w0kl"
make test TARGET=/path/to/assignment-template
```

---

# テスト結果

## PASS

```text id="c0k17p"
PASS
```

→ 正解

---

## FAIL

```text id="bmzft6"
FAIL
```

の場合：

* Input
* Expected
* Got
* Diff

が表示されます。

---

# テスト追加方法

例：

```text id="wbjlwm"
q1/03.in
q1/03.out
```

を追加するだけです。

---

# .out の生成

正解実装を用いて：

```bash id="jlwm0v"
../assignment-template/q1/main < q1/03.in > q1/03.out
```

のように生成できます。

---

# 注意

このリポジトリは：

```text id="jlwm1o"
教員専用
```

です。

学生には公開しないでください。

---

# GitHub Actions との関係

GitHub Actions では、このリポジトリを clone して hidden tests を実行します。

そのため、

* `.in`
* `.out`

は GitHub Actions 上でも利用されます。

---

以上
