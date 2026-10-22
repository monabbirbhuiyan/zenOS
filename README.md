# zenOS

Fedora Atomic + COSMIC desktop, set up for gaming, development and graphic design.
Built automatically by [BlueBuild](https://blue-build.org) on GitHub Actions.

## What's inside

| Area | Included |
|---|---|
| Base | Universal Blue `base-main` (Fedora 44 Atomic) — atomic updates + rollback |
| Desktop | COSMIC |
| Gaming | Steam, gamescope, GameMode, MangoHud, Heroic, Lutris, ProtonUp-Qt (for Proton-GE) |
| Windows apps | Wine (double-click `.exe` to run), Winetricks, Bottles |
| Development | Git, VS Code, Distrobox, Podman |
| Design | Krita, GIMP, Inkscape, Blender, Darktable |

## One-time setup (all from your browser / Mac terminal)

1. **Create a GitHub repo** and upload this folder's contents (keep the `.github` folder).
2. **Create a signing key** (needs `cosign`; on a Mac: `brew install cosign`):
   ```
   cosign generate-key-pair
   ```
   Press Enter for an empty password. This creates `cosign.key` and `cosign.pub`.
   - Put the contents of `cosign.key` into the repo's **Settings → Secrets and variables → Actions** as a secret named `SIGNING_SECRET`.
   - Commit `cosign.pub` to the root of the repo.
   - **Never commit `cosign.key`.**
3. **Push.** The Actions tab will build your image (first build takes ~20–40 min).
   It'll be published at `ghcr.io/<your-github-username>/zenos`.
4. Make the package public: on GitHub go to your profile → **Packages** → `zenos` → Package settings → Change visibility → Public.

## Installing on your AMD machine

1. Install **Fedora COSMIC Atomic** from fedoraproject.org (closest official starting point).
2. Rebase to your image (two steps, the first switches to the unsigned image so the signing keys get installed):
   ```
   rpm-ostree rebase ostree-unverified-registry:ghcr.io/<your-github-username>/zenos:latest
   systemctl reboot
   rpm-ostree rebase ostree-image-signed:docker://ghcr.io/<your-github-username>/zenos:latest
   systemctl reboot
   ```
3. Updates now arrive automatically. If an update breaks something, pick the previous entry in the boot menu, or run `rpm-ostree rollback`.

Later phase: build your own installable ISO — see https://blue-build.org/how-to/generate-iso/

## Changing the distro

- Add/remove system packages: `recipes/recipe.yml` → the `dnf` sections.
- Add/remove apps: the `default-flatpaks` list (use the app ID from flathub.org).
- Add your own config files: put them under `files/system/` mirroring the real path
  (e.g. `files/system/etc/foo.conf` → `/etc/foo.conf`).
