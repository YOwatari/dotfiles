---
name: Coding Standards & Code Review Guidelines
description: Coding standards and code review criteria
---

# Coding Standards & Code Review Guidelines

## Core Principles

Core principles for code:

1. **Readability First** - Code is read more than written
2. **Simplicity Over Cleverness** - Simple solutions beat clever ones
3. **DRY (Don't Repeat Yourself)** - Eliminate duplication
4. **YAGNI (You Aren't Gonna Need It)** - Don't add speculative features
5. **Single Responsibility** - Each function/class does one thing well

## Code Review Categories

### 1. Correctness

**Logic & Requirements**
- Logic meets requirements
- Edge cases are handled
- Error handling is appropriate
- Boundary conditions are checked

### 2. Security

**Critical Security Checks**
- Input validation exists
- Authentication/authorization is proper
- No hardcoded secrets
- No SQL injection vulnerabilities
- No sensitive data in logs

### 3. Performance

**Efficiency Checks**
- No N+1 problems
- No unnecessary loops/calculations
- Appropriate data structures used
- No memory leak potential

### 4. Maintainability

**Code Quality**
- Code is readable
- Naming is clear and consistent
- Functions/methods have single responsibility
- No duplicate code
- No magic numbers/hardcoded values

### 5. Testing

**Test Coverage**
- Tests are sufficient
- Edge case tests exist
- Tests are independent
- Tests are understandable

### 6. Documentation

**Documentation Standards**
- Complex logic has comments
- Public APIs are documented
- TODOs/FIXMEs are trackable

## Naming Conventions

### Variables & Functions

**Good naming**:
```javascript
// ✅ Clear, descriptive names
const userEmailAddress = "user@example.com"
const calculateTotalPrice = (items, taxRate) => { }
const isAuthenticated = true
```

**Poor naming**:
```javascript
// ❌ Ambiguous, abbreviated
const ue = "user@example.com"
const calc = (i, t) => { }
const flag = true
```

### Classes & Components

**Use PascalCase**:
```javascript
class UserService { }
class PaymentProcessor { }
const UserProfileCard = () => { }
```

### Constants

**Use UPPER_SNAKE_CASE**:
```javascript
const MAX_RETRY_ATTEMPTS = 3
const API_BASE_URL = "https://api.example.com"
const DEFAULT_TIMEOUT_MS = 5000
```

## Code Structure

### Function Size

**Keep functions small and focused**:
- Target: < 20-30 lines per function
- One level of abstraction per function
- Single responsibility

```javascript
// ✅ Small, focused functions
function processOrder(order) {
  validateOrder(order)
  const total = calculateTotal(order)
  saveOrder(order, total)
  notifyCustomer(order)
}

// ❌ Large, unfocused function
function processOrder(order) {
  // 100 lines of validation, calculation, saving, notification...
}
```

### Avoid Deep Nesting

**Use early returns and guard clauses**:
```javascript
// ✅ Guard clauses
function processUser(user) {
  if (!user) return
  if (!user.isActive) return
  if (!user.hasPermission) return

  performAction(user)
}

// ❌ Deep nesting
function processUser(user) {
  if (user) {
    if (user.isActive) {
      if (user.hasPermission) {
        performAction(user)
      }
    }
  }
}
```

### Error Handling

**Handle errors appropriately**:
```javascript
// ✅ Proper error handling
async function fetchUser(id) {
  try {
    const user = await api.getUser(id)
    return user
  } catch (error) {
    logger.error(`Failed to fetch user ${id}:`, error)
    throw new UserNotFoundError(id)
  }
}

// ❌ Silent failures
async function fetchUser(id) {
  try {
    const user = await api.getUser(id)
    return user
  } catch (error) {
    // Silent failure
  }
}
```

## Common Anti-Patterns

Anti-patterns to avoid:

### Magic Numbers

```javascript
// ❌ Magic numbers
if (status === 3) { }
setTimeout(callback, 5000)

// ✅ Named constants
const STATUS_APPROVED = 3
const TIMEOUT_MS = 5000

if (status === STATUS_APPROVED) { }
setTimeout(callback, TIMEOUT_MS)
```

### Duplicate Code

```javascript
// ❌ Duplication
function formatUserName(user) {
  return user.firstName + " " + user.lastName
}

function formatAdminName(admin) {
  return admin.firstName + " " + admin.lastName
}

// ✅ Reuse
function formatFullName(person) {
  return person.firstName + " " + person.lastName
}
```

### God Objects

```javascript
// ❌ God class doing everything
class UserManager {
  createUser() { }
  deleteUser() { }
  sendEmail() { }
  validateInput() { }
  formatDate() { }
  calculateTax() { }
}

// ✅ Separated responsibilities
class UserService { }
class EmailService { }
class ValidationService { }
class DateFormatter { }
class TaxCalculator { }
```

## Severity Levels & Approval Criteria

### Severity Definitions

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

### Approval Decision Framework

- ✅ **Approve**: No critical or high-priority issues
- ⚠️ **Conditional**: Medium-priority issues only
- ❌ **Block**: Critical or high-priority issues present

## Output Format

Output in the following flat format for each issue:

```text
[SEVERITY] Short issue title
File: path/to/file.ext:line
Issue: Brief description of the problem
Fix: How to resolve it
<bad code>   // ❌
<good code>  // ✅
```

### Example Output

```text
[CRITICAL] Hardcoded API key
File: src/api/client.ts:42
Issue: API key exposed in source code
Fix: Move to environment variable
const apiKey = "sk-abc123";  // ❌
const apiKey = process.env.API_KEY;  // ✅

[HIGH] N+1 query in loop
File: src/services/order.ts:78
Issue: Database query executed inside loop
Fix: Batch fetch before loop
for (item of items) { db.find(item.id) }  // ❌
const data = db.findMany(ids); // then loop  // ✅

[MEDIUM] Magic number
File: src/utils/calc.ts:23
Issue: Unclear meaning of numeric literal
Fix: Extract to named constant
if (status === 3) { ... }  // ❌
if (status === STATUS_APPROVED) { ... }  // ✅

[SUGGESTION] Consider early return
File: src/handlers/user.ts:56
Issue: Deep nesting reduces readability
Fix: Use guard clauses
```

### Summary Format

When reviewing multiple files, add a summary at the end:

```text
---
Summary: 12 issues (2 critical, 3 high, 5 medium, 2 low)
Priority: Fix critical issues in auth module first
```
