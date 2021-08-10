#! /bin/csh -f 

cd $OBJROOT/lnd/obj

if (-f $CASEBUILD/ctsmconf/Filepath) then
   cp $CASEBUILD/ctsmconf/Filepath ./tmp_filepath 
else
   echo "ctsm.buildexe.csh ERROR - missing $CASEBUILD/ctsmconf/Filepath"
   exit -1
endif
if (-f Filepath) then
  cmp -s tmp_filepath Filepath || mv -f tmp_filepath Filepath 
else
  mv -f tmp_filepath Filepath 
endif

set ctsmdefs = "`cat $CASEBUILD/ctsmconf/CESM_cppdefs`"
$GMAKE complib -j $GMAKE_J MODEL=ctsm COMPLIB=$LIBROOT/liblnd.a USER_CPPDEFS="$ctsmdefs" -f $CASETOOLS/Makefile || exit 2

wait



