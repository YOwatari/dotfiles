# Coding Style & Quality Standards

コーディングスタイル、コード品質、リファクタリング、パフォーマンス最適化の包括的なガイドライン

## 命名規則

### Variables & Functions
- Use descriptive, clear names
- camelCase for variables and functions
- Avoid abbreviations unless standard (e.g., API, URL)

### Classes & Components
- PascalCase
- Noun-based names

### Constants
- UPPER_SNAKE_CASE
- Descriptive, not abbreviated

### Boolean Variables
- Prefix with `is`, `has`, `should`, `can`
- Examples: `isValid`, `hasPermission`, `shouldRetry`

## 禁止事項とアンチパターン

### Magic Numbers

```javascript
// ❌ Don't allow
if (status === 3) { }

// ✅ Require
const STATUS_APPROVED = 3
if (status === STATUS_APPROVED) { }
```

### Duplicate Code

```javascript
// ❌ Don't allow
function formatUserName(user) {
  return user.firstName + " " + user.lastName
}
function formatAdminName(admin) {
  return admin.firstName + " " + admin.lastName
}

// ✅ Require
function formatFullName(person) {
  return person.firstName + " " + person.lastName
}
```

### Deep Nesting

```javascript
// ❌ Don't allow (>3 levels)
if (a) {
  if (b) {
    if (c) {
      if (d) { }
    }
  }
}

// ✅ Require guard clauses
if (!a) return
if (!b) return
if (!c) return
if (d) { }
```

### God Objects

```javascript
// ❌ Don't allow classes doing everything
class UserManager {
  createUser() { }
  deleteUser() { }
  sendEmail() { }
  validateInput() { }
  formatDate() { }
  calculateTax() { }
}

// ✅ Require separated responsibilities
class UserService { }
class EmailService { }
class ValidationService { }
```

## コード品質しきい値

### Function/Method Size

| Lines | Action |
|-------|--------|
| > 30 | ⚠️ Consider splitting |
| > 50 | ❌ Must split |

```javascript
// ❌ Never allow functions > 50 lines
function processOrder(order) {
  // 80 lines of code...
}

// ✅ Require extraction
function processOrder(order) {
  validateOrder(order)
  calculateTotal(order)
  applyDiscounts(order)
  processPayment(order)
  sendConfirmation(order)
}
```

### Cyclomatic Complexity

| Complexity | Action |
|------------|--------|
| > 10 | ⚠️ Review needed |
| > 15 | ❌ Must simplify |

### Class Size

| Methods | Action |
|---------|--------|
| > 10 | ⚠️ Review responsibilities |
| > 15 | ❌ Must split |

### Code Duplication

| Instances | Action |
|-----------|--------|
| 2x | ⚠️ Monitor |
| 3x | ❌ Must extract |

## リファクタリング基準

### Tests First

```text
❌ Never: Refactor without tests
✅ Always: Ensure 80%+ test coverage before refactoring
✅ Always: All tests passing before starting
```

### Behavior Preservation

```text
✅ Always: External behavior must not change
✅ Always: All tests must stay green
❌ Never: Mix refactoring with feature changes
```

### Small Steps

```text
✅ Always: One refactoring at a time
✅ Always: Commit after each small improvement
❌ Never: Large, sweeping changes
```

### Never Mix Refactoring with Features

```javascript
// ❌ Never combine in one commit
// Commit: "Refactor UserService and add email validation"
function createUser(data) {
  // Refactored structure
  validateUser(data)
  validateEmail(data.email)  // NEW FEATURE!
  return saveUser(data)
}

// ✅ Always separate commits
// Commit 1: "Refactor: Extract validateUser method"
// Commit 2: "Feature: Add email validation"
```

### Refactoring Safety Checklist

#### Before Refactoring
- [ ] All tests passing
- [ ] Test coverage > 80%
- [ ] Understand scope of changes
- [ ] Can rollback if needed
- [ ] Not near deadline/release

#### During Refactoring
- [ ] One change at a time
- [ ] Run tests after each change
- [ ] Not mixing with feature work
- [ ] Committing small increments

#### After Refactoring
- [ ] All tests still passing
- [ ] No performance degradation
- [ ] Code review completed
- [ ] Documentation updated
- [ ] No new warnings/errors

## コードレビュー基準

### Must Check (必ずチェック)

#### 1. Correctness
- Logic meets requirements
- Edge cases are handled
- Error handling is appropriate
- Boundary conditions are checked

#### 2. Performance
- No N+1 problems
- No unnecessary loops/calculations
- Appropriate data structures used
- No memory leak potential

#### 3. Maintainability
- Code is readable
- Naming is clear and consistent
- Functions/methods have single responsibility
- No duplicate code
- No magic numbers/hardcoded values

#### 4. Documentation
- Complex logic has comments
- Public APIs are documented
- TODOs/FIXMEs are trackable

### Output Format

#### Per-Issue Format

```text
[SEVERITY] Short issue title
File: path/to/file.ext:line
Issue: Brief description of the problem
Fix: How to resolve it
<bad code>   // ❌
<good code>  // ✅
```

#### Severity Levels

- **CRITICAL**: Must fix
  - Production failure, security vulnerability, data loss risk
- **HIGH**: Strongly recommend fix
  - Bug, performance issue, important best practice violation
- **MEDIUM**: Recommend fix
  - Code quality, readability, maintainability issues
- **LOW**: Suggest consideration
  - Style, minor improvements
- **SUGGESTION**: Provided as reference
  - Better approach proposals

#### Summary Format

複数ファイルのレビュー時は末尾にサマリを必ず追加：

```text
---
Summary: 12 issues (2 critical, 3 high, 5 medium, 2 low)
Priority: Fix critical issues in auth module first
```

### Approval Criteria

#### Decision Framework

- ✅ **Approve**: No critical or high-priority issues
- ⚠️ **Conditional**: Medium-priority issues only
- ❌ **Block**: Critical or high-priority issues present

#### Thresholds

| Metric | Threshold | Action |
|--------|-----------|--------|
| Function size | > 30 lines | Flag as MEDIUM |
| Cyclomatic complexity | > 10 | Flag as HIGH |
| Code duplication | 3+ instances | Flag as MEDIUM |
| Test coverage | < 80% | Flag as HIGH |
| Security issue | Any | Flag as CRITICAL |

## Immutability (CRITICAL)

```text
✅ ALWAYS use const by default
⚠️ Use let only when reassignment is needed
❌ NEVER use var
```

## Error Handling

```javascript
// ✅ Always provide context
throw new Error(`Failed to process order ${orderId}: ${reason}`)

// ❌ Never throw generic errors
throw new Error('Error')
```

## Input Validation

```javascript
// ✅ Always validate at boundaries
function processUser(user) {
  if (!user || !user.email) {
    throw new Error('Invalid user data')
  }
  // ... process
}

// ❌ Never trust input
function processUser(user) {
  // Assumes user and email exist
  sendEmail(user.email)
}
```

## Common Pitfalls

### Over-Refactoring

```text
❌ Never: Refactor for perfection
❌ Never: Create abstractions for single use
✅ Always: Stop when code is clean enough
✅ Always: Refactor only when needed
```

### Premature Optimization

```text
❌ Never: Optimize without measurements
❌ Never: Sacrifice readability for performance
✅ Always: Profile before optimizing
✅ Always: Readability first, optimize if needed
```

### Breaking API Compatibility

```text
❌ Never: Change public APIs without versioning
❌ Never: Remove public methods without deprecation
✅ Always: Maintain backward compatibility
✅ Always: Deprecate before removal
```
