---
name: TDD Workflow
description: Test-Driven Development workflow definition
---

# Test-Driven Development (TDD) Workflow

テスト駆動開発のワークフロー定義

## TDD Cycle

```text
┌─────────────────────────────────────────────────┐
│                                                 │
│    ┌───────┐    ┌───────┐    ┌──────────┐       │
│    │  RED  │───▶│ GREEN │───▶│ REFACTOR │       │
│    └───────┘    └───────┘    └──────────┘       │
│        │                           │            │
│        └───────────────────────────┘            │
│                                                 │
└─────────────────────────────────────────────────┘

RED:      Write a failing test for the next behavior
GREEN:    Write minimum code to make test pass
REFACTOR: Improve code while keeping tests green
```

## Phase 1: RED

**Objective**: Write a failing test

### Steps

1. Identify the next smallest behavior to implement
2. Write a test that specifies this behavior
3. Run test - it MUST fail
4. Failure should be for the right reason (not syntax error)

### Checklist

- [ ] Test describes one specific behavior
- [ ] Test is independent of other tests
- [ ] Test fails for the expected reason
- [ ] Test name clearly describes the behavior

## Phase 2: GREEN

**Objective**: Make the test pass with minimum code

### Steps

1. Write the simplest code that makes test pass
2. Don't worry about elegance yet
3. Hardcoding is acceptable temporarily
4. Run test - it MUST pass

### Checklist

- [ ] All tests pass (including the new one)
- [ ] Code is minimal (no extra features)
- [ ] No refactoring yet (just make it work)

## Phase 3: REFACTOR

**Objective**: Improve code quality while maintaining tests

### Steps

1. Look for code smells
2. Remove duplication
3. Improve naming
4. Extract methods/functions
5. Run tests after each change - MUST stay green

### Checklist

- [ ] All tests still pass
- [ ] Code is more readable
- [ ] Duplication is removed
- [ ] Names clearly convey intent

## Test Structure

### Arrange-Act-Assert (AAA)

```text
test("should calculate total with tax", () => {
  // Arrange: Set up test data and conditions
  cart = new Cart()
  cart.add(item(100))

  // Act: Execute the behavior being tested
  total = cart.calculateTotal(taxRate: 0.1)

  // Assert: Verify the expected outcome
  expect(total).toBe(110)
})
```

### Given-When-Then (BDD Style)

```text
test("given empty cart, when item added, then cart has one item", () => {
  // Given
  cart = new Cart()

  // When
  cart.add(item)

  // Then
  expect(cart.count).toBe(1)
})
```

## Test Categories

### Unit Tests

- **Scope**: Single function/method in isolation
- **Speed**: Milliseconds
- **Mocking**: External dependencies mocked
- **Coverage Target**: 80%+ of business logic

### Integration Tests

- **Scope**: Multiple components together
- **Speed**: Seconds
- **Mocking**: External services only
- **Coverage Target**: Critical paths

### End-to-End Tests

- **Scope**: Full system from user perspective
- **Speed**: Seconds to minutes
- **Mocking**: None (real environment)
- **Coverage Target**: Happy paths + critical errors

## Test Quality Guidelines

### Good Test Characteristics (FIRST)

- ✅ **Fast** - Runs in milliseconds (unit tests)
- ✅ **Independent** - No dependency on other tests
- ✅ **Repeatable** - Same result every run
- ✅ **Self-validating** - Clear pass/fail
- ✅ **Timely** - Written before/with code

### Test Naming Convention

**Format Options**:
- `should_[expected]_when_[condition]`
- `[unit]_[scenario]_[expected]`

**Examples**:
- `should_return_empty_list_when_no_items`
- `should_throw_error_when_invalid_input`
- `calculateTotal_withDiscount_appliesCorrectly`

### What to Test

✅ **Do Test**:
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

## Coverage Guidelines

### Minimum Targets

- **Overall**: 80%
- **Business Logic**: 90%
- **Critical Paths**: 100%

### Measuring Coverage

- **Lines**: Basic metric, aim for 80%+
- **Branches**: Important for conditionals
- **Functions**: All public functions tested
- **Statements**: Similar to lines

### Coverage ≠ Quality

高いカバレッジは必要条件だが十分条件ではない。
意味のあるアサーションがなければ価値は低い。

❌ **High coverage, no assertions**:
```text
test("covers code", () => {
  calculate(1, 2)  // No expect!
})
```

✅ **Meaningful coverage**:
```text
test("calculates sum correctly", () => {
  result = calculate(1, 2)
  expect(result).toBe(3)
})
```

## Common Mistakes to Avoid

### Test Interdependence

❌ **Tests depend on execution order**:
```text
test("create user") { user = create() }
test("update user") { update(user) }  // Depends on previous
```

✅ **Each test is independent**:
```text
test("update user") {
  user = createTestUser()  // Own setup
  update(user)
}
```

### Testing Implementation

❌ **Testing private methods**:
```text
expect(obj._privateMethod()).toBe(x)
```

✅ **Testing through public interface**:
```text
expect(obj.publicMethod()).toBe(x)
```

### Brittle Assertions

❌ **Exact string matching**:
```text
expect(error.message).toBe("Invalid input: expected number, got string")
```

✅ **Flexible matching**:
```text
expect(error.message).toContain("Invalid input")
```

## Output Format

TDDサイクルの進行状況をシンプルに表示：

```text
[PHASE] Current TDD phase
Status: PASS / FAIL / PENDING
Test: Test description
File: test file path

Code:
<test or implementation code>
```

### Example Output

```text
[RED] Writing failing test
Status: FAIL (expected)
Test: should return user by ID
File: tests/user-service.test.ts

Code:
test("should return user by ID", () => {
  service = new UserService()
  user = service.getById("123")
  expect(user.id).toBe("123")
  expect(user.name).toBeDefined()
})

Run: npm test -- user-service
Expected: FAIL (getById not implemented)

---

[GREEN] Implementing to pass
Status: PASS
Test: should return user by ID
File: src/user-service.ts

Code:
class UserService {
  getById(id) {
    return this.repository.find(id)
  }
}

Run: npm test -- user-service
Result: PASS

---

[REFACTOR] Improving code
Status: PASS (maintained)
Change: Extract validation to separate method
File: src/user-service.ts

Before:
getById(id) {
  if (!id) throw new Error("ID required")
  return this.repository.find(id)
}

After:
getById(id) {
  this.validateId(id)
  return this.repository.find(id)
}

validateId(id) {
  if (!id) throw new Error("ID required")
}

Run: npm test -- user-service
Result: All tests still PASS
```

## Workflow Guidelines

TDDサイクルに従って段階的にコードを開発：

1. **Always start with RED** - Never write implementation first
2. **Keep cycles short** - Minutes, not hours
3. **One behavior per cycle** - Don't test multiple things
4. **Run tests frequently** - After every small change
5. **Commit at GREEN** - Each passing cycle is a save point

## Best Practices

- Write tests first, always
- Test behavior, not implementation
- Keep tests simple and focused
- Use descriptive test names
- Maintain fast test execution
- Isolate external dependencies
- Commit after each GREEN phase
