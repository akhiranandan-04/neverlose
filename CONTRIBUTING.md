# Contributing

Thanks for helping improve the hub. This is a documentation repository, not a
vendor support desk and not a place to distribute software.

## Scope

Accepted contributions:

- Corrections to setup, configuration, or troubleshooting steps.
- Clearer explanations of compatibility limits and account risk.
- Original diagrams, interface concepts, and social assets.
- Broken-link reports and maintenance updates.
- Translation proposals with a named reviewer for each language.

Not accepted:

- Loaders, DLLs, executables, archives, license keys, or dumped source.
- Private configs, account data, session files, or leaked credentials.
- Mirror links, file-hosting reuploads, or paid-access referrals.
- Instructions for evading anti-cheat, detection, or platform moderation.
- Fake stars, purchased engagement, or impersonation of the vendor.
- Large rewrites without an issue explaining the problem first.

## Quality bar

A change should be specific enough that another person can verify it.

- Use plain English and present tense.
- Prefer short steps over long paragraphs.
- State when something depends on the build or on personal preference.
- Do not present a guess as a fact.
- Do not promise account safety, detection status, or future compatibility.
- Remove placeholders, unfinished sections, and dead links before opening a PR.
- Keep lines readable; do not add emojis, decorative badges, or marketing claims.
- Use relative links for files inside the repository.

## Assets

- Prefer original SVG artwork that you created.
- Do not submit game captures, vendor screenshots, or third-party art unless you
  can document the license and the maintainers accept it.
- Label interface concepts as illustrative, not as live captures.
- Keep the palette and layout consistent with the existing assets.
- Optimise PNG files and avoid large uncompressed sources.
- Every image must have meaningful alternative text where it is used.

## Workflow

1. Open an issue for anything larger than a typo or a broken link.
2. Fork the repository and create a focused branch.
3. Make the smallest change that solves the problem.
4. Run the validation script locally:

   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate.ps1
   ```

5. Open a pull request and describe what changed and how you verified it.

The validation script checks relative links, SVG parsing, the social preview
format, forbidden binary files, and common placeholder text. It is not a
substitute for reading the page.

## Pull request checklist

- [ ] The change is limited to the stated problem.
- [ ] No binaries, archives, source dumps, keys, or private configs are included.
- [ ] No account names, tokens, session data, or personal paths are included.
- [ ] Relative links and images resolve.
- [ ] New assets are original or properly licensed.
- [ ] The wording does not promise detection status or account safety.
- [ ] The validation script passes.

## Review and maintenance

Reviews are best-effort. A maintainer may edit wording for consistency, ask for a
smaller scope, or close a change that falls outside the repository policy.

## License

By contributing, you agree that your documentation and original assets are
released under the repository's [MIT License](LICENSE). You keep copyright of
your contribution, but you grant the project permission to publish and adapt it.
