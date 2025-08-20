# FixKey - AI-Powered Text Correction

An intelligent macOS application that automatically fixes typos and grammatical errors in any text input using AI.

## Features

- 🚀 **System-wide hotkey** (`Cmd+Shift+L`) for instant text correction
- 🤖 **AI-powered corrections** using Groq API with Llama model
- 📱 **Multi-app support** - Works in browsers, chat apps, text editors, and more
- ⚡ **Fast operation** - Optimized for speed with minimal delays
- 🎯 **Smart selection** - Handles single-line and multi-line text
- 🔒 **Privacy-focused** - Only sends text to AI when explicitly triggered

## Supported Applications

- **Browsers**: Chrome, Safari, Firefox, Edge (including LinkedIn, etc.)
- **Chat Apps**: Beeper Desktop, and more
- **Text Editors**: Goodnotes, Obsidian, and others
- **Email**: Airmail, MailMate
- **General**: Any text input that supports standard keyboard shortcuts

## Installation

### Prerequisites

- macOS
- Python 3.7+
- Groq API key (free at [groq.com](https://groq.com))

### Setup

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd fixkey-project
   ```

2. Install dependencies:
   ```bash
   pip install pynput pyperclip requests
   ```

3. Get your Groq API key and update `fixkey.py`:
   ```python
   GROQ_API_KEY = "your_groq_api_key_here"
   ```

4. Set up the launch agent for auto-start:
   ```bash
   cp com.user.fixkey.plist ~/Library/LaunchAgents/
   chmod +x manage_fixkey.sh
   ./manage_fixkey.sh start
   ```

5. Grant accessibility permissions:
   - Go to System Preferences > Security & Privacy > Privacy > Accessibility
   - Add your Terminal (or Python) to the allowed applications

## Usage

1. Start the service: `./manage_fixkey.sh start`
2. In any application, type some text with typos
3. Press `Cmd+Shift+L` to trigger correction
4. The text will be automatically corrected in place

## Service Management

Use the included management script:

```bash
./manage_fixkey.sh start    # Start the service
./manage_fixkey.sh stop     # Stop the service
./manage_fixkey.sh restart  # Restart the service
./manage_fixkey.sh status   # Check status
./manage_fixkey.sh logs     # View logs
```

## Configuration

### Custom Hotkey

To change the hotkey, modify the key detection in `fixkey.py`:

```python
# Current: Cmd+Shift+L
if (cmd_pressed and shift_pressed and 
    hasattr(key, 'char') and key.char == 'l'):
```

### Excluded Applications

Add applications to skip in the `should_skip_app()` function:

```python
excluded_apps = [
    "Cursor",
    "Visual Studio Code",
    # Add your apps here
]
```

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

[Choose appropriate license - MIT, GPL, etc.]

## Support

- Create an issue for bugs or feature requests
- Check logs with `./manage_fixkey.sh logs` for troubleshooting

## Acknowledgments

- Built with [Groq](https://groq.com) for fast AI inference
- Uses [pynput](https://github.com/moses-palmer/pynput) for keyboard automation
