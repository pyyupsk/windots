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

## 💻 My Setup

Here are the details of the tools and environment configurations I use:

- **Operating System**: Windows 11 💻
- **Window Manager**: [GlazeWM](https://github.com/glzr-io/glazewm) (Tiling Window Manager for efficient window handling) 🦊 _config included!_
- **Shell**: PowerShell 🦊 _config included!_
- **Terminal**: [WezTerm](https://wezfurlong.org/wezterm/) (GPU-accelerated cross-platform terminal) 🦊 _config included!_
- **Editor**: [Visual Studio Code](https://code.visualstudio.com/) (Lightweight and powerful source code editor) 🦊 _config included!_
- **Prompt**: [Starship](https://starship.rs/) (Minimal, fast cross-shell prompt) 🦊 _config included!_
- **Status Bar**: [Yasb](https://github.com/amnweb/yasb) (Yet Another Status Bar) 🦊 _config included!_
- **File Manager**: [Yazi](https://github.com/sxyazi/yazi) (a blazing fast terminal file manager)
- **Launcher**: [Flow Launcher](https://flowlauncher.com/) (a fast and customizable application launcher)

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
