# php2shell-test

Test repository to check whether GitHub Dependabot can detect vulnerabilities
in the **PHP runtime**, as opposed to PHP **libraries** managed by Composer.

> ⚠️ **Warning:** This repository is deliberately vulnerable. It uses an
> end-of-life PHP version affected by CVE-2026-109618 and CVE-2026-109619
> (PHP2Shell) and a Composer package with known security advisories.
> Do not deploy it or use it as a template.

## Background

CVE-2026-109618 and CVE-2026-109619 ("PHP2Shell") are critical remote code
execution vulnerabilities in the PHP engine itself, affecting PHP 5.4 through
8.5.11. Fixes were released in PHP 8.5.12, 8.4.27, 8.3.36 and 8.2.35.
PHP 8.1 and earlier are end-of-life and will not receive a fix.

Dependabot matches package manifests against the GitHub Advisory Database.
This repo tests whether a vulnerable PHP runtime declared in a Dockerfile or
in `composer.json` is detected.

## Repository contents

| File | Purpose |
|---|---|
| `src/index.php` | Minimal app that prints the PHP runtime version |
| `Dockerfile` | Uses `php:8.1-apache`, a runtime affected by PHP2Shell with no fix available |
| `composer.json` / `composer.lock` | Pins `guzzlehttp/guzzle` 7.4.0 as a known-vulnerable control |

## Test plan

| Phase | Change | Question |
|---|---|---|
| 1 | PHP 8.1 declared only in the `Dockerfile` | Does Dependabot alert on the PHP runtime from the Dockerfile? |
| 2 | Add `"php": "8.1.*"` to `composer.json` | Does Dependabot alert on the PHP runtime from the Composer platform requirement? |
| 3 | Add `dependabot.yml` for the `docker` ecosystem | Does Dependabot propose a base image update? |
| 4 | Build and run the image | Confirm the vulnerable PHP runtime is present in the container |

Guzzle 7.4.0 is the control: it should produce Dependabot alerts, proving
Dependabot is active on the repository.

## Expected results

| Check | Expected |
|---|---|
| Dependabot alerts for Guzzle | Yes |
| Dependabot alerts for PHP2Shell | No |
| Dependabot version update PR for the base image | Yes, once `dependabot.yml` is added |

## Results

_To be completed after each phase._

## Running locally

```bash
docker build -t php2shell-test .
docker run --rm -p 8080:80 php2shell-test
curl http://localhost:8080
```