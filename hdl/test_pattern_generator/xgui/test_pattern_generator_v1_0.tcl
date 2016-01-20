# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DISPLAY_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "H_FRONT_PORCH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "H_SYNC_PULSE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "H_BACK_PORCH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DISPLAY_HEIGHT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "V_FRONT_PORCH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "V_SYNC_PULSE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "V_BACK_PORCH" -parent ${Page_0}


}

proc update_PARAM_VALUE.DISPLAY_HEIGHT { PARAM_VALUE.DISPLAY_HEIGHT } {
	# Procedure called to update DISPLAY_HEIGHT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DISPLAY_HEIGHT { PARAM_VALUE.DISPLAY_HEIGHT } {
	# Procedure called to validate DISPLAY_HEIGHT
	return true
}

proc update_PARAM_VALUE.DISPLAY_WIDTH { PARAM_VALUE.DISPLAY_WIDTH } {
	# Procedure called to update DISPLAY_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DISPLAY_WIDTH { PARAM_VALUE.DISPLAY_WIDTH } {
	# Procedure called to validate DISPLAY_WIDTH
	return true
}

proc update_PARAM_VALUE.H_BACK_PORCH { PARAM_VALUE.H_BACK_PORCH } {
	# Procedure called to update H_BACK_PORCH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_BACK_PORCH { PARAM_VALUE.H_BACK_PORCH } {
	# Procedure called to validate H_BACK_PORCH
	return true
}

proc update_PARAM_VALUE.H_FRONT_PORCH { PARAM_VALUE.H_FRONT_PORCH } {
	# Procedure called to update H_FRONT_PORCH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_FRONT_PORCH { PARAM_VALUE.H_FRONT_PORCH } {
	# Procedure called to validate H_FRONT_PORCH
	return true
}

proc update_PARAM_VALUE.H_SYNC_PULSE { PARAM_VALUE.H_SYNC_PULSE } {
	# Procedure called to update H_SYNC_PULSE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_SYNC_PULSE { PARAM_VALUE.H_SYNC_PULSE } {
	# Procedure called to validate H_SYNC_PULSE
	return true
}

proc update_PARAM_VALUE.V_BACK_PORCH { PARAM_VALUE.V_BACK_PORCH } {
	# Procedure called to update V_BACK_PORCH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_BACK_PORCH { PARAM_VALUE.V_BACK_PORCH } {
	# Procedure called to validate V_BACK_PORCH
	return true
}

proc update_PARAM_VALUE.V_FRONT_PORCH { PARAM_VALUE.V_FRONT_PORCH } {
	# Procedure called to update V_FRONT_PORCH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_FRONT_PORCH { PARAM_VALUE.V_FRONT_PORCH } {
	# Procedure called to validate V_FRONT_PORCH
	return true
}

proc update_PARAM_VALUE.V_SYNC_PULSE { PARAM_VALUE.V_SYNC_PULSE } {
	# Procedure called to update V_SYNC_PULSE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_SYNC_PULSE { PARAM_VALUE.V_SYNC_PULSE } {
	# Procedure called to validate V_SYNC_PULSE
	return true
}


proc update_MODELPARAM_VALUE.DISPLAY_WIDTH { MODELPARAM_VALUE.DISPLAY_WIDTH PARAM_VALUE.DISPLAY_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DISPLAY_WIDTH}] ${MODELPARAM_VALUE.DISPLAY_WIDTH}
}

proc update_MODELPARAM_VALUE.H_FRONT_PORCH { MODELPARAM_VALUE.H_FRONT_PORCH PARAM_VALUE.H_FRONT_PORCH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_FRONT_PORCH}] ${MODELPARAM_VALUE.H_FRONT_PORCH}
}

proc update_MODELPARAM_VALUE.H_SYNC_PULSE { MODELPARAM_VALUE.H_SYNC_PULSE PARAM_VALUE.H_SYNC_PULSE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_SYNC_PULSE}] ${MODELPARAM_VALUE.H_SYNC_PULSE}
}

proc update_MODELPARAM_VALUE.H_BACK_PORCH { MODELPARAM_VALUE.H_BACK_PORCH PARAM_VALUE.H_BACK_PORCH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_BACK_PORCH}] ${MODELPARAM_VALUE.H_BACK_PORCH}
}

proc update_MODELPARAM_VALUE.DISPLAY_HEIGHT { MODELPARAM_VALUE.DISPLAY_HEIGHT PARAM_VALUE.DISPLAY_HEIGHT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DISPLAY_HEIGHT}] ${MODELPARAM_VALUE.DISPLAY_HEIGHT}
}

proc update_MODELPARAM_VALUE.V_FRONT_PORCH { MODELPARAM_VALUE.V_FRONT_PORCH PARAM_VALUE.V_FRONT_PORCH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_FRONT_PORCH}] ${MODELPARAM_VALUE.V_FRONT_PORCH}
}

proc update_MODELPARAM_VALUE.V_SYNC_PULSE { MODELPARAM_VALUE.V_SYNC_PULSE PARAM_VALUE.V_SYNC_PULSE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_SYNC_PULSE}] ${MODELPARAM_VALUE.V_SYNC_PULSE}
}

proc update_MODELPARAM_VALUE.V_BACK_PORCH { MODELPARAM_VALUE.V_BACK_PORCH PARAM_VALUE.V_BACK_PORCH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_BACK_PORCH}] ${MODELPARAM_VALUE.V_BACK_PORCH}
}

