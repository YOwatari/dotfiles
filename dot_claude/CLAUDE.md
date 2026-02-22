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

### Version Control (必須)

- **jj (Jujutsu)** を使用する
- 未初期化のリポジトリでは `jj git init --colocate` で初期化
- Git コマンドは使用せず、jj コマンドを使用する
- 詳細は `rules/jj-practice.md` を参照

## Reference

Based on:

- [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code)
- [mizchi/chezmoi-dotfiles](https://github.com/mizchi/chezmoi-dotfiles)

