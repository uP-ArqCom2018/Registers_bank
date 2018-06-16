--Test bench para el banco de registros

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
          

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
      C_i : IN     std_logic_vector(bit_dir_reg-1 downto 0);    
      Reg_W_i: IN		std_logic;
      RST_i : IN     std_logic;
      CLK_i:  IN	 std_logic;
      W_c_i : IN     std_logic_vector(n_reg-1 downto 0);
      R_a_o : OUT    std_logic_vector(n_reg-1 downto 0);
      R_b_o : OUT    std_logic_vector(n_reg-1 downto 0));
END COMPONENT;

CONSTANT n_reg : integer := 64; 
CONSTANT bit_dir_reg : integer := 5;
--CONSTANT clk_period : ingeger := 10;  -- 10 ns -> 100 MHz
signal A_i,B_i,C_i: std_logic_vector(bit_dir_reg-1 downto 0);
signal W_c_i, R_a_o, R_b_o: std_logic_vector(n_reg-1 downto 0);
signal RST_i, Reg_W_i, CLK_i: std_logic;    
signal R_a_aux, R_b_aux: std_logic_vector(n_reg-1 downto 0);

BEGIN
  -- put concurrent statements here.
--intancio el componente 
uut: bank_reg generic map(n_reg,bit_dir_reg)
		port map(A_i,B_i,C_i,Reg_W_i,RST_i,CLK_i,W_c_i,R_a_o,R_b_o);

stimul_clk: process 
begin
	CLK_i <= '1';
	wait for 5 ns;
	
	CLK_i <= '0';
	wait for 5 ns;
	
end process;


stimul_proc: process
  variable errors: boolean := false;  -- variable para detectar errores
  --variable R_a_aux, R_b_aux: std_logic_vector(n_reg-1 downto 0); -- variables que se usan en stimul_proc
begin
  -- Se coloca un valor conocido en los registros.
  RST_i<='1';  
  Reg_W_i <= '1';	-- Se coloca el banco en modo escritura
  
	FOR i IN 0 TO 2**bit_dir_reg-1 LOOP
	
		C_i <= std_logic_vector(to_unsigned(i,bit_dir_reg));	-- Direccion 
  		W_c_i <= std_logic_vector(to_unsigned(i,n_reg));	-- Valor que se guarda en el banco de registros (del 0 al 31)
  		wait for 10 ns; -- espera un periodo de clock y vuelve a escribir
  	
  	END LOOP;
  -- Aqui ya se encuentran los valores almacenados en el banco de registros	
  
  Reg_W_i <= '0';	-- modo solo lectura 
  
 	FOR i IN 0 TO 2**bit_dir_reg-1 LOOP
   		A_i <= std_logic_vector(to_unsigned(i,bit_dir_reg)); -- direccion que se quiere leer
    	B_i <= std_logic_vector(to_unsigned(i,bit_dir_reg)); -- direccion que se quiere leer

    	R_a_aux <= std_logic_vector(to_unsigned(i,n_reg)); -- Se almacena el valor que deberia haber en la salida cuando se lee el registro
   		R_b_aux <= std_logic_vector(to_unsigned(i,n_reg));
    
    	wait for 10 ns;
    
    
    if R_a_o /= R_a_aux then -- se controla que el valor leido sea correcto
    	 assert false
    	 report "ERROR EN LECTURA DE A";
    	 errors := true;
  	end if;
  	
  	if R_b_o /= R_b_aux then -- se controla que el valor leido sea correcto
    	 assert false
    	 report "ERROR EN LECTURA DE B";
    	 errors := true;
  	end if;
  	wait for 10 ns;
  		
  END LOOP;
 
  -- Reportar si hubo errores
	assert not errors 
	report "Fallo el testeo"
	severity note;

	assert errors
  	report "Paso el testeo"
  	severity note;
  
  	RST_i<='0'; --Reseteo el banco y compruebo
  	
  	wait for 10 ns;
  	
  	RST_i<='1';
  
	FOR i IN 0 TO 2**bit_dir_reg-1 LOOP
    
    	A_i <= std_logic_vector(to_unsigned(i,bit_dir_reg)); -- direccion que se quiere leer
    	B_i <= std_logic_vector(to_unsigned(i,bit_dir_reg)); -- direccion que se quiere leer
  
    	R_a_aux <= std_logic_vector(to_unsigned(i,n_reg)); -- Se almacena el valor que deberia haber en la salida cuando se lee el registro
   		R_b_aux <= std_logic_vector(to_unsigned(i,n_reg));  		

    if R_a_o /= R_a_aux then -- se controla que el valor leido sea correcto
    	 assert false
    	 report "ERROR EN LECTURA DE A, POST-RESET";
    	 errors := true;
  	end if;
  	
  	if R_b_o /= R_b_aux then -- se controla que el valor leido sea correcto
    	 assert false
    	 report "ERROR EN LECTURA DE B, POST-RESET";
    	 errors := true;
  	end if;
  	
  	wait for 10 ns;  		 		
  	
  END LOOP;
  
    
  wait;

end process;


  
END ARCHITECTURE Behavioral; -- Of entity bank_reg_tb
