# iOS App Starter Template

A minimal, production-ready starter template for iOS applications. This template provides a solid foundation with essential configurations and best practices.

## Features

- 🏗️ SwiftUI-based architecture
- 🧪 XCTest setup with sample tests
- 🚀 Fastlane automation for building and testing
- 📦 Swift Package Manager for dependency management
- 🛠️ Makefile for common development tasks

## Getting Started

1. Clone this repository
2. Run `make install` to install dependencies
3. Open `todo.xcodeproj` in Xcode
4. Build and run!

## Development Commands

The following commands are available through the Makefile:

```bash
make install      # Install project dependencies (Bundler, Fastlane)
make test        # Run all tests using Fastlane
make build       # Build the app using Fastlane
make build-and-test  # Build the app and run tests
make clean       # Clean build artifacts and derived data
make update      # Update project dependencies
make test-results # Serve HTML test results (requires Python 3)
make help        # Show all available commands
```

### Test Results

After running tests, you can view the HTML test results by running:

```bash
make test-results
```

This will start a local server at http://localhost:8000. Open http://localhost:8000/report.html in your browser to view the test results.

## License

MIT License - feel free to use this template for your own projects. 