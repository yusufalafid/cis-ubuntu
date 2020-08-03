if [[ $(mount | grep -E '\s/tmp\s' | grep -v nodev) == "" ]]; then
  echo "kosong"
else
  echo "ada"
fi