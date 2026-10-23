# Configuration

Configuration is where most Neverlose sessions succeed or fail. A profile that
feels good in one build can behave differently after an update, and a profile
copied from a stranger can carry settings you do not understand.

This hub does not ship private vendor configs. It documents a repeatable workflow
for keeping your own profiles clean, portable, and easy to compare.

## Principles

- **One profile per purpose.** Keep separate profiles for competitive play,
  testing, and experiments instead of editing one profile forever.
- **Change one group at a time.** Adjust aim settings, then test. Adjust visuals,
  then test. Do not rebuild everything at once.
- **Back up before experimenting.** A config you cannot restore is not a
  configuration strategy.
- **Record the build.** A profile is only meaningful with the build it was
  created for.
- **Keep private data out of shared files.** Remove local paths, account names,
  and anything that identifies you before posting a config or screenshot.

## A safe editing loop

1. Duplicate the current profile and give it a dated name.
2. Change one feature group.
3. Play a short test session.
4. Save and restart the game and loader.
5. Confirm the change survived the restart.
6. Export or copy the profile to a backup folder.
7. Write one line in a local note: build, date, and what changed.

This takes a minute and saves hours when a new build arrives.

## What to review before saving

| Group | Review |
| --- | --- |
| Aim | Sensitivity, smoothing, hitchance, and target selection match your intent |
| Visuals | Effects are readable without hiding the game state |
| Movement | Keys do not conflict with game binds or other tools |
| Misc | No noisy logging, no unnecessary background work |
| Scripts | Every enabled script is readable and comes from a source you trust |
| Performance | Frame time is stable in a full server, not only in the menu |

## Backups

Keep at least two backups:

- A local copy in a folder such as `Documents\Neverlose Backups`.
- A second copy on another drive or in a private archive.

Include the build date in the folder name. Do not use a public repository for
private profiles; config files can contain paths, identifiers, and script
settings that you do not want to publish.

A simple backup scheme:

```text
Neverlose Backups/
  2026-10-23/
    competitive/
    testing/
  notes.txt
```

`notes.txt` should list the build, the game build, and the reason for the backup.
Do not put credentials or account tokens in that file.

## Sharing a config

Before sharing a profile:

- Remove local file paths and account identifiers.
- Remove scripts you did not write or cannot explain.
- State the build the profile was made for.
- Say which settings depend on hardware or personal preference.
- Test the exported copy on a clean profile first.

A config that works for one player is not a recommendation. Sensitivity, FOV,
and visual preferences are personal.

## Lua scripts

Scripts are powerful and difficult to audit. Treat every script as executable
code, because that is what it is.

- Read the script before enabling it.
- Avoid obfuscated one-liners and encoded payloads.
- Do not run scripts that ask for passwords, Steam Guard codes, API keys, or
  session files.
- Keep scripts in a separate folder and back them up with the profile.
- Disable scripts one by one when troubleshooting a crash or a frame-time spike.

This repository does not distribute scripts or promise that a third-party script
is safe. A script posted in an issue or pull request will be reviewed as
documentation, not executed by the validation workflow.

## When a config stops working

1. Confirm the game and loader builds.
2. Disable recent scripts first.
3. Load a clean default profile.
4. Reapply one group at a time.
5. If only the old profile fails, compare its export with the new default.

Do not overwrite the only copy of a working profile while testing a new build.
