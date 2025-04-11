library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor_3 is
    port(
        clk         : in  std_logic;
        ena         : in  std_logic;  -- Reset asíncrono (activo en '0')
        f_div_5     : out std_logic;  -- Salida de 5MHz (100MHz/20)
        f_div_2_5   : out std_logic;  -- Salida de 2.5MHz (100MHz/40)
        f_div_1     : out std_logic   -- Salida de 1MHz (100MHz/100)
    );
end entity divisor_3;

architecture Behavioral of divisor_3 is
    -- Contadores para los diferentes divisores
    signal contador_20 : unsigned(4 downto 0) := (others => '0');  -- Módulo 20 -> 5MHz
    signal contador_40 : unsigned(5 downto 0) := (others => '0');  -- Módulo 40 -> 2.5MHZ
    signal contador_100 : unsigned(6 downto 0) := (others => '0'); -- Módulo 100 -> 1MHz

    -- Pulsos de reloj para las distintas frecuencias
    signal pulso_5   : std_logic := '0';
    signal pulso_2_5 : std_logic := '0';  
    signal pulso_1   : std_logic := '0';

begin
    -- Proceso para generar 5MHz
    process(clk, ena)
    begin 
        if ena = '0' then
         contador_20 <= (others => '0');
            pulso_5 <= '1';
        elsif rising_edge(clk) then 
         contador_20 <= contador_20 + 1;
            if contador_20 = "10011" then  -- Reinicia en 20
             contador_20 <= (others => '0');
                pulso_5 <= '1';
            else
                pulso_5 <= '0';
            end if;
        end if;
    end process;

    -- Proceso para generar 2.5MHz
    process(clk, ena)
    begin 
        if ena = '0' then
         contador_40 <= (others => '0');
            pulso_2_5 <= '1';
        elsif rising_edge(clk) then 
         contador_40 <= contador_40 + 1;
            if contador_40 = "100111" then  -- Reinicia en 40
             contador_40 <= (others => '0');
                pulso_2_5 <= '1';
            else
                pulso_2_5 <= '0';
            end if;
        end if;
    end process;
    
    -- Proceso para generar 1MHz
    process(clk, ena)
    begin 
        if ena = '0' then
         contador_100 <= (others => '0');
            pulso_1 <= '1';
        elsif rising_edge(clk) then 
         contador_100 <= contador_100 + 1;
            if contador_100 = "1100011" then  -- Reinicia en 100
             contador_100 <= (others => '0');
                pulso_1 <= '1';
            else
                pulso_1 <= '0';
            end if;
        end if;
    end process;

    -- Asignaciones de salida
    f_div_5  <= pulso_5;
    f_div_2_5 <= pulso_2_5;
    f_div_1  <= pulso_1;

end Behavioral;