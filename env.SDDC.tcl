#
# Env file for a simple accumulator design used in ece484
#
set HOME $env(HOME);
set PHOME $env(PHOME);      # Get the project home directory

# Specify simulaton mode!!!!!!!
set SIM_MODE syn;           # Simulation mode: rtl, syn, or pnr

# Specify basename
set BASENAME SDDC;          # Set the root cell	

# Controls what rc_synthesis script does
set RC_ELAB_ONLY false		; # Stop after elaborating
set RC_LOAD_DSN	false		; # Only want to load a design
set ENC_LOAD_DSN false		; # Only want to load a design

# Let the place and route tool know which modules have been placed and routed
set MODULE_LIST ""

#
# Source the file containing the standard options
# we would like to employ
#
source $env(EDI_TCL_DIR)/defaults.tcl

# ---------------------------------------------------------------------------

# Point to key source directories
set BASE_DIR ${SRC}/SDDC

#
# These files are used for RTL simulations (sim rtl)
# RTL simulations use RTL_VLOG_FILES and RTL_VHDL_FILES lists!!!!
# Use " " so that variables get assigned values
#
set RTL_VLOG_FILES "\
$BASE_DIR/CPU.v \
$BASE_DIR/io_controller.v \
$BASE_DIR/memory_controller.v \
$BASE_DIR/Mux4to1.v \
$BASE_DIR/RAM.v \
$BASE_DIR/ROM.v \
$BASE_DIR/system.v \
"

# These files are used by the synthesis tool
set NET $PHOME/syn_dir/netlists
set SYN_VLOG_FILES ${RTL_VLOG_FILES}

# Point to the testbench files to be used
set RTL_TB_FILE $BASE_DIR/system_tb.v
set SYN_TB_FILE $BASE_DIR/system_tb.v
set PNR_TB_FILE $BASE_DIR/system_tb.v

#
# Choreograph RTL compiler flow
#
set RC_TO_DO_LIST { \
${TCL_DIR}/rc/rc_synthesis.tcl \
}

# Choreograph encounter flow
# enc_hitkit.tcl performs place and route
# edi2ic converts gdsii file to OA lib

set ENC_TO_DO_LIST { \
$TCL_DIR/enc/enc_hitkit.tcl \
}

# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
# Floorplanning
# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

# Provide X and Y dimensions of the core
set CORE_X 1000
set CORE_Y 2000

# Set the aspect ratio for the layout
# A values less than 1.0 means wide and not so high!
set ASPECT 0.25

# Establish a boundary outside of the core area 
set CORE_TO_BOUND 15

# Utilization
set UTILIZATION	0.6

# Pin assignments

set N_PINS {acc[0] acc[1] acc[2] acc[3] acc[4] acc[5] acc[6] acc[7]}
set S_PINS {in[0]  in[1] in[2] in[3] in[4] in[5] in[6] in[7]}
set E_PINS {clk}
set W_PINS {reset}

# Spacing in microns between the pins
set N_SPACING 10
set S_SPACING 10
set E_SPACING 10
set W_SPACING 10

# Metal layer that should be used
set N_LAYER 2  
set S_LAYER 2
set E_LAYER 3
set W_LAYER 3

# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
# Power planning
# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

# For the add power ring command
# Width of the metal as well as the separation between gnd and vdd rings
set CORE_RING_SPACING 1
set CORE_RING_WIDTH	3
set CORE_RING_OFFSET 1

# Desired metal layer for the power rings
set PWR_HORIZ_MET metal1
set PWR_VERT_MET metal2

# Power stripes
set STRIPE_WIDTH 5
set STRIPE_SPACE 300
set STRIPE_LAYER metal2

# Name of OA lib we want to export to
set MY_OA_LIB "ediLib"

##############################################################


# We need to do something special with the ncvlog opts
# since we don't have an include directory

set NCVLOG_OPTS	"-cdslib ${CDS_LIB} \
		-hdlvar  ${HDL_VAR} \
                -errormax ${ERR_MAX} \
                -update \
                -linedebug \
                -status "

