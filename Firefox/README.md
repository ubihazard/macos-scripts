# Firefox

## about:config tweaks

Set the amount of RAM used for caching:

| browser.cache.memory.capacity | 128
| - | -

Move on-disk browser cache to [RAM disk](/.local/bin/ramdisk):

| browser.cache.disk.parent_directory | /Volumes/RAM
| - | -

Enable compact UI density mode (right click -> “Customize Toolbar...”):

| browser.compactmode.show | true
| - | -

## Disable auto-update prompts

In the past auto-update prompts could be disabled with:

| app.update.silent | true
| - | -

But this doesn‘t seem to work anymore.

The current solution seems to be creating a distribution policy file. However, this will also disable auto-updates themselves, – not just prompts.

```bash
mkdir ~/Applications/Firefox.app/Contents/Resources/distribution
nano ~/Applications/Firefox.app/Contents/Resources/distribution/policies.json
```

Paste the following:

```json
{
  "policies": {
    "DisableAppUpdate": true
  }
}
```
