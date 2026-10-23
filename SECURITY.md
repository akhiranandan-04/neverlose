# Security

This repository contains documentation and original design assets. It does not
ship executable code, a loader, a runtime, or a package.

## Supported scope

Security reports are relevant when they concern:

- A malicious or impersonated link in the documentation.
- A leaked credential, token, or private config in the repository.
- A compromised contributor account or suspicious pull request.
- An asset that contains hidden executable content.
- A workflow or validation bypass that could hide one of the above.

The repository cannot help with VAC bans, game account recovery, vendor support,
or the security of files downloaded outside GitHub.

## Reporting

If private vulnerability reporting is enabled, use **Security** and then
**Report a vulnerability** in the repository. Include the file, line, and a
description of the problem.

If private reporting is not available, open a minimal issue titled
`Private security report requested` with no sensitive details, and wait for a
maintainer to provide a private channel.

Do not publish passwords, tokens, session files, or personal data in an issue,
pull request, screenshot, or commit. If a secret was exposed, revoke it first;
removing the commit does not make the secret private again.

## What to include

- The affected file or link.
- Why it is dangerous or incorrect.
- Steps to reproduce, without executing unknown files.
- The commit or pull request where it appeared, if known.

## What not to include

- Working malware.
- Stolen credentials or account data.
- Full archives downloaded from a mirror.
- Requests for account or ban support.

Reports are handled on a best-effort basis. There is no bug bounty and no
guaranteed response time.
