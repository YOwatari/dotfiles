# Refactoring Patterns

Reusable refactoring patterns for improving code structure

## Common Refactoring Patterns

### Extract Method/Function

**Purpose**: Extract logical units from long methods

**When to use**:
- Method exceeds 20-30 lines
- Logical blocks can be named meaningfully
- Code reuse opportunity exists

**Example**:
```text
Before:
def process_order(order):
    # validation logic (10 lines)
    # calculation logic (15 lines)
    # save logic (10 lines)

After:
def process_order(order):
    validate_order(order)
    total = calculate_total(order)
    save_order(order, total)
```

### Extract Class/Module

**Purpose**: Separate responsibilities from bloated classes

**When to use**:
- Class has > 10-15 methods
- Clear subset of methods work with same data
- Single Responsibility Principle violation

**Example**:
```text
Before:
class User:
    def save()
    def validate()
    def send_email()
    def format_name()
    def calculate_age()

After:
class User:
    def save()
    def validate()

class UserMailer:
    def send_email()

class UserFormatter:
    def format_name()
    def calculate_age()
```

### Inline Method

**Purpose**: Eliminate excessive indirection

**When to use**:
- Method body is as clear as method name
- Method is only called once
- Layer of indirection adds no value

**Example**:
```text
Before:
def get_rating():
    return more_than_five_late_deliveries()

def more_than_five_late_deliveries():
    return self.late_deliveries > 5

After:
def get_rating():
    return self.late_deliveries > 5
```

### Rename Variable/Function/Class

**Purpose**: Change to names that clearly convey intent

**When to use**:
- Name doesn't reflect purpose
- Abbreviations are unclear
- Name became misleading after changes

**Example**:
```text
Before: def calc(x, y)
After:  def calculate_total_price(unit_price, quantity)
```

### Replace Nested Conditionals with Guard Clauses

**Purpose**: Reduce nesting depth and improve readability

**When to use**:
- Multiple levels of nested if statements
- Early return possible for edge cases
- Main logic buried in nested blocks

**Example**:
```text
Before:
if valid:
    if authorized:
        if has_stock:
            process()

After:
if not valid: return
if not authorized: return
if not has_stock: return
process()
```

### Replace Conditional with Polymorphism

**Purpose**: Replace type-based branching with polymorphism

**When to use**:
- Switch/if-else on object type
- Same behavior selection pattern repeated
- New types require code changes

**Example**:
```text
Before:
if type == "dog":
    make_bark_sound()
elif type == "cat":
    make_meow_sound()

After:
class Dog:
    def make_sound(): return "bark"

class Cat:
    def make_sound(): return "meow"

animal.make_sound()
```

## Code Smell Detection

Signs of code problems and their thresholds:

### Bloaters

Bloated code that indicates problems:

| Smell | Indicator | Threshold |
| ------- | ----------- | ----------- |
| Long Method | Line count | > 20-30 lines |
| Large Class | Method count | > 10-15 methods |
| Long Parameter List | Param count | > 3-4 params |
| Primitive Obsession | Overuse of primitives | Ungrouped related data |

### Couplers

Signs of inappropriate coupling:

| Smell | Indicator | Threshold |
| ------- | ----------- | ----------- |
| Feature Envy | Heavy use of other class data | More external than internal refs |
| Inappropriate Intimacy | Dependency on other class internals | Access to private/internal |
| Message Chains | Chained method calls | a.b().c().d() |

### Dispensables

Signs of unnecessary code:

| Smell | Indicator | Threshold |
| ------- | ----------- | ----------- |
| Dead Code | Unused code | No callers |
| Duplicate Code | Duplication | Same logic 3+ times |
| Speculative Generality | Over-generalization | Unused abstractions |
| Comments | Excessive comments | Content expressible in code |

## Dead Code Detection

### Search Patterns

Patterns for detecting unused code:

```bash
# Detect unused functions/methods
grep -r "def function_name" --include="*.py"
grep -r "function_name(" --include="*.py"

# Unused imports
# Check IDE/Linter warnings

# Unused variables
# Use static analysis tools
```

### Safe Removal Process

Safe removal process:

1. Search for usage (Grep/Glob)
2. Check test references
3. Check dynamic calls (reflection, etc.)
4. Mark as removal candidate (TODO/DEPRECATED)
5. Remove after certain period
6. Verify with test execution

## Refactoring Report Template

```markdown
# Refactoring Report: [TARGET CODE/MODULE]

## Current State Assessment

### Metrics
- Total Lines: X
- Avg Method Length: X lines
- Max Method Length: X lines
- Cyclomatic Complexity: X (target: < 10)
- Test Coverage: X%

### Code Smells Detected
| Smell | Location | Severity |
|-------|----------|----------|
| [Smell] | file:line | High/Med/Low |

## Refactoring Plan

### Phase 1: Quick Wins (Low Risk)
#### 1.1 [Refactoring Name]
- **Location**: `file:line`
- **Pattern**: [Extract Method / Rename / etc.]
- **Before**: [Current problem]
- **After**: [Improved state]
- **Risk**: Low
- **Tests Required**: [Required tests]

### Phase 2: Structural Changes (Medium Risk)
...

### Phase 3: Architectural Changes (High Risk)
...

## Dead Code Candidates
| Code | Location | Last Used | Confidence |
| ------ | ---------- | ----------- | ------------ |
| [name] | file:line | Never/Date | High/Med/Low |

## Estimated Impact
- Lines Removed: X
- Complexity Reduction: X%
- Maintainability Improvement: [Description]

## Prerequisites
- [ ] Test coverage X% or higher
- [ ] Automated tests in CI/CD
- [ ] Rollback procedure confirmed

## Risks and Mitigations
| Risk | Probability | Mitigation |
| ------ | ------------- | ------------ |
| [Risk] | Low/Med/High | [Mitigation] |
```

## Safety Guidelines

Checklist before and after refactoring:

### Before Refactoring

- Tests exist and pass
- Understand scope of change impact
- Can rollback
- Have time margin (avoid near deadlines)

### During Refactoring

- Only one change at a time
- Run tests after each change
- Don't mix feature changes with refactoring
- Commit small

### After Refactoring

- All tests pass
- No performance degradation
- Code review completed
- Documentation updated
