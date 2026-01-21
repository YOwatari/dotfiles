# Testing Standards

テスト駆動開発（TDD）で守るべき基準と規則

## TDD基本原則

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
✅ Always: Tests can run in any order
```

### Commit at GREEN

```text
✅ Always: Commit after each passing test
❌ Never: Commit with failing tests
❌ Never: Skip commits during TDD cycle
```

## 禁止事項

### Never Skip RED Phase

```javascript
// ❌ Never write implementation without failing test
function calculateTotal(items) {
  return items.reduce((sum, item) => sum + item.price, 0)
}

// ✅ Always write test first
test("should calculate total of items", () => {
  const items = [{ price: 10 }, { price: 20 }]
  expect(calculateTotal(items)).toBe(30)
})
// Run test → FAIL → then implement
```

### Never Test Implementation Details

```javascript
// ❌ Never test private methods
test("should call _internalValidation", () => {
  const service = new UserService()
  const spy = jest.spyOn(service, '_internalValidation')
  service.createUser(data)
  expect(spy).toHaveBeenCalled()
})

// ✅ Always test public interface
test("should reject invalid user data", () => {
  const service = new UserService()
  expect(() => service.createUser(invalidData))
    .toThrow('Invalid user data')
})
```

### Never Have Test Interdependence

```javascript
// ❌ Never depend on previous test
let user
test("create user", () => {
  user = createUser()
})
test("update user", () => {
  updateUser(user)  // Depends on previous test!
})

// ✅ Always be independent
test("update user", () => {
  const user = createTestUser()  // Own setup
  updateUser(user)
})
```

### Never Skip REFACTOR Phase

```javascript
// ❌ Never leave duplicated code
function calculateTotalWithTax(items, taxRate) {
  let total = 0
  for (const item of items) {
    total += item.price
  }
  return total * (1 + taxRate)
}

function calculateTotalWithDiscount(items, discount) {
  let total = 0
  for (const item of items) {
    total += item.price
  }
  return total * (1 - discount)
}

// ✅ Always refactor to remove duplication
function calculateSubtotal(items) {
  return items.reduce((sum, item) => sum + item.price, 0)
}

function calculateTotalWithTax(items, taxRate) {
  return calculateSubtotal(items) * (1 + taxRate)
}

function calculateTotalWithDiscount(items, discount) {
  return calculateSubtotal(items) * (1 - discount)
}
```

## テスト構造

### Naming Convention

```javascript
// ✅ Required format: should_[expected]_when_[condition]
test("should return empty array when no items exist", () => {})
test("should throw error when invalid input provided", () => {})
test("should calculate total when items have valid prices", () => {})

// ✅ Alternative format: [unit]_[scenario]_[expected]
test("calculateTotal_withValidItems_returnsCorrectSum", () => {})
test("createUser_withInvalidEmail_throwsError", () => {})
```

### AAA Pattern (Required)

```javascript
test("should calculate total with tax", () => {
  // Arrange: Set up test data
  const items = [{ price: 100 }, { price: 200 }]
  const taxRate = 0.1

  // Act: Execute the behavior
  const total = calculateTotal(items, taxRate)

  // Assert: Verify the outcome
  expect(total).toBe(330)
})
```

## カバレッジ要件

### Minimum Thresholds

| Type | Minimum | Target |
|------|---------|--------|
| Overall | 80% | 90% |
| Business Logic | 90% | 100% |
| Critical Paths | 100% | 100% |

### What to Test (Required)

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

### Fast
```text
✅ Unit tests: < 10ms each
⚠️ Integration tests: < 1s each
❌ Slow tests block TDD cycle
```

### Independent
```text
✅ Can run in any order
✅ Can run in parallel
❌ Never share state between tests
```

### Repeatable
```text
✅ Same result every time
✅ No dependency on external state
❌ Never depend on current date/time
❌ Never depend on network/database
```

### Self-Validating
```text
✅ Clear pass/fail (boolean)
❌ Never require manual inspection
❌ Never log output without assertion
```

### Timely
```text
✅ Written before implementation
❌ Never written after implementation
```

## よくある間違い

### Brittle Assertions

```javascript
// ❌ Never: Exact string matching
expect(error.message).toBe("Invalid input: expected number, got string")

// ✅ Always: Flexible matching
expect(error.message).toContain("Invalid input")
```

### No Assertions

```javascript
// ❌ Never: Test without assertions
test("should process order", () => {
  processOrder(order)  // No expect!
})

// ✅ Always: Verify outcome
test("should process order", () => {
  const result = processOrder(order)
  expect(result.status).toBe('processed')
})
```

### Testing Everything

```javascript
// ❌ Never: Test trivial getters
test("getName returns name", () => {
  const user = new User("John")
  expect(user.getName()).toBe("John")
})

// ✅ Always: Test meaningful behavior
test("should format full name correctly", () => {
  const user = new User("John", "Doe")
  expect(user.getFullName()).toBe("John Doe")
})
```

## 承認基準

### TDD Compliance

- ✅ **Pass**: All tests written first, all passing, coverage > 80%
- ⚠️ **Warning**: Some tests after code, coverage 70-80%
- ❌ **Fail**: No tests, or tests written after, or coverage < 70%

### Test Quality Gates

| Criterion | Threshold | Action |
|-----------|-----------|--------|
| Coverage | < 80% | ❌ Block merge |
| Test failures | Any | ❌ Block merge |
| Slow tests | > 1s (unit) | ⚠️ Review needed |
| Test interdependence | Any | ❌ Block merge |
| Missing edge cases | Any | ⚠️ Review needed |
