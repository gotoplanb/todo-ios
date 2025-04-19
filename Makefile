.PHONY: install test build build-and-test clean test-results

# Install dependencies
install:
	bundle install

# Run tests
test:
	bundle exec fastlane test

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

# Show help
help:
	@echo "Available commands:"
	@echo "  make install      - Install dependencies"
	@echo "  make test        - Run tests"
	@echo "  make build       - Build the app"
	@echo "  make build-and-test - Build and test"
	@echo "  make clean       - Clean build artifacts"
	@echo "  make update      - Update dependencies"
	@echo "  make test-results - Serve HTML test results"
	@echo "  make help        - Show this help message" 