# Pyyupsk's Dotfiles 🚀

Welcome to **Pyyupsk's dotfiles repository**! This project is designed to automate and streamline the process of setting up a modern development environment on **Windows**, specifically for developers who want an efficient, customizable, and powerful setup.

## 🌟 Key Features

- **Automated Setup**: Quickly install and configure your development environment with a single PowerShell script.
- **Custom Configurations**: Pre-configured terminal emulator, prompt, code editor, and more.

## 🛠️ Prerequisites

Before running the installation, make sure you have the following installed:

- [Git](https://git-scm.com/) for cloning the repository.
- [PowerShell](https://docs.microsoft.com/en-us/powershell/) to run the installation scripts.

## ⚡ Quick Start

1. **Clone the repository** to your local machine:

   ```powershell
   git clone https://github.com/pyyupsk/dotfiles.git
   cd dotfiles
   ```

2. **Run the installation script** to set up your environment:

   ```powershell
   .\install\install.ps1
   ```

   This will install tools, set up configuration files, and run any necessary post-installation steps.

3. **Start using your newly configured environment**! 🎉

   You can now enjoy a modern, efficient, and powerful development setup tailored to your workflow.

## 📦 What’s Included?

This repository contains configurations for various tools and environments that help you get a fully functional development system up and running in no time:

### 1. **WezTerm** 🖥️

- Location: `wezterm/.wezterm.lua`
- [WezTerm](https://wezfurlong.org/wezterm/) is a GPU-accelerated, cross-platform terminal emulator that provides fast and beautiful terminal experiences.
- Configuration includes custom themes, key bindings, and font settings to create a smooth terminal experience.

### 2. **PowerShell Profile** ⚙️

- Location: `powershell/profile.ps1`
- A custom PowerShell profile that includes helpful aliases, environment settings, and productivity tweaks.
- This enhances the command-line experience with features like auto-completions and prompt customizations.

### 3. **Starship Prompt** 🚀

- Location: `starship/starship.toml`
- [Starship](https://starship.rs/) is a cross-shell prompt that provides a fast, minimal, and customizable command prompt.
- The configuration sets up a modern, informative, and minimalistic prompt for your terminal.

### 4. **VS Code** 📝

- Location: `vscode/settings.json` and `vscode/keybindings.json`
- [Visual Studio Code](https://code.visualstudio.com/) is a lightweight but powerful source code editor.
- Pre-configured settings for a productive development experience, including custom key bindings, theme, and extensions.

### 5. **GlazeWM** 🪟

- Location: `glazewm/config.yaml`
- [GlazeWM](https://github.com/lacymorrow/glaze-wm) is a tiling window manager for Windows, providing a highly efficient way to manage multiple windows.
- This configuration file allows for custom window layouts and behavior.

### 6. **Yasb** 🖌️

- Location: `yasb/config.yaml` and `yasb/styles.css`
- Yasb (Yet Another Status Bar) is a highly customizable status bar designed to provide key system information at a glance.
- This setup includes custom CSS styling and configuration for a sleek and functional status bar.

## ⚙️ Installation Details

- **Main Install Script**: The main installation script is located at `install/install.ps1`. This script automates the installation of all required tools and configurations.
- **Tool-Specific Installation**:
  - `install/install-tools.ps1`: Installs specific software and utilities (e.g., VS Code, Starship, WezTerm).
  - `install/post-install.ps1`: Handles any post-installation setup (e.g., additional configurations, environment variable setup).

## 🖼️ Screenshots

Check out how the environment looks in action:

![Pyyupsk's Desktop](.github/images/desktop.png)

## 📝 Troubleshooting

If you encounter any issues during installation or setup, here are a few tips:

- **Script Execution Policy**: Make sure your PowerShell script execution policy allows the running of local scripts. You may need to run the following command:

   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

- **Permissions**: Ensure you are running PowerShell as Administrator if some parts of the script require elevated permissions.
- **Dependencies**: Check that Git and PowerShell are properly installed and available in your system's PATH.

## 📬 Contact

For any questions, suggestions, or feedback, feel free to reach out:

- Email: [pyyupsk@proton.me](mailto:pyyupsk@proton.me)

## 📄 License

This repository is licensed under the [MIT License](LICENSE). Feel free to fork, modify, and use it for your personal or professional projects.

### 🛠️ Contributing

Contributions are welcome! If you'd like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new feature branch (`git checkout -b feature-branch`).
3. Make your changes and test thoroughly.
4. Submit a pull request.

## 🎉 Acknowledgements

Thanks to the open-source community for providing such powerful tools and resources!
