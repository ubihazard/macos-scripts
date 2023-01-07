#!/bin/bash

pkg="$1"
path=`dirname "$pkg"`
name=`basename "$pkg"`
[ "${path:0:1}" != '/' ] && pkg=`pwd`/$pkg

cd "pkg/$name"
[ $? -ne 0 ] && exit 1

function repair_permissions {
  files=()
  IFS=$'\n' read -r -d '' -a files < <( lsbom -pf ../Bom && printf '\0' )

  owners=()
  IFS=$'\n' read -r -d '' -a owners < <( lsbom -pu ../Bom && printf '\0' )

  groups=()
  IFS=$'\n' read -r -d '' -a groups < <( lsbom -pg ../Bom && printf '\0' )

  perms=()
  IFS=$'\n' read -r -d '' -a perms < <( lsbom -pm ../Bom && printf '\0' )

  for i in "${!files[@]}"; do
    file=${files[$i]}
    owner=${owners[$i]}
    group=${groups[$i]}
    perm=${perms[$i]}
    perm=${perm: -3}
    chown $owner:$group "$file"
    chmod $perm "$file"
  done

  mkbom . ../Bom
}

if [ -d Payload ]; then
  cd Payload
  repair_permissions
  find . | cpio -o --format odc | gzip -c > ../.payload
  cd ..
  rm -rf Payload && mv .payload Payload
fi

for p in *.pkg; do
  cd "$p/Payload"
  repair_permissions
  find . | cpio -o --format odc | gzip -c > ../.payload
  cd ..
  rm -rf Payload && mv .payload Payload
  cd ..
done

pkgutil --flatten . "$pkg"
cd .. && rm -rf "$name"
cd .. && rmdir pkg
rmattr "$pkg"
