#!/usr/bin/env bash
# Wacht tot GitHub het certificaat voor s-smarketing.com heeft uitgegeven en
# zet dan HTTPS verplicht aan. Draait maximaal 2 uur.
for i in $(seq 1 40); do
  if gh api -X PUT repos/salah-nmt/sns-site/pages -F https_enforced=true >/dev/null 2>&1; then
    echo "$(date '+%H:%M') HTTPS verplicht aangezet"
    gh api repos/salah-nmt/sns-site/pages 2>/dev/null | grep -o '"https_enforced":[a-z]*'
    exit 0
  fi
  echo "$(date '+%H:%M') certificaat nog niet klaar (poging $i)"
  sleep 180
done
echo "na 2 uur nog geen certificaat; controleer github.com/salah-nmt/sns-site/settings/pages"
