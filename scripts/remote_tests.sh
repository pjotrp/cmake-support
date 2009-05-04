#! /bin/bash

echo "HELLO from remote "$*
project=$1
git=$2

PATH=/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/cygdrive/c/WINDOWS/system32:/cygdrive/c/WINDOWS:/cygdrive/c/WINDOWS/System32/Wbem:/bin:$PATH
set
mkdir -p autotest
cd autotest
rm -rf $project
git clone $git $project
cd $project
cat PROJECTNAME VERSION > test.out
cat /proc/version >> test.out
cmake --version >> test.out
swig -version >> test.out
gcc --version >> test.out
perl -v 
git log -1 >> test.out
echo $project $git >> test.out
perl -v >> test.out
./configure 
make
make test >> test.out
cat Testing/Temporary/LastTest.log >> testlog.out
ruby -v >> test.out
./configure --with-ruby
make
make test >> test.out
cat Testing/Temporary/LastTest.log >> testlog.out
python -V >> test.out
./configure --with-python
make
make test >> test.out
cat Testing/Temporary/LastTest.log >> testlog.out
cat test.out
