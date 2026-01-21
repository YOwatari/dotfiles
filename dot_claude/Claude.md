# CLAUDE.md

## Conversation Guidelines

- 常に日本語で会話する

## Development Philosophy

### Test-Driven Development (TDD)

- 原則としてテスト駆動開発（TDD）で進める
- 期待される入出力に基づき、まずテストを作成する
- 実装コードは書かず、テストのみを用意する
- テストを実行し、失敗を確認する
- テストが正しいことを確認できた段階でコミットする
- その後、テストをパスさせる実装を進める
- 実装中はテストを変更せず、コードを修正し続ける
- すべてのテストが通過するまで繰り返す

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

### 構成の考え方

- **agents/**: 各エージェントの役割・ミッション・使用タイミング
- **rules/**: 守るべき基準・制約・禁止事項
- **skills/**: 具体的な実行手順・テクニック・テンプレート

## Reference

Based on: [everything-claude-code](https://github.com/affaan-m/everything-claude-code)
