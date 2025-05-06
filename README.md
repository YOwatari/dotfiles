# It's my dotfiles

## Installation

1. **Install chezmoi:** Follow the official installation guide: [https://www.chezmoi.io/install/](https://www.chezmoi.io/install/)
2. **Initialize chezmoi with this repository:**

    ```bash
    chezmoi init https://github.com/YOwatari/dotfiles.git
    ```

3. **Apply the configuration:**
    Review the changes chezmoi will make:

    ```bash
    chezmoi diff
    ```

    Apply the changes:

    ```bash
    chezmoi apply
    ```

## Prerequisites (Example for macOS)

Some configurations might require specific tools to be installed beforehand. For example, on macOS:

```bash
# Install Xcode Command Line Tools if not already installed
xcode-select --install

# Install Homebrew (if used for package management)
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
