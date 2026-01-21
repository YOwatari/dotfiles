# Security Standards

セキュリティレビューで守るべき基準（OWASP Top 10ベース）

## 必ずチェック (OWASP Top 10)

### A01: Broken Access Control
- Authorization checks on all endpoints
- No direct object reference exposure
- Rate limiting implemented
- CORS properly configured
- Directory traversal prevention

### A02: Cryptographic Failures
- Data encrypted in transit (TLS)
- Data encrypted at rest
- Strong algorithms (no MD5, SHA1 for security)
- Proper key management
- No sensitive data in logs/errors

### A03: Injection
- Parameterized queries (SQL)
- Input validation and sanitization
- Output encoding
- Command injection prevention
- Template injection prevention

### A04: Insecure Design
- Threat modeling performed
- Security requirements defined
- Secure architecture patterns
- Business logic abuse prevention

### A05: Security Misconfiguration
- Default credentials changed
- Unnecessary features disabled
- Error messages don't leak info
- Security headers configured
- Dependencies up to date

### A06: Vulnerable Components
- Dependencies scanned for CVEs
- No outdated libraries
- Minimal dependency footprint
- License compliance

### A07: Authentication Failures
- Strong password policy
- Brute force protection
- Secure session management
- MFA support (if applicable)
- Secure password storage (bcrypt, argon2)

### A08: Data Integrity Failures
- Signed updates/downloads
- CI/CD pipeline security
- Deserialization safety
- Integrity verification

### A09: Logging & Monitoring Failures
- Security events logged
- No sensitive data in logs
- Log integrity protected
- Alerting configured

### A10: Server-Side Request Forgery (SSRF)
- URL validation
- Allowlist for external requests
- Internal network access blocked
- Response handling secured

## 禁止事項

### Secrets in Code

```javascript
// ❌ Never allow
const apiKey = "sk-abc123"
const password = "password123"
const token = "Bearer xyz..."

// ✅ Require
const apiKey = process.env.API_KEY
const password = process.env.DB_PASSWORD
const token = process.env.AUTH_TOKEN
```

### Weak Cryptography

```python
# ❌ Never allow
import hashlib
password_hash = hashlib.md5(password.encode()).hexdigest()
password_hash = hashlib.sha1(password.encode()).hexdigest()

# ✅ Require
import bcrypt
password_hash = bcrypt.hashpw(password.encode(), bcrypt.gensalt())
```

### SQL Injection

```javascript
// ❌ Never allow
const query = "SELECT * FROM users WHERE id = " + userId

// ✅ Require
const query = "SELECT * FROM users WHERE id = ?"
db.execute(query, [userId])
```

### Unvalidated Input

```javascript
// ❌ Never allow
app.get('/user/:id', (req, res) => {
  const user = db.getUser(req.params.id)
  res.send(user)
})

// ✅ Require
app.get('/user/:id', (req, res) => {
  const id = parseInt(req.params.id)
  if (!id || id < 1) return res.status(400).send('Invalid ID')
  const user = db.getUser(id)
  res.send(user)
})
```

## 出力フォーマット

### Per-Vulnerability Format

```text
[SEVERITY] Vulnerability title
File: path/to/file.ext:line
Category: OWASP category (e.g., A03:Injection)
Issue: Description of the vulnerability
Risk: Potential impact if exploited
Fix: Remediation steps
<vulnerable code>  // ❌
<secure code>      // ✅
```

### Severity Levels

- **CRITICAL**: Actively exploitable, immediate risk
- **HIGH**: Exploitable with some effort, significant impact
- **MEDIUM**: Limited exploitability or impact
- **LOW**: Minor issue, defense in depth
- **INFO**: Best practice recommendation

### Summary Format

```text
---
Summary: 4 issues (1 critical, 1 high, 1 medium, 1 low)
Priority: Fix SQL injection immediately, then hardcoded secret
```

## 必須セキュリティヘッダー

すべてのWebアプリケーションで設定必須：

```text
Content-Security-Policy: default-src 'self'
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-XSS-Protection: 1; mode=block
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: geolocation=(), microphone=()
```

## 検出パターン

### Secrets Detection

検索すべきキーワード：

```regex
(?i)(password|passwd|pwd|secret|token|key|api_key|credential|auth|private_key|ssh_key|connection_string)\s*[=:]\s*["'][^"']+["']
```

### Common File Patterns

以下のファイルは必ずチェック：

- `.env*` files
- `config.json`, `settings.json`
- `credentials.*`
- `*secret*`, `*password*`, `*key*`

### Injection Points

ユーザー入力を受け取る場所すべて：

- HTTP parameters (query, body, headers)
- File uploads
- Database results (second-order injection)
- External API responses

## 承認基準

### Severity-Based Decisions

| Severity | Count | Action |
|----------|-------|--------|
| CRITICAL | Any | ❌ Block deployment |
| HIGH | Any | ❌ Block deployment |
| MEDIUM | > 5 | ⚠️ Require plan |
| LOW | Any | ✅ Can deploy |
| INFO | Any | ✅ Can deploy |

### Zero Tolerance Items

以下は1つでもあれば必ずブロック：

- Hardcoded credentials
- SQL injection vulnerabilities
- Command injection vulnerabilities
- Authentication bypass
- Data exposure without encryption
- Missing critical security headers

## セキュリティ対応プロトコル

If security issue found:
1. STOP immediately
2. Use **security-reviewer** agent
3. Fix CRITICAL issues before continuing
4. Rotate any exposed secrets
5. Review entire codebase for similar issues
