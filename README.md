# FixSpellingShortcut - AI-Powered Text Correction

An intelligent macOS application that automatically fixes typos and grammatical errors in any text input using AI.

![2025-09-26 11 34 12](https://github.com/user-attachments/assets/0756c962-ba51-4459-9212-2c141ce08bd2)


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

1. **Clone this repository:**
   ```bash
   git clone <repository-url>
   cd FixSpellingShortcut
   ```

2. **Create virtual environment and install dependencies:**
   ```bash
   python3 -m venv venv
   ./venv/bin/pip install -r requirements.txt
   ```

3. **Set up your API key:**
   ```bash
   # Copy the environment template
   cp .env.example .env
   
   # Edit .env and add your Groq API key
   echo "GROQ_API_KEY=your_actual_groq_api_key_here" > .env
   ```
   
   Get your free API key at [groq.com](https://groq.com)

4. **Test the script:**
   ```bash
   ./venv/bin/python FixSpellingShortcut.py
   ```
   You should see:
   ```
   Starting FixSpellingShortcut...
   ✅ Accessibility permissions granted!
   ✅ Groq API Test Success!
   Listening for Cmd+Shift+L...
   ```
   Press `Ctrl+C` to stop the test.

5. **Set up auto-start on login:**
   ```bash
   ./setup_launchagent.sh
   ```
   This script automatically creates and loads a LaunchAgent for reliable auto-start.

6. **Grant macOS permissions:**
   
   The script needs two permissions:
   
   **a) Accessibility Permissions:**
   - Go to: **System Preferences > Security & Privacy > Privacy > Accessibility**
   - Click the lock and enter your password
   - Click "+" and add **Terminal** (or your Python app)
   - Ensure it's checked ✅
   
   **b) Input Monitoring (if prompted):**
   - Go to: **System Preferences > Security & Privacy > Privacy > Input Monitoring**
   - Add **Terminal** if macOS requests it
   
   💡 **Tip:** If permissions fail, try running the script directly first:
   ```bash
   python FixSpellingShortcut.py
   ```
   This will trigger permission prompts.

## Usage

1. **Start FixSpellingShortcut (if not auto-starting):**
   ```bash
   ./start_fixspelling.sh
   ```

2. **Use in any application:**
   - Type some text with typos
   - Press `Cmd+Shift+L` to trigger correction
   - The text will be automatically corrected in place

3. **Example:**
   ```
   Before: "This is a mesage with speling mistakes"
   After:  "This is a message with spelling mistakes"
   ```

## Manual Control

```bash
# Check if running
ps aux | grep FixSpellingShortcut.py

# Stop/Start (after setup_launchagent.sh)
launchctl unload ~/Library/LaunchAgents/com.user.fixspellingshortcut.plist  # Stop
launchctl load ~/Library/LaunchAgents/com.user.fixspellingshortcut.plist    # Start

# Emergency stop (kills all instances)
pkill -f "FixSpellingShortcut.py"
```

## Troubleshooting

### Common Issues

**1. Multiple pastes when using hotkey:**
- **Cause:** Multiple instances running
- **Fix:** Kill all instances and restart:
  ```bash
  pkill -f "FixSpellingShortcut.py"
  launchctl unload ~/Library/LaunchAgents/com.user.fixspellingshortcut.plist
  launchctl load ~/Library/LaunchAgents/com.user.fixspellingshortcut.plist
  ```

**2. VS Code opens automatically on startup:**
- **Cause:** Script file is in VS Code's recent files and you have Login Items
- **Fix:** Use LaunchAgent instead of Login Items, or clear VS Code's recent files

**3. "There is no text to fix" message:**
- **Cause:** Text selection not working (permissions issue)
- **Fix:** 
  1. Check accessibility permissions in System Preferences
  2. Make sure you have text selected or cursor positioned in text
  3. Check logs: `tail -f ~/FixSpellingShortcut/fixspelling.log`

**4. Import errors or Python module issues:**
- **Cause:** Wrong Python environment
- **Fix:** Make sure LaunchAgent uses the virtual environment path

**5. Hotkey not working:**
- **Check if script is running:** `ps aux | grep FixSpellingShortcut.py`
- **Test manually:** Run `./venv/bin/python FixSpellingShortcut.py` to see startup messages
- **Check logs:** Look at `fixspelling.log` and `fixspelling_error.log`

## Configuration

### Custom Hotkey

To change the hotkey, modify the key detection in `FixSpellingShortcut.py`:

```python
# Current: Cmd+Shift+L
if (cmd_pressed and shift_pressed and 
    hasattr(key, 'char') and key.char == 'l'):
    # Change 'l' to your preferred key
```

### Excluded Applications

Add applications to skip in the `should_skip_app()` function in `FixSpellingShortcut.py`:

```python
excluded_apps = [
    "Cursor",
    "Visual Studio Code",
    "Your App Name",  # Add your apps here
]
```

### Environment Variables

Edit your `.env` file to customize:

```bash
# Your Groq API key
GROQ_API_KEY=your_actual_api_key_here
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
- Check logs at `~/FixSpellingShortcut.log` for troubleshooting

## Acknowledgments

- Built with [Groq](https://groq.com) for fast AI inference
- Uses [pynput](https://github.com/moses-palmer/pynput) for keyboard automation
