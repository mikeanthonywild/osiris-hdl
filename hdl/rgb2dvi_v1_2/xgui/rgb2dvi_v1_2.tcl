# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "kRstActiveHigh" -parent ${Page_0}
  ipgui::add_param $IPINST -name "kGenerateSerialClk" -parent ${Page_0}
  ipgui::add_param $IPINST -name "kClkPrimitive" -parent ${Page_0}
  ipgui::add_param $IPINST -name "kEmulateDDC" -parent ${Page_0}
  ipgui::add_param $IPINST -name "kESIDFile" -parent ${Page_0}

  ipgui::add_param $IPINST -name "kClkRange" -layout horizontal

}

proc update_PARAM_VALUE.kClkRange { PARAM_VALUE.kClkRange } {
	# Procedure called to update kClkRange when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.kClkRange { PARAM_VALUE.kClkRange } {
	# Procedure called to validate kClkRange
	return true
}

proc update_PARAM_VALUE.kESIDFile { PARAM_VALUE.kESIDFile } {
	# Procedure called to update kESIDFile when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.kESIDFile { PARAM_VALUE.kESIDFile } {
	# Procedure called to validate kESIDFile
	return true
}

proc update_PARAM_VALUE.kEmulateDDC { PARAM_VALUE.kEmulateDDC } {
	# Procedure called to update kEmulateDDC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.kEmulateDDC { PARAM_VALUE.kEmulateDDC } {
	# Procedure called to validate kEmulateDDC
	return true
}

proc update_PARAM_VALUE.kClkPrimitive { PARAM_VALUE.kClkPrimitive } {
	# Procedure called to update kClkPrimitive when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.kClkPrimitive { PARAM_VALUE.kClkPrimitive } {
	# Procedure called to validate kClkPrimitive
	return true
}

proc update_PARAM_VALUE.kRstActiveHigh { PARAM_VALUE.kRstActiveHigh } {
	# Procedure called to update kRstActiveHigh when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.kRstActiveHigh { PARAM_VALUE.kRstActiveHigh } {
	# Procedure called to validate kRstActiveHigh
	return true
}

proc update_PARAM_VALUE.kGenerateSerialClk { PARAM_VALUE.kGenerateSerialClk } {
	# Procedure called to update kGenerateSerialClk when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.kGenerateSerialClk { PARAM_VALUE.kGenerateSerialClk } {
	# Procedure called to validate kGenerateSerialClk
	return true
}


proc update_MODELPARAM_VALUE.kGenerateSerialClk { MODELPARAM_VALUE.kGenerateSerialClk PARAM_VALUE.kGenerateSerialClk } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.kGenerateSerialClk}] ${MODELPARAM_VALUE.kGenerateSerialClk}
}

proc update_MODELPARAM_VALUE.kClkPrimitive { MODELPARAM_VALUE.kClkPrimitive PARAM_VALUE.kClkPrimitive } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.kClkPrimitive}] ${MODELPARAM_VALUE.kClkPrimitive}
}

proc update_MODELPARAM_VALUE.kRstActiveHigh { MODELPARAM_VALUE.kRstActiveHigh PARAM_VALUE.kRstActiveHigh } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.kRstActiveHigh}] ${MODELPARAM_VALUE.kRstActiveHigh}
}

proc update_MODELPARAM_VALUE.kClkRange { MODELPARAM_VALUE.kClkRange PARAM_VALUE.kClkRange } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.kClkRange}] ${MODELPARAM_VALUE.kClkRange}
}

proc update_MODELPARAM_VALUE.kEmulateDDC { MODELPARAM_VALUE.kEmulateDDC PARAM_VALUE.kEmulateDDC } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.kEmulateDDC}] ${MODELPARAM_VALUE.kEmulateDDC}
}

proc update_MODELPARAM_VALUE.kESIDFile { MODELPARAM_VALUE.kESIDFile PARAM_VALUE.kESIDFile } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.kESIDFile}] ${MODELPARAM_VALUE.kESIDFile}
}

