# FixSpellingShortcut - AI-Powered Text Correction

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

1. **Clone this repository:**
   ```bash
   git clone <repository-url>
   cd FixSpellingShortcut
   ```

2. **Install Python dependencies:**
   ```bash
   pip install -r requirements.txt
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
   python FixSpellingShortcut.py
   ```
   You should see:
   ```
   Starting FixSpellingShortcut...
   ✅ Accessibility permissions granted!
   ✅ Groq API Test Success!
   Listening for Cmd+Shift+L...
   ```
   Press `Ctrl+C` to stop the test.

5. **Set up auto-start service:**
   ```bash
   # Copy the launch agent
   cp com.user.fixspellingshortcut.plist ~/Library/LaunchAgents/
   
   # Make management script executable
   chmod +x manage_fixspellingshortcut.sh
   
   # Start the service
   ./manage_fixspellingshortcut.sh start
   ```

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

1. **Start the service:**
   ```bash
   ./manage_fixspellingshortcut.sh start
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

## Service Management

Use the included management script:

```bash
./manage_fixspellingshortcut.sh start    # Start the service
./manage_fixspellingshortcut.sh stop     # Stop the service
./manage_fixspellingshortcut.sh restart  # Restart after changes
./manage_fixspellingshortcut.sh status   # Check if running
./manage_fixspellingshortcut.sh logs     # View recent logs
```

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
- Check logs with `./manage_fixkey.sh logs` for troubleshooting

## Acknowledgments

- Built with [Groq](https://groq.com) for fast AI inference
- Uses [pynput](https://github.com/moses-palmer/pynput) for keyboard automation
