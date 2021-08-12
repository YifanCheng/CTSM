#! /bin/csh -f

if !(-d $CASEBUILD/ctsmconf) mkdir -p $CASEBUILD/ctsmconf

set config_opts=" "
cd $CASEBUILD/ctsmconf  
$CODEROOT/lnd/ctsm/bld_rasm/configure  $config_opts -comp_intf $COMP_INTERFACE \
    $CTSM_CONFIG_OPTS -usr_src $CASEROOT/SourceMods/src.ctsm || exit -1 

#--------------------------------------------------------------------
# Create ctsm.buildnml.csh
#--------------------------------------------------------------------

#if ($RUN_TYPE == startup ) then
#   if ($CTSM_FORCE_COLDSTART == on) then
#     set START_TYPE = "cold"
#   else
#     set START_TYPE = "default"
#   endif
#else
#   if ($RUN_TYPE == hybrid ) then
#     set START_TYPE = "startup"
#   else
#     set START_TYPE = $RUN_TYPE
#   endif
#endif

set RESOLUTION = $LND_GRID

if (-e $CASEBUILD/ctsm.input_data_list) rm $CASEBUILD/ctsm.input_data_list
cp $CODEROOT/lnd/ctsm/bld_rasm/namelist_files/ctsm.input_data_list.$RESOLUTION $CASEBUILD/ctsm.input_data_list
cp $CODEROOT/lnd/ctsm/bld_rasm/namelist_files/lnd_in.$RESOLUTION $CASEBUILD/ctsmconf/lnd_in

#set ctsm_startfile = " "
#if ( $RUN_TYPE == "hybrid" || $RUN_TYPE == "branch" ) then
#   set ctsm_startfile = "-ctsm_startfile ${RUN_REFCASE}.ctsm2.r.${RUN_REFDATE}-${RUN_REFTOD}.nc"
#endif

#$CODEROOT/lnd/ctsm/bld_rasm/build-namelist -infile $CASEBUILD/ctsmconf/cesm_namelist \
#    -csmdata $DIN_LOC_ROOT  \
#    -inputdata $CASEBUILD/ctsm.input_data_list \
#    -namelist "&clm_inparm $CTSM_NAMELIST_OPTS /" $usecase $glc_opts \
#    -res $RESOLUTION $ctsmusr -clm_start_type $START_TYPE $ctsm_startfile \
#    -l_ncpl $LND_NCPL -lnd_frac "${LND_DOMAIN_PATH}/${LND_DOMAIN_FILE}" \
#    -glc_nec $GLC_NEC -co2_ppmv $CCSM_CO2_PPMV -co2_type $CTSM_CO2_TYPE \
#    -config $CASEBUILD/ctsmconf/config_cache.xml $CTSM_BLDNML_OPTS || exit -3
    
if (-d ${RUNDIR}) then
  cp $CASEBUILD/ctsmconf/lnd_in ${RUNDIR}/ || exit -2
endif


