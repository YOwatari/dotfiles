# Security Review Checklist

セキュリティレビューのためのOWASP Top 10ベースのチェックリスト

## OWASP Top 10 Checklist

### A01: Broken Access Control

**Authorization & Access**
- Authorization checks on all endpoints
- No direct object reference exposure
- Rate limiting implemented
- CORS properly configured
- Directory traversal prevention

### A02: Cryptographic Failures

**Data Protection**
- Data encrypted in transit (TLS)
- Data encrypted at rest
- Strong algorithms (no MD5, SHA1 for security)
- Proper key management
- No sensitive data in logs/errors

### A03: Injection

**Input Handling**
- Parameterized queries (SQL)
- Input validation and sanitization
- Output encoding
- Command injection prevention
- Template injection prevention

### A04: Insecure Design

**Architecture Security**
- Threat modeling performed
- Security requirements defined
- Secure architecture patterns
- Business logic abuse prevention

### A05: Security Misconfiguration

**Configuration Management**
- Default credentials changed
- Unnecessary features disabled
- Error messages don't leak info
- Security headers configured
- Dependencies up to date

### A06: Vulnerable Components

**Dependency Management**
- Dependencies scanned for CVEs
- No outdated libraries
- Minimal dependency footprint
- License compliance

### A07: Authentication Failures

**Authentication & Sessions**
- Strong password policy
- Brute force protection
- Secure session management
- MFA support (if applicable)
- Secure password storage (bcrypt, argon2)

### A08: Data Integrity Failures

**Integrity Verification**
- Signed updates/downloads
- CI/CD pipeline security
- Deserialization safety
- Integrity verification

### A09: Logging & Monitoring Failures

**Observability**
- Security events logged
- No sensitive data in logs
- Log integrity protected
- Alerting configured

### A10: Server-Side Request Forgery (SSRF)

**External Request Security**
- URL validation
- Allowlist for external requests
- Internal network access blocked
- Response handling secured

## Common Vulnerability Patterns

言語非依存で検出すべき一般的なパターン

### Secrets Detection

**Search Patterns**:
- password, passwd, pwd
- secret, token, key, api_key
- credential, auth
- private_key, ssh_key
- connectionstring, connection_string

**Detection Regex**:
```regex
(?i)(password|secret|token|key|credential)\s*[=:]\s*["'][^"']+["']
```

### Injection Points

**User Input Sources**:
- HTTP parameters (query, body, headers)
- File uploads
- Database results (second-order injection)
- External API responses

**Dangerous Sinks**:
- Database queries
- System commands
- File operations
- Template rendering
- Dynamic code execution

### Authentication Weaknesses

**Check for**:
- Passwords in plaintext
- Weak hashing (MD5, SHA1)
- Missing session expiry
- Predictable tokens
- Missing CSRF protection

## Security Headers Checklist

必須のセキュリティヘッダー：

```text
Content-Security-Policy: default-src 'self'
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-XSS-Protection: 1; mode=block
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: geolocation=(), microphone=()
```

## Output Format

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

### Example Output

```text
[CRITICAL] SQL Injection vulnerability
File: src/db/users.ts:34
Category: A03:Injection
Issue: User input directly concatenated into SQL query
Risk: Full database compromise, data theft, data manipulation
Fix: Use parameterized queries
query = "SELECT * FROM users WHERE id = " + id  // ❌
query = "SELECT * FROM users WHERE id = ?", [id]  // ✅

[HIGH] Hardcoded secret in source
File: src/config/auth.ts:12
Category: A02:Cryptographic Failures
Issue: JWT secret hardcoded in source code
Risk: Token forgery, authentication bypass
Fix: Move to environment variable or secret manager
const secret = "super-secret-key-123"  // ❌
const secret = process.env.JWT_SECRET  // ✅

[MEDIUM] Missing rate limiting
File: src/routes/login.ts:45
Category: A07:Authentication Failures
Issue: No rate limiting on login endpoint
Risk: Brute force attacks on user accounts
Fix: Implement rate limiting (e.g., 5 attempts per minute)

[LOW] Verbose error message
File: src/handlers/api.ts:78
Category: A05:Security Misconfiguration
Issue: Stack trace exposed in error response
Risk: Information disclosure aids attackers
Fix: Return generic error message, log details server-side
res.send({ error: err.stack })  // ❌
res.send({ error: "Internal server error" })  // ✅

---
Summary: 4 issues (1 critical, 1 high, 1 medium, 1 low)
Priority: Fix SQL injection immediately, then hardcoded secret
```

## Review Guidelines

セキュリティレビューは網羅的に行い、重大な問題を優先して報告：

1. **Scan systematically** - Check all OWASP categories
2. **Prioritize by risk** - Critical and High issues first
3. **Provide context** - Explain why it's a risk
4. **Give actionable fixes** - Specific remediation steps
5. **Consider false positives** - Verify before reporting
