.PHONY: all
all: build test

#
# Logging
#

### Colour Definitions
END_COLOR=\x1b[0m
GREEN_COLOR=\x1b[32;01m
RED_COLOR=\x1b[31;01m
YELLOW_COLOR=\x1b[33;01m

### Clean temporary files
clean:
	@echo "$(GREEN_COLOR)Cleaning unwanted files $(END_COLOR)"
	rm -rf coverage.txt
	rm -rf coverage.html

### Initialisation project for the first time
init:
	@echo "$(GREEN_COLOR)Initialising dependencies $(END_COLOR)"
	go get -u github.com/golang/lint/golint

### End output
end:
	@echo "$(YELLOW_COLOR)🙏  🙏  🙏$(END_COLOR)"

### Fix formatting
fmt:
	@echo "$(GREEN_COLOR)Running fmt $(END_COLOR)"
	go fmt ./...

### Run go vet
vet:
	@echo "$(GREEN_COLOR)Running vet $(END_COLOR)"
	go vet ./...

### Check for linting issues
lint:
	@echo "$(GREEN_COLOR)Running lint $(END_COLOR)"
	golint ./...

### Manually test all packages
test:
	@echo "$(GREEN_COLOR)Running tests for all packages $(END_COLOR)"
	go test -covermode=atomic -v -race -timeout=10s -coverprofile=coverage.tmp

### Calculate test coverage for the whole project (except vendors)
coverage:
	@echo "$(GREEN_COLOR)Calculating test coverage across packages $(END_COLOR)"
	go test -covermode=atomic -v -race -timeout=10s -coverprofile=coverage.txt
	go tool cover -html=coverage.txt -o coverage.html
	@rm coverage.txt
	@echo "$(YELLOW_COLOR)Run open ./coverage.html to view coverage $(END_COLOR)"

### Build the latest source for the first time
build: clean init fmt vet lint coverage end