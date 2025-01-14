VERSION ?= "v1.63.1"
REPO = "https://github.com/rclone/rclone.git"
TMPDIR := $(shell mktemp -d)
OUTDIR := librclone/lib

.PHONY: librclone-$(VERSION)
librclone-$(VERSION):
	git -C "$(TMPDIR)" pull origin tags/$(VERSION) \
	|| git -C "$(TMPDIR)" clone --single-branch --branch $(VERSION) $(REPO) .
	@echo "Cloned $(REPO) to $(TMPDIR)"

$(OUTDIR)/librclone.so: librclone-$(VERSION)
	@echo "Building librclone.so"
	cd $(TMPDIR); \
	TMPDIR="" \
	go build \
		-buildmode=c-shared \
		-o $(PWD)/$(OUTDIR)/librclone.so \
		-tags cmount \
		github.com/rclone/rclone/librclone

all: $(OUTDIR)/librclone.so
	@echo "Done"
	@echo librclone-$(VERSION)