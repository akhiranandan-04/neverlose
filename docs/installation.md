# Installation

This guide covers the documentation hub's recommended workflow for a fresh
Neverlose setup on CS:GO. The instructions included with the current build take
priority if they differ from this page.

## Scope

- Windows 10 or 11, x64.
- The legacy CS:GO client. CS2 is a different game and is not covered.
- A local user account that can write to the installation folder.
- The external download folder linked from the [README](../README.md).

This repository does not host the loader, the runtime, or any game files.

## Before you start

- Read [Safety](safety.md) first. Third-party software carries a real risk of a
  VAC or game ban.
- Download only from the folder linked in the README. Do not use mirrors,
  shortened URLs, or files sent through chat.
- Keep CS:GO closed while downloading and extracting.
- Use a short local path. A path such as `C:\Neverlose` avoids permission issues
  and long-path problems. Do not extract into the Steam library.
- Make sure security software is running. Do not disable it to make an archive
  open.

## 1. Download the current archive

Open the [Neverlose download folder](https://www.mediafire.com/folder/xpuwhpaw2jpbi/neverlose)
and save the current archive to your Downloads folder.

The archive name changes with the build. Do not rename files inside the package
before checking the build's own instructions.

If the folder publishes a checksum, compare it with the archive using
PowerShell's `Get-FileHash` command. Use only a checksum published in the same
folder as the archive; a checksum posted by a third party proves nothing.

## 2. Extract to a local folder

1. Right-click the archive and choose **Extract All**.
2. Extract to a short local path such as `C:\Neverlose`.
3. Do not run the loader from inside the archive viewer.
4. If extraction reports errors, delete the partial folder and download the
   archive again. Do not patch a broken archive with files from another source.

Keep each build in its own folder when you update, for example
`C:\Neverlose\2026-10-23`. That makes rollback and config comparison much easier.

## 3. First launch

1. Start the legacy CS:GO client.
2. Use borderless or windowed mode if you plan to use an overlay. Fullscreen
   exclusive mode can interfere with overlays and capture tools.
3. Read the loader instructions included with the build.
4. Launch the loader using those instructions. If Windows shows an elevation
   prompt, review the publisher and file path before continuing.
5. Open the menu with the key documented by the build.
6. Start with the default configuration for the first session. Do not load a
   large external config before you know the build is working.

## 4. Verify the setup

A healthy first session has a few simple signals:

- The menu opens and closes reliably.
- Settings survive a restart of the game and loader.
- CS:GO does not crash when the menu is opened.
- The frame rate stays within a range you consider playable.
- A second launch with the same build behaves the same way.

If any of these fail, stop changing settings and use the
[Troubleshooting](troubleshooting.md) guide. Changing five options at once makes
the cause harder to isolate.

## 5. Updating safely

1. Close CS:GO and the loader.
2. Back up the current config folder to a separate local folder.
3. Download the new build from the same download folder.
4. Extract it into a new versioned folder instead of overwriting the old one.
5. Launch the new build with a copy of the config, not the only copy.
6. If the new build misbehaves, return to the previous folder and report the
   difference.

Do not mix files from two builds. A loader and runtime from different versions
can fail in ways that look like a game problem.

## 6. Removing the build

1. Close CS:GO and the loader.
2. Delete the folder you created for the build.
3. Remove any configuration directory the build created if you no longer need
   it. Check the build's own documentation for its exact location.
4. Do not delete files inside the Steam library as part of cleanup.

## If something goes wrong

- [Troubleshooting](troubleshooting.md) covers common loader, menu, config, and
  performance problems.
- [FAQ](faq.md) covers compatibility and account-risk questions.
- If the download folder is unavailable, open a documentation issue rather than
  using an unverified mirror.

No guide can guarantee account safety or continued compatibility. If keeping an
account clean is the priority, do not load third-party software into the game.
