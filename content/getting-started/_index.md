+++
title = "Getting Started"
description = "Set up PenumbraOS"
weight = 10
icon = "rocket"
+++

{{< callout type="warning" >}}
PenumbraOS is and always will be experimental software. Expect problems and the need to troubleshoot your Pin.
{{< /callout >}}

## Why PenumbraOS

If you want to do anything with the Humane Ai Pin, you don't have any other option. Humane had a strange idea of what "privacy" meant; privacy meant that "no one else can steal your data". That meant that the Ai Pin was locked down tightly, while still sending basically all of your Pin's information to Humane's servers (thus by definition not keeping it private). Even once you've gained access to the Pin using the leaked ADB certificate, apps you install cannot access the network, touchpad, hand gestures, or basically anything else.

After a long and drawn out investigation, [@agg23](https://github.com/agg23) arrived at a convoluted solution to deliver that missing functionality in a way that end users and developers can use and understand without dealing with complicated exploits. That solution is PenumbraOS.

## What can PenumbraOS do?

PenumbraOS runs automatically on Ai Pin startup, setting up all of the resources necessary to bypass Humane's tight restrictions. It sets up mechanisms for making network calls and talking to hardware features.

When using our official launcher/assistant, [MABL](https://github.com/PenumbraOS/mabl), the following functionality is implemented:

- An assistant that functions local-first. All requests that could be served locally are served locally when possible
  - Provide LLM information for queries to external services. This is required for everything but offline functionality, but you can self-host your LLM (or even run it on device if you're very adventurous)
  - Offline processing of simple queries, like requesting battery level, changing volume, and similar
  - Queries support internet search through multiple providers (Gemini, Google Search API keys, SearX)
- Speaks in the official Humane voice, run entirely on device
- Touchpad gestures similar to the original software
  - Hold a single finger to talk to the assistant
  - Hold two fingers to take a picture and send that picture and your voice query to the assistant
- Set timers and alarms
- Raise hand to "laser in" and view the current time
- Hand gestures to access menus, similar to with the original software

The only information MABL ever sends out to someone is the information you specifically requested. You can customize the LLM system prompt entirely and you control how conversations are sent to be processed by a LLM provider.

<div class="content-cta">
  <a href="/getting-started/installation/" class="hero-cta">Install PenumbraOS</a>
</div>
