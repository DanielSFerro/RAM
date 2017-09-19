library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
	generic
	(
		b	: integer  :=	32;  --Quantidade de bits
		a	: integer  :=	5  --Quantidade de bits do endereço, a quantidade de registradores é 2**5=32
	);


	port
	(
		-- Input ports
		Radd1	: in  std_logic_vector(a-1 downto 0);
		Radd2	: in  std_logic_vector(a-1 downto 0);
		Wadd : in std_logic_vector(a-1 downto 0);
		Wdata: in std_logic_vector(b-1 downto 0);
		Wen: in std_logic;
		reset: in std_logic;
		clk: in std_logic;

		-- Output ports
		Rdata1 : out std_logic_vector(b-1 downto 0);
		Rdata2 : out std_logic_vector(b-1 downto 0)
	);
end register_file;




architecture behavior of register_file is

	-- Declarations (optional)
	type registrador is array (1 to (2**a)-1) of std_logic_vector(b-1 downto 0);
	signal banco_reg : registrador;
	constant zero : std_logic_vector(b-1 downto 0) := (others=>'0');

begin
	
	Rdata1 <= zero when (to_integer(unsigned(Radd1))) = 0 else
				  banco_reg(to_integer(unsigned(Radd1)));
	Rdata2 <= zero when (to_integer(unsigned(Radd1))) = 0 else
				  banco_reg(to_integer(unsigned(Radd1)));
	
	process(clk, reset, Wen, Wdata)
	begin
	
	if (reset = '0') then
	for i in 1 to (2**a)-1 loop
		banco_reg(i) <= (others => '0');
	end loop;
	
	elsif (rising_edge(clk) and Wen='1') then 
		banco_reg(to_integer(unsigned(Wadd))) <= Wdata;
	end if;
	
	end process;

end behavior;





