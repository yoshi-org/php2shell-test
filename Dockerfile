# Deliberately using an end-of-life PHP version affected by
# CVE-2026-109618 and CVE-2026-109619 (no fix available for 8.1)
FROM php:8.1-apache

COPY src/ /var/www/html/