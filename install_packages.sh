#!/usr/bin/bash
PACKAGES=$(cat ./packages.json | jq -r '.[]|"\(.name)"')
PACKAGES_TO_INSTALL=""

for ROW in "${PACKAGES[@]}"; do
  [ "${ROW}" != "null" ] && PACKAGES_TO_INSTALL="${PACKAGES_TO_INSTALL} ${ROW}"
done

yay -S $PACKAGES_TO_INSTALL
