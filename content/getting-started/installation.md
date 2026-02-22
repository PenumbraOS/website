+++
title = "Installation"
weight = 2
+++

{{< callout type="warning" >}}
PenumbraOS is experimental software for a very locked down device. While the installation process is entirely reversible, running this software may cause damages we have not yet discovered. Do not attempt this unless you're comfortable troubleshooting your Pin.
{{< /callout >}}

## Prerequisites

To install PenumbraOS, you will need:

- **Humane Ai Pin**
- **Interposer** - A dock that connects to the Pin's debug interface (four metal pads underneath a sticker on the bottom of the device), which you can connect to a computer using USB. You can [buy one from GoinGhost](https://www.etsy.com/listing/1904242117/ai-pin-usb-dock-slim-final-ver-woptions) or [build your own](https://github.com/PenumbraOS/interposer).
- **Computer** - macOS, Windows, or Linux. You'll run the installer from a terminal, but the setup is very simple and experience with terminals is not required.
- **LLM API key** - PenumbraOS replaces Humane's cloud services with an LLM you provide. You'll need connection details to an API service; an API URL, API key, and model name. For ease of integrated search and maps, we recommend [Gemini](https://ai.google.dev/gemini-api/docs) (can be used free for some very small), but [OpenAI](https://platform.openai.com/) is commonly used.
- **ADB certificate (Optional)** - PenumbraOS provides a mechanism to access Pins without sharing the ADB certificate through a remote signing server, but the actual ADB certificate is highly recommended. Having it gives you standard ADB access to the device directly using normal tools, which is a much better development experience than the alternative.

## Installation

The PenumbraOS installer automatically downloads the latest version of all primary PenumbraOS components, then installs them to your Pin. You can run it again at any point to install the latest updates. Every installation completely uninstalls all components (leaving only your settings) and installs PenumbraOS again fresh.

### Prepare the Pin

Before the Pin can be seated in an interposer, you need to remove the moon sticker on the bottom of the device to expose the debug connector pads. See [Pin Preparation](/getting-started/pin-preparation/) for detailed instructions.

Once the sticker is removed, place the Pin in your interposer and connect the interposer to your computer. Windows will likely make a sound and possibly install a driver. macOS will show a USB device permission prompt.

### Download the installer

Grab the latest prebuilt binary for your platform from the [installer releases page](https://github.com/PenumbraOS/installer/releases). Choose the latest entry, then download the installer provided for your OS in the Assets section.

Note: On macOS, you will have to remove quarantine from the downloaded installer with

```bash
xattr -d com.apple.quarantine penumbra-installer-macos
```

### Run the installer

1. Open a terminal (CMD on Windows)
2. Drag your downloaded installer into the terminal window. You'll see something like

```bash
> /path/to/your/installer
```

3. Add an additional space after the installer and add the following:

```bash
install --llm-api-url <URL> --llm-api-key <API_KEY> --llm-api-model-name <MODEL_NAME>
```

Now the contents of your terminal should be something like:

```bash
> /path/to/your/installer install --llm-api-url <URL> --llm-api-key <API_KEY> --llm-api-model-name <MODEL_NAME>
```

For OpenAI, that looks something like:

```bash
installer install --llm-api-url https://api.openai.com/v1 --llm-api-key sk-... --llm-api-model-name gpt-4o
```

5. If you do not have the ADB certificate, you must use the remote signing server. Add `--remote-auth-url https://signing.openpin.org/signing` to the end of your command. If you do have the ADB certificate, you do not need to do anything special.
6. Press enter in your terminal. If nothing goes wrong, you should see/hear your Pin reboot into PenumbraOS in a few minutes.

## First Boot

The modified environment that causes PenumbraOS to function (the "jailbreak") is _not_ permanent; PenumbraOS runs its exploit chain on every boot. After the install completes and the Pin reboots:

1. MABL (or your configured launcher) will appear on the laser ink display immediately, but it is not yet functional.
2. A chime will sound when the exploit process is complete. A series of two ascending tones means the jailbreak has fully loaded and MABL is ready. A series of descending tones means something has gone wrong and you should consult [Troubleshooting](#troubleshooting).

This boot process happens every time the device powers on. It will take several minutes each time. We recommend letting your Pin sit for ~5 minutes or until you hear the chime before interacting with it after a reboot.

## Troubleshooting

If something goes wrong during installation or boot:

- Capture logs with `installer dump-logs`, or stream them in real time with `installer dump-logs --stream`.
- Uninstall with `installer uninstall` if you need to start fresh.
- A "death chime" (two descending tones) indicates the vulnerability has failed. Your Pin is fine but needs to be rebooted. Run the installer again, use the charge pad with the reset pin, or run `adb restart` (if you have the ADB certificate).
- Get help on [Discord](https://discord.gg/CDZwp5F5WS) or [GitHub Issues](https://github.com/PenumbraOS/installer/issues).
