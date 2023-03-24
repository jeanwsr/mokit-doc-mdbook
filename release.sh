ver=$1
targ=mokit-doc-$ver
mv public $targ
tar czvf $targ.tar.gz $targ
rm $targ -rf
