//
// Vivado(TM)
// rundef.js: a Vivado-generated Runs Script for WSH 5.1/5.6
// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//

echo "This script was generated under a different operating system."
echo "Please update the PATH variable below, before executing this script"
exit

var WshShell = new ActiveXObject( "WScript.Shell" );
var ProcEnv = WshShell.Environment( "Process" );
var PathVal = ProcEnv("PATH");
if ( PathVal.length == 0 ) {
  PathVal = "/software/CAD/Xilinx/2018.1/SDK/2018.1/bin:/software/CAD/Xilinx/2018.1/Vivado/2018.1/ids_lite/ISE/bin/lin64;/software/CAD/Xilinx/2018.1/Vivado/2018.1/ids_lite/ISE/lib/lin64;/software/CAD/Xilinx/2018.1/Vivado/2018.1/bin;";
} else {
  PathVal = "/software/CAD/Xilinx/2018.1/SDK/2018.1/bin:/software/CAD/Xilinx/2018.1/Vivado/2018.1/ids_lite/ISE/bin/lin64;/software/CAD/Xilinx/2018.1/Vivado/2018.1/ids_lite/ISE/lib/lin64;/software/CAD/Xilinx/2018.1/Vivado/2018.1/bin;" + PathVal;
}

ProcEnv("PATH") = PathVal;

var RDScrFP = WScript.ScriptFullName;
var RDScrN = WScript.ScriptName;
var RDScrDir = RDScrFP.substr( 0, RDScrFP.length - RDScrN.length - 1 );
var ISEJScriptLib = RDScrDir + "/ISEWrap.js";
eval( EAInclude(ISEJScriptLib) );


ISEStep( "vivado",
         "-log gig_eth_pcs_pma_basex_gtp.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source gig_eth_pcs_pma_basex_gtp.tcl" );



function EAInclude( EAInclFilename ) {
  var EAFso = new ActiveXObject( "Scripting.FileSystemObject" );
  var EAInclFile = EAFso.OpenTextFile( EAInclFilename );
  var EAIFContents = EAInclFile.ReadAll();
  EAInclFile.Close();
  return EAIFContents;
}
