library ieee;
use ieee.std_logic_1164.all;

entity full_adder_4bit is
port (
	carry_in : in std_logic;
	bus0 : in std_logic_vector(3 downto 0);
	bus1 : in std_logic_vector(3 downto 0);
	
	carry_out : out std_logic; 
	sum : out std_logic_vector(3 downto 0)
);

end full_adder_4bit;

architecture Full4BitAdder of full_adder_4bit is

	component full_adder_1bit port (
		carry_in : in std_logic;
		input_a : in std_logic;
		input_b : in std_logic;
		full_adder_carry_output : out std_logic;
		full_adder_sum_output : out std_logic
	);
	end component;
	
	signal sum0 : std_logic;
	signal sum1 : std_logic;
	signal sum2 : std_logic;
	signal sum3 : std_logic;

	signal carry_out0 : std_logic;
	signal carry_out1 : std_logic;
	signal carry_out2 : std_logic;
	
begin 
	INST1: full_adder_1bit port map(carry_in, bus0(0), bus1(0), carry_out0, sum0);
	INST2: full_adder_1bit port map(carry_out0, bus0(1), bus1(1), carry_out1, sum1);
	INST3: full_adder_1bit port map(carry_out1, bus0(2), bus1(2), carry_out2, sum2);
	INST4: full_adder_1bit port map(carry_out2, bus0(3), bus1(3), carry_out, sum3);
	sum <= sum3 & sum2 & sum1 & sum0;

end Full4BitAdder;



	