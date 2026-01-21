# CLAUDE.md

## Conversation Guidelines

- 常に日本語で会話する

## Development Philosophy

TDD で開発する（探索 → Red → Green → Refactoring）。
KPI やカバレッジ目標が与えられたら、達成するまで試行する。
不明瞭な指示は質問して明確にする。

## Coding

- 関心の分離を保つ
- 状態とロジックを分離する
- 可読性と保守性を重視する
- コントラクト層（API/型）を厳密に定義し、実装層は再生成可能に保つ

## Tools

- VCS: jj を優先する（未初期化なら `jj git init --colocate`）

## Configuration Structure

このディレクトリには、以下の構成でClaude Codeの設定が配置されています：

```
dot_claude/
├── Claude.md                           # このファイル（グローバル設定）
├── settings.json                       # Claude Code設定
│
├── agents/                             # エージェント定義
│   ├── architect.md                    # システムアーキテクト
│   ├── code-reviewer.md                # コードレビュー担当
│   ├── doc-updater.md                  # ドキュメント更新担当
│   ├── planner.md                      # 実装計画担当
│   ├── refactorer.md                   # リファクタリング担当
│   ├── security-reviewer.md            # セキュリティレビュー担当
│   └── tdd-guide.md                    # TDDガイド
│
├── rules/                              # 開発ルールと標準
│   ├── agents.md                       # エージェント使用規則
│   ├── coding-style.md                 # コーディングスタイル
│   ├── jj-practice.md                  # jjバージョン管理のベストプラクティス
│   ├── performance.md                  # パフォーマンス基準
│   ├── security.md                     # セキュリティ基準
│   └── testing.md                      # テスト基準
│
└── skills/                             # 具体的な手順とテクニック
    ├── coding-standards.md             # コーディング標準
    ├── refactoring-patterns.md         # リファクタリングパターン
    ├── jj/SKILL.md                     # jjの使用方法
    ├── security-review/SKILL.md        # セキュリティレビュー手順
    └── tdd-workflow/SKILL.md           # TDDワークフロー
```

## Reference

Based on:

- [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code)
- [mizchi/chezmoi-dotfiles](https://github.com/mizchi/chezmoi-dotfiles)
