# Disk Guardian

A lightweight storage monitoring agent for Linux systems that sends high-priority disk alerts straight to your phone via `ntfy`.

## Configuration
Configuration for Disk Guardian is stored in "/etc/disk-guardian/disk-guardian.conf"

## Usage Guide
```
Usage: disk-guardian [OPTIONS]


Options:
  -t PATH           Override target directory to check on-the-fly
  -m PERCENT        Override warning threshold percentage limit
  -d, --dry-run     Simulate execution environment without writing logs or alerting
  -x, --test        Send an immediate alerting pipeline notification check
  -h, --help        Show help interface
```

## How to Build the Package
Clone this repository onto a Debian/Ubuntu system and run the build script:

```bash
git clone https://github.com/belchichiagozie/Disk-Guardian
cd Disk-Guardian
chmod +x build.sh
./build.sh
