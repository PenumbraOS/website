+++
title = "PenumbraOS"
description = "Make your Humane Ai Pin usable again"
+++

{{< callout >}}
Humane shut down all Ai Pin cloud services on February 28, 2025, rendering every device an unusable paperweight (technically "after the shutdown, offline features like 'battery level' will still work").
{{< /callout >}}

{{< intro >}}
PenumbraOS is an open source platform that functions like a jailbreak to restore access to the Humane Ai Pin's core functionality through providing an on-device voice assistant, a custom init system, and an SDK for building new software on the Pin.
{{< /intro >}}

{{< cards >}}
{{< card title="Getting Started" url="/getting-started/" icon="rocket" description="Install PenumbraOS on your Ai Pin and get up and running" >}}
{{< card title="Guide" url="/guide/" icon="book" description="User and developer documentation for PenumbraOS components" >}}
{{< card title="Device" url="/device/" icon="cpu" description="Hardware and software documentation for the Humane Ai Pin" >}}
{{< card title="Archive" url="/archive/" icon="archive" description="Preserved official content from Humane, Inc" >}}
{{< /cards >}}

## How it works

Once installed, PenumbraOS runs on every boot to jailbreak and configure your Ai Pin. This process can take several minutes; when it completes, you'll hear a soft chime. From there, you interact with the device through MABL, the default voice assistant (or another configured assistant app). You can gesture on the touchpad, make voice queries, and read responses on the laser ink display projected onto your hand.

Under the hood, the system is built from three open source projects:

{{< cards >}}
{{< card title="MABL" url="https://github.com/PenumbraOS/mabl" subtitle="Voice assistant and launcher" description="The actual interaction point for normal users. MABL handles LLM interaction and provides the overall user experience. It works with any OpenAI or Gemini compatible LLM provider, including self-hosted solutions." >}}
{{< card title="SDK" url="https://github.com/PenumbraOS/sdk" subtitle="App development toolkit" description="The SDK exposes HTTP and WebSocket communication, bypassing the complicated restrictions built into the Ai Pin's firmware, in addition to laser, hand recognition, notification light, eSIM, and touchpad APIs." >}}
{{< card title="pinitd" url="https://github.com/PenumbraOS/pinitd" subtitle="Exploit & init system" description="The core of the jailbreak. pinitd gains elevated privileges, sets up the environment, and manages running services." >}}
{{< /cards >}}

## Current Status

PenumbraOS is installable and functional for basic tasks. You can set up an Ai Pin with a working voice assistant, laser ink projection display, camera, and eSIM today. The SDK is also available for developers who want to build new apps.

That said, this is a young project built on top of a very difficult to manage exploit stack. Things will break, APIs will change, and there are rough edges everywhere. More effort has been put into making the device _work_ than has been put into making the UX _nice_. If that doesn't bother you, [get started now](/getting-started/).
