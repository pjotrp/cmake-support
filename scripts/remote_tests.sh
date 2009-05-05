#! /bin/bash

echo "HELLO from remote "$*
project=$1
git=$2
branch=$3
test_install=$4

test_me() {
  ./configure $1
  make
  make test >> test.out
  cat Testing/Temporary/LastTest.log >> testlog.out
  if [ ! -z $test_install ]; then
    make install
    ./scripts/cleanup.sh
    ./configure $1
    make test
    cat Testing/Temporary/LastTest.log >> testlog.out
    ./scripts/uninstall.sh
  fi
}

PATH=/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/cygdrive/c/WINDOWS/system32:/cygdrive/c/WINDOWS:/cygdrive/c/WINDOWS/System32/Wbem:/bin:$PATH
set
mkdir -p autotest
cd autotest
git --version
if [ -e $project/.git/config ]; then
  cd $project
else
  rm -rf $project
  git clone $git $project
  cd $project
fi
git checkout -b $branch
git pull origin $branch
cat PROJECTNAME VERSION > test.out
cat /proc/version >> test.out
cmake --version >> test.out
swig -version >> test.out
gcc --version >> test.out
perl -v 
git log -1 >> test.out
echo $project $git >> test.out
ruby -v >> test.out
test_me "--with-ruby"
perl -v >> test.out
test_me
python -V >> test.out
test_me "--with-python"
cat test.out
