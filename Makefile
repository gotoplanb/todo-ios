.PHONY: install test test-unit test-ui build build-and-test clean test-results test-direct

# Install dependencies
install:
	bundle install

# Run all tests
test:
	bundle exec fastlane test

# Run only unit tests
test-unit:
	bundle exec fastlane test_unit

# Run only UI tests
test-ui:
	bundle exec fastlane test_ui

# Build the app
build:
	bundle exec fastlane build

# Build and test
build-and-test:
	bundle exec fastlane build_and_test

# Clean build artifacts
clean:
	rm -rf fastlane/test_output
	rm -rf ~/Library/Developer/Xcode/DerivedData/*
	xcodebuild clean -scheme todo -configuration Debug

# Update dependencies
update:
	bundle update

# Serve test results
test-results:
	@if [ ! -f "fastlane/test_output/report.html" ]; then \
		echo "No test results found. Run 'make test' first."; \
		exit 1; \
	fi
	@echo "Serving test results at http://localhost:8000/report.html"
	@cd fastlane/test_output && python3 -m http.server 8000

# Run tests directly with xcodebuild
test-direct:
	xcodebuild test -project todo.xcodeproj -scheme todo -destination 'platform=iOS Simulator,name=iPhone 16 Pro' -only-testing:todoTests

# Show help
help:
	@echo "Available commands:"
	@echo "  make install      - Install project dependencies (Bundler, Fastlane)"
	@echo "  make test        - Run all tests using Fastlane"
	@echo "  make test-unit   - Run only unit tests"
	@echo "  make test-ui     - Run only UI tests"
	@echo "  make test-direct - Run unit tests directly with xcodebuild"
	@echo "  make build       - Build the app using Fastlane"
	@echo "  make build-and-test - Build the app and run tests"
	@echo "  make clean       - Clean build artifacts and derived data"
	@echo "  make update      - Update project dependencies"
	@echo "  make test-results - Serve HTML test results (requires Python 3)"
	@echo "  make help        - Show all available commands" 