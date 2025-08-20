#!/bin/bash

PLIST_PATH="$HOME/Library/LaunchAgents/com.user.fixspellingshortcut.plist"
SERVICE_NAME="com.user.fixspellingshortcut"

case "$1" in
    start)
        echo "🚀 Starting FixSpellingShortcut service..."
        launchctl load "$PLIST_PATH"
        echo "✅ Service started!"
        ;;
    stop)
        echo "⏹️  Stopping FixSpellingShortcut service..."
        launchctl unload "$PLIST_PATH"
        echo "✅ Service stopped!"
        ;;
    restart)
        echo "🔄 Restarting FixSpellingShortcut service..."
        launchctl unload "$PLIST_PATH"
        launchctl load "$PLIST_PATH"
        echo "✅ Service restarted!"
        ;;
    status)
        echo "📊 Checking FixSpellingShortcut service status..."
        if launchctl list | grep -q "$SERVICE_NAME"; then
            echo "✅ Service is running"
            launchctl list | grep "$SERVICE_NAME"
        else
            echo "❌ Service is not running"
        fi
        ;;
    logs)
        echo "📋 Showing recent logs..."
        echo "=== Output logs ==="
        tail -n 20 ~/fixkey.log 2>/dev/null || echo "No output logs found"
        echo ""
        echo "=== Error logs ==="
        tail -n 20 ~/fixkey_error.log 2>/dev/null || echo "No error logs found"
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status|logs}"
        echo ""
        echo "Commands:"
        echo "  start   - Start the FixSpellingShortcut service"
        echo "  stop    - Stop the FixSpellingShortcut service"
        echo "  restart - Restart the FixSpellingShortcut service"
        echo "  status  - Show service status"
        echo "  logs    - Show recent logs"
        exit 1
        ;;
esac
