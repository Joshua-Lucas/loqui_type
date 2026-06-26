# Loqui Type

A local-first speech-to-text tool for dictating into terminal-based agents and CLI apps.

The goal is simple:

```txt
press hotkey
  -> record audio locally
  -> transcribe with local whisper.cpp
  -> copy transcript to clipboard
  -> paste into the focused terminal
```

This project is currently in early MVP setup.

## Current status

Right now the app can set up a local `whisper.cpp` build and test transcription
against the sample JFK audio file included with `whisper.cpp`.

The next step is wiring this into the Go transcriber package.

## Requirements

On Arch Linux / Omarchy:

```sh
sudo pacman -S --needed git cmake base-devel
```

## Setup

Clone the `whisper.cpp` submodule:

```sh
git submodule update --init --recursive
```

Build `whisper.cpp` and download the default model:

```sh
make setup
```

By default, this downloads:

```txt
ggml-base.en.bin
```

To use a different model:

```sh
make setup MODEL_NAME=tiny.en
make setup MODEL_NAME=small.en
```

## Test Whisper

Run:

```sh
make test-whisper
```

This builds/runs the local `whisper-cli` against the JFK sample audio file:

```txt
third_party/whisper.cpp/samples/jfk.wav
```

The transcript output is written to:

```txt
/tmp/dictate-jfk.txt
```

You can view it with:

```sh
cat /tmp/dictate-jfk.txt
```

## Generated files

The following files are generated locally and should not be committed:

```txt
third_party/whisper.cpp/build/
third_party/whisper.cpp/models/ggml-*.bin
vendor-bin/
models/
bin/
```


## MVP plan

```txt
1. Build and test local whisper.cpp
2. Add Go transcriber package
3. Record temporary WAV audio
4. Transcribe locally
5. Copy transcript to clipboard
6. Paste into focused terminal
7. Remove temporary audio files
