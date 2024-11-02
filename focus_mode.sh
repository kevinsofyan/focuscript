#!/bin/bash
# use it like this focus_mode.sh on | off


# List of domains to block
DOMAINS=(
  "www.youtube.com"
  "youtube.com"
  "m.youtube.com"
  "youtu.be"
  "linkedin.com"
  "www.linkedin.com"
  "murzfeed.com"
  "www.murzfeed.com"
  "9gag.com"
  "www.9gag.com"
  "tokopedia.com"
  "www.tokopedia.com"
  "ign.com"
  "www.ign.com"
  "siliconera.com"
  "www.siliconera.com"
  "metacritic.com"
  "www.metacritic.com"
  "netflix.com"
  "www.netflix.com"
  "www.tiktok.com"
  "tiktok.com"
  "www.instagram.com"
  "instagram.com"
)

# Function to block websites
block_websites() {
  echo "Blocking websites..."

  # Backup the original /etc/hosts file if not already backed up
  if [ ! -f /etc/hosts.bak ]; then
    sudo cp /etc/hosts /etc/hosts.bak
    echo "Backup of /etc/hosts created."
  fi

  # Add domains to /etc/hosts if not already present
  for domain in "${DOMAINS[@]}"; do
    sudo sh -c "grep -q '127.0.0.1 $domain' /etc/hosts || echo '127.0.0.1 $domain' >> /etc/hosts"
  done

  echo "Websites are now blocked."
}

# Function to unblock websites
unblock_websites() {
  echo "Unblocking websites..."

  # Check if backup exists
  if [ -f /etc/hosts.bak ]; then
    sudo cp /etc/hosts.bak /etc/hosts
    echo "Restored original /etc/hosts file."
  else
    echo "No backup found. Cannot restore the original /etc/hosts."
  fi

  echo "Websites are now unblocked."
}

# Check for the presence of an argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 [on|off]"
  exit 1
fi

# Toggle blocking or unblocking based on the argument
case "$1" in
  on)
    block_websites
    ;;
  off)
    unblock_websites
    ;;
  *)
    echo "Invalid argument. Usage: $0 [on|off]"
    exit 1
    ;;
esac