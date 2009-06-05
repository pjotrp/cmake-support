#! /bin/bash

echo "HELLO from remote "$*
project=$1
binpath=$2
git=$3
test_install=$4
branch=$5

echo "binpath=$binpath"
echo "git=$git"
echo "test=$test_install"
echo "branch=$branch"

test_me() {
  ./configure $1
  make
  make test >> test.out
  make test
  cat Testing/Temporary/LastTest.log >> testlog.out
  if [ $test_install != '0' ]; then
    make install
    ./scripts/cleanup.sh
    ./configure $1
    make test >> test.out
    make test
    cat Testing/Temporary/LastTest.log >> testlog.out
    ./scripts/uninstall.sh
  fi
}

PATH=$binpath:$PATH
set
mkdir -p autotest
cd autotest
git --version
if [ -e $project/.git/config ]; then
  echo "$project git repo exists, changing dir"
  cd $project
else
  rm -rvf $project
  git clone $git $project
  cd $project
fi
ls -l
git checkout -b $branch
git pull origin $branch
git submodule update --init
cat PROJECTNAME VERSION > test.out
cat /proc/version >> test.out
cmake --version >> test.out
swig -version >> test.out
gcc --version >> test.out
perl -v 
git log -1 >> test.out
echo $project $git >> test.out
echo "Test Ruby editions"
ruby -v >> test.out
test_me "--with-ruby"
test_me "--with-ruby --with-rqtl"
echo "Test Perl editions"
perl -v >> test.out
test_me
echo "Test Python editions"
python -V >> test.out
test_me "--with-python"
cat test.out
