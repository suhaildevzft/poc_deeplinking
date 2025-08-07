#!/usr/bin/env python3
"""
Simple HTTP server for testing the deep linking website.
Run this script to serve the website on localhost:8000
"""

import http.server
import socketserver
import os
import sys
import webbrowser
from pathlib import Path

# Get the directory where this script is located
SCRIPT_DIR = Path(__file__).parent
WEB_ROOT = SCRIPT_DIR

# Server configuration
PORT = 8000
HOST = 'localhost'

class CustomHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=WEB_ROOT, **kwargs)
    
    def end_headers(self):
        # Add CORS headers for local development
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

def main():
    print(f"🌐 Starting Deep Link POC Server...")
    print(f"📁 Serving files from: {WEB_ROOT}")
    print(f"🔗 Server URL: http://{HOST}:{PORT}")
    print(f"📱 Test URL: http://{HOST}:{PORT}/?userId=123&source=test")
    print("\n" + "="*50)
    
    try:
        with socketserver.TCPServer((HOST, PORT), CustomHTTPRequestHandler) as httpd:
            print(f"✅ Server running on http://{HOST}:{PORT}")
            print("📝 Press Ctrl+C to stop the server")
            print("\n🧪 To test deep linking:")
            print(f"   1. Open http://{HOST}:{PORT} in your mobile browser")
            print("   2. Click 'Open App' button to test app launch")
            print("   3. Use QR code scanner to test from mobile device")
            print("\n" + "="*50)
            
            # Automatically open browser
            try:
                webbrowser.open(f'http://{HOST}:{PORT}')
                print("🚀 Opening browser automatically...")
            except:
                pass
            
            httpd.serve_forever()
            
    except KeyboardInterrupt:
        print("\n\n🛑 Server stopped by user")
    except OSError as e:
        if e.errno == 48:  # Address already in use
            print(f"❌ Error: Port {PORT} is already in use.")
            print(f"   Try using a different port or stop the existing server.")
        else:
            print(f"❌ Error starting server: {e}")
    except Exception as e:
        print(f"❌ Unexpected error: {e}")

if __name__ == "__main__":
    main()
