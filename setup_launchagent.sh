#!/bin/bash

# FixSpellingShortcut LaunchAgent Setup Script
# This script creates and loads a LaunchAgent for automatic startup

set -e  # Exit on any error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLIST_FILE="$HOME/Library/LaunchAgents/com.user.fixspellingshortcut.plist"

echo "🚀 Setting up FixSpellingShortcut LaunchAgent..."

# Check if virtual environment exists
if [ ! -d "$SCRIPT_DIR/venv" ]; then
    echo "❌ Error: Virtual environment not found at $SCRIPT_DIR/venv"
    echo "Please run the setup steps first:"
    echo "  python3 -m venv venv"
    echo "  ./venv/bin/pip install -r requirements.txt"
    exit 1
fi

# Check if script exists
if [ ! -f "$SCRIPT_DIR/FixSpellingShortcut.py" ]; then
    echo "❌ Error: FixSpellingShortcut.py not found"
    exit 1
fi

# Remove old LaunchAgent if it exists
if [ -f "$PLIST_FILE" ]; then
    echo "📄 Removing existing LaunchAgent..."
    launchctl unload "$PLIST_FILE" 2>/dev/null || true
    rm "$PLIST_FILE"
fi

# Remove old "fixkey" LaunchAgent if it exists (cleanup from old versions)
OLD_PLIST="$HOME/Library/LaunchAgents/com.user.fixkey.plist"
if [ -f "$OLD_PLIST" ]; then
    echo "🧹 Cleaning up old LaunchAgent..."
    launchctl unload "$OLD_PLIST" 2>/dev/null || true
    rm "$OLD_PLIST"
fi

# Create new LaunchAgent plist file
echo "📝 Creating LaunchAgent plist file..."
cat > "$PLIST_FILE" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.fixspellingshortcut</string>
    
    <key>ProgramArguments</key>
    <array>
        <string>$SCRIPT_DIR/venv/bin/python</string>
        <string>$SCRIPT_DIR/FixSpellingShortcut.py</string>
    </array>
    
    <key>RunAtLoad</key>
    <true/>
    
    <key>KeepAlive</key>
    <true/>
    
    <key>StandardOutPath</key>
    <string>$SCRIPT_DIR/fixspelling.log</string>
    
    <key>StandardErrorPath</key>
    <string>$SCRIPT_DIR/fixspelling_error.log</string>
    
    <key>WorkingDirectory</key>
    <string>$SCRIPT_DIR</string>
    
    <key>EnvironmentVariables</key>
    <dict>
        <key>PATH</key>
        <string>/usr/local/bin:/usr/bin:/bin</string>
    </dict>
</dict>
</plist>
EOF

echo "✅ LaunchAgent plist file created at $PLIST_FILE"

# Load the LaunchAgent
echo "🔄 Loading LaunchAgent..."
launchctl load "$PLIST_FILE"

# Wait a moment for it to start
sleep 2

# Check if it's running
if ps aux | grep -q "[F]ixSpellingShortcut.py"; then
    echo "✅ FixSpellingShortcut is now running!"
    echo ""
    echo "🎉 Setup complete! The script will now:"
    echo "   - Start automatically when you log in"
    echo "   - Listen for Cmd+Shift+L hotkey"
    echo "   - Fix typos in any application"
    echo ""
    echo "📋 Useful commands:"
    echo "   Stop:  launchctl unload ~/Library/LaunchAgents/com.user.fixspellingshortcut.plist"
    echo "   Start: launchctl load ~/Library/LaunchAgents/com.user.fixspellingshortcut.plist"
    echo "   Check: ps aux | grep FixSpellingShortcut.py"
    echo "   Logs:  tail -f $SCRIPT_DIR/fixspelling.log"
else
    echo "⚠️  Warning: Script may not be running. Check the logs:"
    echo "   tail $SCRIPT_DIR/fixspelling.log"
    echo "   tail $SCRIPT_DIR/fixspelling_error.log"
fi