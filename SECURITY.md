# Security policy

Loop handles personal data of public-sector employees (names, contacts and
postings), so we take reports seriously.

## Reporting a vulnerability

Please **do not open a public issue**. Use GitHub's
[private vulnerability reporting](https://github.com/TusharTechs/loop-transfers/security/advisories/new)
for this repository. We aim to acknowledge reports within 72 hours.

## Scope and design notes

- Contact details are `serverOnly` model fields and are only returned to
  members of a loop that every member has accepted.
- Who declined a loop is never stored with the decline event.
- Verification codes are random 8-character capabilities (32^8 combinations);
  the public page shows first names and initials only.
- The five demo accounts (`judge1..5@example.com`) only exist for evaluation
  and can only act on clearly labelled simulated exchanges' data and their own
  requests.
