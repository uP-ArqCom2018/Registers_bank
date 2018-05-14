--Test bench para el banco de registros

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;           

ENTITY bank_reg_tb IS
END ENTITY bank_reg_tb;

ARCHITECTURE Behavioral OF bank_reg_tb IS
  -- Declaro el componente del banco de registros
COMPONENT bank_reg
	GENERIC(
    n_reg : integer := 64;  -- cantidad de bits registros
    bit_dir_reg : integer := 5);  -- cantidad de registros
    PORT(
      A_i : IN     std_logic_vector(bit_dir_reg-1 downto 0);
      B_i : IN     std_logic_vector(bit_dir_reg-1 downto 0);
      C_i : IN     std_logic_vector(bit_dire_reg-1 downto 0);    
      Reg_W_i: IN		std_logic;
      CLK_i : IN     std_logic;
      W_c_i : IN     std_logic_vector(n_reg-1 downto 0);
      R_a_o : OUT    std_logic_vector(n_reg-1 downto 0);
      R_b_o : OUT    std_logic_vector(n_reg-1 downto 0));
END COMPONENT;

CONSTANT n_reg : integer := 64; 
CONSTANT bit_dir_reg : integer := 5;
signal A_i,B_i,C_i: std_logic_vector(bit_dir_reg-1 downto 0);
signal W_c_i, R_a_o, R_b_o: std_logic_vector(n_reg-1 downto 0);
signal CLK_i, Reg_W_i: std_logic;

BEGIN
  -- put concurrent statements here.
--intancio el componente 
uut: bank_reg generic map(n_reg,bit_dir_reg)
		port map(A_i,B_i,C_i,Reg_W_i,CLK_i,W_c_i,R_a_o,R_b_o);

stimul: process

begin
            
wait;
end process;
  
END ARCHITECTURE Behavioral; -- Of entity bank_reg_tb
