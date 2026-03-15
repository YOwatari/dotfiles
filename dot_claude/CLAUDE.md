# CLAUDE.md

## Conversation Guidelines

- 常に日本語で会話する

## Development Philosophy

TDD で開発する（探索 → Red → Green → Refactoring → Commit）。
すべてのバージョン管理は jj を使用する。
KPI やカバレッジ目標が与えられたら、達成するまで試行する。
不明瞭な指示は質問して明確にする。

## Coding

- 関心の分離を保つ
- 状態とロジックを分離する
- 可読性と保守性を重視する
- コントラクト層（API/型）を厳密に定義し、実装層は再生成可能に保つ

## Tools

### Version Control

- **jj (Jujutsu)** を使用する
- 未初期化のリポジトリでは `jj git init --colocate` で初期化
- Git コマンドは使用せず、jj コマンドを使用する
- 詳細は `rules/jj-practice.md` を参照

### Code Intelligence
コードナビゲーションには、grep/glob/ファイル読み込みよりもLSPを優先してください。

- `goToDefinition` / `goToImplementation` でソースコードにジャンプ
- `findReferences` でコードベース全体のすべての使用箇所を確認
- `workspaceSymbol` で定義されている箇所を検索
- `documentSymbol` でファイル内のすべてのシンボルを一覧表示
- `hover` でファイルを開かずに型情報を確認
- `incomingCalls` / `outgoingCalls` で呼び出し階層を確認

関数名の変更や関数のシグネチャを変更する前に、`findReferences` を使って、まずすべての呼び出し箇所を確認してください。

grep/globは、LSPが役立たないテキスト/パターン検索（コメント、文字列、設定値）のみに使用してください。

コードを記述または編集した後は、次に進む前にLSP診断をチェックしてください。型エラーやインポートの漏れはすぐに修正しましょう。

#### コミットのタイミング
以下のタイミングで必ずコミット（jj describe でメッセージを付けて jj new で次の変更へ進む）する。

- タスク単位: Todoリストや指示の1項目を完了したとき
- 論理的なまとまり: 1つのクラス・関数・モジュールの追加・変更が完結したとき
- テストの追加: 実装コードとテストコードは別コミットでもよいが、必ずセットで積む
- リファクタリング: 動作変更を伴わない整理は実装変更とは分けてコミットする
- 設定・依存関係の変更: package.json / pyproject.toml 等の変更は独立してコミットする

### やってはいけないこと

- jj describe せずに jj new だけで先に進め続けること（空メッセージのコミットが積み上がる）
- 無関係な変更を1つのコミットにまとめること
- テストが壊れた状態でコミットを積むこと（fix: コミットで即座に直す）

### コミット失敗時の対応

GPG 署名エラー、認証エラー、hook 失敗などでコミットや push が失敗した場合：

1. **作業を即座に停止する**
2. **エラー内容をユーザーに報告する**
3. **自己判断で回避策（--no-verify, --no-gpg-sign 等）を使用しない**
4. **ユーザーの指示を待つ**

## Reference

Based on:

- [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code)
- [mizchi/chezmoi-dotfiles](https://github.com/mizchi/chezmoi-dotfiles)
