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

#### コミットのタイミング
以下のタイミングで必ずコミット（jj describe でメッセージを付けて jj new で次の変更へ進む）する。

- タスク単位: Todoリストや指示の1項目を完了したとき
- 論理的なまとまり: 1つのクラス・関数・モジュールの追加・変更が完結したとき
- テストの追加: 実装コードとテストコードは別コミットでもよいが、必ずセットで積む
- リファクタリング: 動作変更を伴わない整理は実装変更とは分けてコミットする
- 設定・依存関係の変更: package.json / pyproject.toml 等の変更は独立してコミットする

### やってはいけないこと

- jj describe せずに jj new だけで先に進め続けること（空メッセージのコミットが積み上がる）
- 無関係な変更を1つのコミットにまとめるこ
- テストが壊れた状態でコミットを積むこと（fix: コミットで即座に直す）

## Reference

Based on:

- [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code)
- [mizchi/chezmoi-dotfiles](https://github.com/mizchi/chezmoi-dotfiles)
