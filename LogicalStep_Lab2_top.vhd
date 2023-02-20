library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb_n				: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port (
		clk				: in	std_logic := '0';
		DIN2				: in	std_logic_vector(6 downto 0);
		DIN1				: in	std_logic_vector(6 downto 0);
		DOUT				: out	std_logic_vector(6 downto 0);
		DIG2				: out	std_logic;
		DIG1				: out std_logic
	);
	end component;
	
	component PB_Inverters port (
		pb_n		:	in std_logic_vector(3 downto 0);
		pb			:	out std_logic_vector(3 downto 0)
	);
	end component;
	
	component logic_proc port (
		logic_in0	:	in	std_logic_vector(3 downto 0);
		logic_in1	:	in std_logic_vector(3 downto 0);
		logic_processor : in std_logic_vector(1 downto 0);
		logic_out	:	out	std_logic_vector(3 downto 0)
	);
	end component;
	
	component full_adder_4bit port (
		carry_in : in std_logic;
		bus0 : in std_logic_vector(3 downto 0);
		bus1 : in std_logic_vector(3 downto 0);
		
		carry_out : out std_logic; 
		sum : out std_logic_vector(3 downto 0)
	);
	end component;
	
	
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal hex_A		: std_logic_vector(3 downto 0);
	signal hex_B		: std_logic_vector(3 downto 0);
	
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal seg7_B		: std_logic_vector(6 downto 0);
	
	signal pb			: std_logic_vector(3 downto 0);
	
	signal full_adder_4bit_hex_carry_out : std_logic;	
	signal full_adder_4bit_hex_sum : std_logic_vector(3 downto 0);
	
	signal hex_carryout_output : std_logic_vector(3 downto 0);
	


	
	
	
	
-- Here the circuit begins

begin

	hex_A <= sw(3 downto 0);
	hex_B <= sw(7 downto 4);
	hex_carryout_output <= "000" & full_adder_4bit_hex_carry_out;
	
--COMPONENT HOOKUP

-- generate the seven segment coding

	INST1: SevenSegment port map(full_adder_4bit_hex_sum, seg7_A);
	INST2: SevenSegment port map(hex_carryout_output, seg7_B);
	INST3: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1);
	INST4: PB_Inverters port map(pb_n, pb);
	INST5: logic_proc port map(hex_A, hex_B, pb(1 downto 0), leds(3 downto 0));
	INST6: full_adder_4bit port map('0', hex_A, hex_B, full_adder_4bit_hex_carry_out, full_adder_4bit_hex_sum);
 
end SimpleCircuit;

