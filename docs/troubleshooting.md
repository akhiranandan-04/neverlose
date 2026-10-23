# Troubleshooting

Start with the symptom that matches your session. Change one thing at a time and
write down what you changed; random reinstalls make the next failure harder to
diagnose.

## Common problems

| Symptom | Likely cause | First action |
| --- | --- | --- |
| Menu does not open | Wrong game build, loader not attached, or an overlay conflict | Confirm the legacy CS:GO client, close other overlays, restart both processes |
| Loader closes immediately | Incomplete extraction, missing files, or security software blocking it | Re-extract the archive to a local folder and verify the package contents |
| Game crashes when attaching | Build mismatch, damaged config, or a conflicting hook | Remove recent scripts, load a default profile, and compare game and loader builds |
| Visuals are missing | Window mode, disabled modules, or an outdated configuration | Switch to borderless or windowed mode and reload the profile |
| Config changes do not persist | Read-only folder or a write-permission problem | Move the build to a writable local path and save again |
| Frame rate drops after enabling features | Visual modules, capture tools, or script load | Disable visuals and scripts one at a time, then retest in a full server |
| Steam opens CS2 instead of CS:GO | The current Steam install is CS2 | This hub targets the legacy CS:GO client and cannot restore it |
| Archive will not extract | Corrupt download or blocked file | Delete the partial folder, download again, and keep security software enabled |

## Loader and menu

- Confirm the archive was fully extracted. Running from a temporary archive view
  is a common cause of missing-file errors.
- Close capture tools, hardware overlays, and other injection-based software
  before testing.
- Use the loader instructions that ship with the build. Do not mix instructions
  from an older version.
- If the menu opens but input does not reach it, switch between fullscreen and
  borderless mode and restart the game.
- Do not disable security software to force a loader to start. If a file is
  flagged, stop and verify the download source.

## Configuration and scripts

- Load a clean default profile before testing a complex one.
- Disable all custom scripts, then enable them one at a time.
- Restore a backup instead of editing a profile you cannot reproduce.
- Remove profiles copied from another build; schemas can change.
- Keep the config folder out of cloud-synced directories if the build does not
  handle file locks well.

## Performance

- Test in a full server, not only in the menu.
- Lower visual effects before changing game settings.
- Close browser hardware acceleration, recording software, and unnecessary
  overlays while measuring.
- Check GPU driver health and thermals; a sudden drop may not be caused by the
  build at all.
- Note the frame time, not only the average FPS. Stutters are easier to compare.

## Account and ban questions

This repository cannot investigate VAC or game bans, recover accounts, or verify
claims about detection status. No documentation can guarantee account safety.
See [Safety](safety.md) for the risks before using third-party software.

## Reporting an issue

A useful report includes:

- Windows version.
- Game build and loader build.
- Whether the legacy CS:GO client or CS2 was running.
- Exact steps that reproduce the problem.
- What you changed since the last working session.
- Relevant log lines with account names, tokens, and local paths removed.

Do not attach full config archives, Steam sessions, passwords, or personal data
to a public issue. Use the documentation issue template and keep the report
focused on the guide or repository asset that needs correction.

## Before reinstalling everything

1. Try a clean default profile.
2. Try a fresh extraction in a new folder.
3. Try without custom scripts.
4. Try a different window mode.
5. Compare the current build with the previous folder.

A controlled comparison is faster than deleting every file and starting over.
