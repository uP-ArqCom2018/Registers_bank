-- Se realiza un banco de registros, con las siguientes entradas A_i, B_i, C_i y W_c_i
-- Salidas: R_a_o y R_b_o.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY bank_reg IS
  GENERIC(
    n : integer := 4;  -- cantidad de bits registros
    cant : integer := 4);  -- cantidad de registros
    PORT(
      A_i : IN     std_logic_vector(n-1 downto 0);
      B_i : IN     std_logic_vector(n-1 downto 0);
      C_i : IN     std_logic_vector(n-1 downto 0);
      CLK_i : IN     std_logic;
      W_c_i : IN     std_logic_vector(n-1 downto 0);
      R_a_o : OUT    std_logic_vector(n-1 downto 0);
      R_b_o : OUT    std_logic_vector(n-1 downto 0));
END ENTITY bank_reg;

ARCHITECTURE Behavioral OF bank_reg IS
  -- put declarations here.
BEGIN
 
 
 
  -- put concurrent statements here.
END ARCHITECTURE Behavioral; -- Of entity bank_reg


