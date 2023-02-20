library ieee;
use ieee.std_logic_1164.all;

entity full_adder_1bit is
port (
	carry_in : in std_logic;
	input_a : in std_logic;
	input_b : in std_logic;
	full_adder_carry_output : out std_logic;
	full_adder_sum_output : out std_logic
);
end full_adder_1bit;

architecture FullAdder of full_adder_1bit is

	signal half_adder_carry_output : std_logic;
	signal half_adder_sum_output : std_logic;

begin
	half_adder_carry_output <= (input_a AND input_b);
	half_adder_sum_output <= (input_a XOR input_b);
	
	full_adder_sum_output <= (half_adder_sum_output XOR carry_in);
	full_adder_carry_output <= ((half_adder_sum_output AND carry_in) OR half_adder_carry_output);
	
end FullAdder;