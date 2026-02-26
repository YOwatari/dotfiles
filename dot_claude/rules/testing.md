# Testing Standards

テスト品質の基準としきい値。TDD の対話的プロセスは `skills/test-driven-development` を参照。

## TDD 基本原則

### Test-First Always

```text
❌ Never: Write implementation first
✅ Always: Write test first, see it fail, then implement
```

### RED-GREEN-REFACTOR Cycle

```text
1. RED: Write failing test (MUST fail for right reason)
2. GREEN: Write minimum code to pass (MUST pass)
3. REFACTOR: Improve code (tests MUST stay green)
```

### One Test at a Time

```text
❌ Never: Write multiple tests before implementation
✅ Always: One test → implement → next test
```

### Test Independence

```text
❌ Never: Tests depend on execution order
❌ Never: Tests share mutable state
✅ Always: Each test is completely independent
```

### Commit at GREEN

```text
✅ Always: Commit after each passing test
❌ Never: Commit with failing tests
```

## 禁止事項

### Skip RED Phase

```javascript
// ❌ Never write implementation without failing test
function calculateTotal(items) {
  return items.reduce((sum, item) => sum + item.price, 0)
}

// ✅ Always write test first, run, see FAIL, then implement
test("should calculate total of items", () => {
  const items = [{ price: 10 }, { price: 20 }]
  expect(calculateTotal(items)).toBe(30)
})
```

### Test Implementation Details

```javascript
// ❌ Never test private methods
test("should call _internalValidation", () => {
  const spy = jest.spyOn(service, '_internalValidation')
  service.createUser(data)
  expect(spy).toHaveBeenCalled()
})

// ✅ Always test public interface
test("should reject invalid user data", () => {
  expect(() => service.createUser(invalidData))
    .toThrow('Invalid user data')
})
```

### Test Interdependence

```javascript
// ❌ Never depend on previous test
let user
test("create user", () => { user = createUser() })
test("update user", () => { updateUser(user) })  // Depends!

// ✅ Always be independent
test("update user", () => {
  const user = createTestUser()  // Own setup
  updateUser(user)
})
```

## テスト構造

### Naming Convention

```javascript
// ✅ Format: should_[expected]_when_[condition]
test("should return empty array when no items exist", () => {})
test("should throw error when invalid input provided", () => {})

// ✅ Alternative: [unit]_[scenario]_[expected]
test("calculateTotal_withValidItems_returnsCorrectSum", () => {})
```

### AAA Pattern (Required)

```javascript
test("should calculate total with tax", () => {
  // Arrange
  const items = [{ price: 100 }, { price: 200 }]
  const taxRate = 0.1

  // Act
  const total = calculateTotal(items, taxRate)

  // Assert
  expect(total).toBe(330)
})
```

## カバレッジ要件

| Type | Minimum | Target |
|------|---------|--------|
| Overall | 80% | 90% |
| Business Logic | 90% | 100% |
| Critical Paths | 100% | 100% |

### What to Test

✅ **Must Test**:
- Business logic and rules
- Edge cases and boundaries
- Error handling
- State transitions
- Public interfaces

❌ **Don't Test**:
- Private implementation details
- Framework/library code
- Trivial getters/setters
- External services (mock instead)

## テスト品質 (FIRST Principles)

| Principle | Requirement |
|-----------|-------------|
| **Fast** | Unit: < 10ms, Integration: < 1s |
| **Independent** | Any order, parallel safe |
| **Repeatable** | Same result every time |
| **Self-Validating** | Clear pass/fail |
| **Timely** | Written before implementation |

## 承認基準

### TDD Compliance

| Status | Criteria |
|--------|----------|
| ✅ Pass | Tests first, all passing, coverage > 80% |
| ⚠️ Warning | Some tests after, coverage 70-80% |
| ❌ Fail | No tests, tests after, coverage < 70% |

### Quality Gates

| Criterion | Threshold | Action |
|-----------|-----------|--------|
| Coverage | < 80% | ❌ Block merge |
| Test failures | Any | ❌ Block merge |
| Slow tests | > 1s (unit) | ⚠️ Review |
| Interdependence | Any | ❌ Block merge |
| Missing edge cases | Any | ⚠️ Review |
