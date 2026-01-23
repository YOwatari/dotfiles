---
name: security-review
description: Security vulnerability detection and review skill. Use when implementing authentication, handling user input, creating APIs, managing secrets, or implementing payment features.
---

# Security Review Skill

Systematically review code for security vulnerabilities based on OWASP Top 10.

## Activation Triggers

Use this skill when:

- Implementing or modifying authentication/authorization
- Handling user input or file uploads
- Creating new API endpoints
- Working with secrets or credentials
- Implementing payment/billing features
- Storing or transmitting sensitive data
- Integrating third-party APIs
- Before finalizing code changes

## Execution Procedure

### Step 1: Identify Project Structure

```bash
# List relevant source files
find . -type f \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" -o -name "*.py" -o -name "*.go" \) \
  -not -path "*/node_modules/*" -not -path "*/.git/*" | head -50

# Check for env files and gitignore
ls -la .env* 2>/dev/null || true
grep -E "(env|secret|key)" .gitignore 2>/dev/null || true
```

### Step 2: Scan for Hardcoded Secrets (A02)

```bash
# Search for hardcoded secrets
grep -rn --include="*.ts" --include="*.tsx" --include="*.js" --include="*.py" --include="*.go" \
  -E "(password|secret|token|api_key|apikey|private_key|credential)\s*[=:]\s*['\"][^'\"]+['\"]" . \
  --exclude-dir={node_modules,.git,dist,build,vendor}

# Detect high-entropy strings (Base64 encoded keys)
grep -rn --include="*.ts" --include="*.tsx" --include="*.js" --include="*.py" \
  -E "['\"][A-Za-z0-9+/=]{32,}['\"]" . \
  --exclude-dir={node_modules,.git,dist,build,vendor}
```

### Step 3: Detect Injection Vulnerabilities (A03)

```bash
# SQL string concatenation
grep -rn --include="*.ts" --include="*.tsx" --include="*.js" --include="*.py" \
  -E "(SELECT|INSERT|UPDATE|DELETE|FROM|WHERE).*\+.*\$|\`.*\$\{" . \
  --exclude-dir={node_modules,.git,dist,build,vendor}

# Command injection patterns
grep -rn --include="*.ts" --include="*.tsx" --include="*.js" --include="*.py" \
  -E "(exec|spawn|system|eval|Function\()" . \
  --exclude-dir={node_modules,.git,dist,build,vendor}
```

### Step 4: Check Authentication & Authorization (A01, A07)

```bash
# Find auth-related files
find . -type f \( -name "*auth*" -o -name "*login*" -o -name "*session*" \) \
  -not -path "*/node_modules/*" -not -path "*/.git/*"

# Token storage in localStorage (XSS vulnerable)
grep -rn --include="*.ts" --include="*.tsx" --include="*.js" \
  -E "localStorage\.(set|get)Item.*token|sessionStorage\.(set|get)Item.*token" . \
  --exclude-dir={node_modules,.git,dist,build}
```

### Step 5: Check Dependencies (A06)

```bash
# npm/yarn
npm audit --json 2>/dev/null || yarn audit --json 2>/dev/null || true

# Python
pip-audit 2>/dev/null || safety check 2>/dev/null || true
```

## OWASP Top 10 Checklist

### A01: Broken Access Control

| Check | Method |
|-------|--------|
| Authorization on all endpoints | Review API routes |
| No direct object reference exposure | Check ID parameter usage |
| Rate limiting implemented | Check middleware |
| CORS properly configured | Check CORS settings |

```typescript
// ❌ No authorization check
app.get('/api/users/:id', async (req, res) => {
  const user = await db.users.findById(req.params.id)
  res.json(user)
})

// ✅ Authorization check before data access
app.get('/api/users/:id', authenticate, async (req, res) => {
  if (req.user.id !== req.params.id && req.user.role !== 'admin') {
    return res.status(403).json({ error: 'Forbidden' })
  }
  const user = await db.users.findById(req.params.id)
  res.json(user)
})
```

### A02: Cryptographic Failures

| Check | Method |
|-------|--------|
| No hardcoded secrets | Search source files |
| Secrets in environment variables | Check configuration |
| Strong algorithms (no MD5/SHA1) | Review crypto usage |
| No sensitive data in logs | Check logging |

```typescript
// ❌ Hardcoded secret
const JWT_SECRET = "my-super-secret-key-123"

// ✅ Environment variable
const JWT_SECRET = process.env.JWT_SECRET
if (!JWT_SECRET) throw new Error('JWT_SECRET not configured')
```

### A03: Injection

| Check | Method |
|-------|--------|
| Parameterized queries | Review SQL statements |
| Input validation | Check input handling |
| Output encoding | Review rendering |
| No command injection | Check exec/spawn usage |

```typescript
// ❌ SQL Injection
const query = `SELECT * FROM users WHERE email = '${userEmail}'`

// ✅ Parameterized query
const { data } = await supabase.from('users').select('*').eq('email', userEmail)
```

```python
# ❌ SQL Injection
cursor.execute(f"SELECT * FROM users WHERE email = '{email}'")

# ✅ Parameterized query
cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
```

### A05: Security Misconfiguration

| Check | Method |
|-------|--------|
| Security headers configured | Check response headers |
| Error messages don't leak info | Review error handling |
| Debug mode disabled in production | Check configuration |

**Required Security Headers**:
```typescript
const securityHeaders = [
  { key: 'Content-Security-Policy', value: "default-src 'self'" },
  { key: 'X-Content-Type-Options', value: 'nosniff' },
  { key: 'X-Frame-Options', value: 'DENY' },
  { key: 'Strict-Transport-Security', value: 'max-age=31536000; includeSubDomains' },
  { key: 'Referrer-Policy', value: 'strict-origin-when-cross-origin' },
]
```

### A07: Authentication Failures

| Check | Method |
|-------|--------|
| Tokens in httpOnly cookies | Check token storage |
| Strong password hashing | Review auth implementation |
| Brute force protection | Check rate limiting |

```typescript
// ❌ localStorage (XSS vulnerable)
localStorage.setItem('token', token)

// ✅ httpOnly cookie
res.setHeader('Set-Cookie',
  `token=${token}; HttpOnly; Secure; SameSite=Strict; Max-Age=3600`)
```

### A09: Logging & Monitoring Failures

| Check | Method |
|-------|--------|
| No sensitive data in logs | Review log statements |
| Security events logged | Check logging coverage |

```typescript
// ❌ Sensitive data in logs
console.log('Login:', { email, password })

// ✅ Redacted sensitive data
console.log('Login:', { email, userId })
```

### A10: Server-Side Request Forgery (SSRF)

| Check | Method |
|-------|--------|
| URL validation | Review external requests |
| Allowlist for external hosts | Check URL handling |

```typescript
// ❌ Unvalidated URL
const response = await fetch(req.query.url)

// ✅ Allowlist validation
const ALLOWED_HOSTS = ['api.example.com']
const url = new URL(req.query.url)
if (!ALLOWED_HOSTS.includes(url.hostname)) {
  return res.status(400).json({ error: 'Host not allowed' })
}
```

## Input Validation Patterns

### TypeScript (Zod)

```typescript
import { z } from 'zod'

const CreateUserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(1).max(100),
  age: z.number().int().min(0).max(150),
})

const validated = CreateUserSchema.parse(input)
```

### Python (Pydantic)

```python
from pydantic import BaseModel, EmailStr, conint, constr

class CreateUserRequest(BaseModel):
    email: EmailStr
    name: constr(min_length=1, max_length=100)
    age: conint(ge=0, le=150)
```

### File Upload Validation

```typescript
function validateUpload(file: File): boolean {
  const MAX_SIZE = 5 * 1024 * 1024
  const ALLOWED_TYPES = ['image/jpeg', 'image/png', 'image/gif']

  if (file.size > MAX_SIZE) throw new Error('File too large')
  if (!ALLOWED_TYPES.includes(file.type)) throw new Error('Invalid type')
  return true
}
```

## Pre-Deployment Checklist

- [ ] No hardcoded secrets
- [ ] All user inputs validated
- [ ] SQL queries parameterized
- [ ] User content sanitized
- [ ] CSRF protection enabled
- [ ] Tokens in httpOnly cookies
- [ ] Authorization checks implemented
- [ ] Rate limiting enabled
- [ ] HTTPS enforced
- [ ] Security headers configured
- [ ] No sensitive data in error messages
- [ ] No sensitive data in logs
- [ ] Dependencies have no known vulnerabilities

## References

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP Cheat Sheet Series](https://cheatsheetseries.owasp.org/)
