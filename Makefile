VERSION := "v1.62.2"
REPO = "https://github.com/rclone/rclone.git"
TMPDIR := $(shell mktemp -d)/rclone
OUTDIR := librclone/lib

.PHONY: librclone-$(VERSION)
librclone-$(VERSION):
	git clone --depth 1 --branch $(VERSION) $(REPO) $(TMPDIR)
	@echo "Cloned $(REPO) to $(TMPDIR)"

$(OUTDIR)/librclone.so: librclone-$(VERSION)
	@echo "Building librclone.so"
	cd $(TMPDIR); \
	go build \
		-buildmode=c-shared \
		-o $(PWD)/$(OUTDIR)/librclone.so \
		github.com/rclone/rclone/librclone

all: $(OUTDIR)/librclone.so
	@echo "Done"
	@echo librclone-$(VERSION)