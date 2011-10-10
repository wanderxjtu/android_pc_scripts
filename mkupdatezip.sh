#!/bin/bash
usage(){
	echo "$0 zipname fonts|lib|app|framework files"
}

if [[ $# < 3 ]]; then
  usage
  exit 1
fi

# Variables
container=update-temp
signer=`which signer`

zipname=$1

rm -rf $container
mkdir -p $container/META-INF/com/google/android/
cat > $container/META-INF/com/google/android/update-script <<EOF
show_progress 1 0
copy_dir PACKAGE:system SYSTEM:
EOF

path=$container/system/$2
mkdir -p $path

shift
shift

cp $@ $path
cd $container
zip -ru9 ../$zipname *
cd ..
rm $container -r

# sign zipfiles

if [[ -r $signer ]]; then
  $signer -move $zipname
else
  echo "$0: no signer found!"
  echo "$0: update zipfile $zipname not signed!"
fi
