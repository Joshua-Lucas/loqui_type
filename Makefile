WHISPER_DIR := third_party/whisper.cpp
WHISPER_BUILD_DIR := $(WHISPER_DIR)/build
WHISPER_CLI := $(WHISPER_BUILD_DIR)/bin/whisper-cli

MODEL_NAME ?= base.en
MODEL_FILE := ggml-$(MODEL_NAME).bin
MODEL_PATH := $(WHISPER_DIR)/models/$(MODEL_FILE)

.PHONY: setup
setup: build-whisper download-modal test-whisper

.PHONEY: build-whisper
build-whisper:
	cmake -B $(WHISPER_BUILD_DIR) $(WHISPER_DIR)
	cmake --build $(WHISPER_BUILD_DIR) -j --config Release

.PHONEY: download-modal
download-modal:
	cd $(WHISPER_DIR) && sh ./models/download-ggml-model.sh $(MODEL_NAME)

.PHONY: test-whisper
test-whisper:
	$(WHISPER_CLI) \
		-m $(MODEL_PATH) \
		-f $(WHISPER_DIR)/samples/jfk.wav \
		-otxt \
		-of /tmp/dictate-jfk
	cat /tmp/dictate-jfk.txt

.PHONY: clean-whisper
clean-whisper:
	rm -rf $(WHISPER_BUILD_DIR)

.PHONY: clean-output
clean-output:
	rm -f /tmp/dictate-jfk.txt
