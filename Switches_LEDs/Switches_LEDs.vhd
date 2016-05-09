library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Switches_LEDs is
    Port ( switch_0 : in  STD_LOGIC;
           switch_1 : in  STD_LOGIC;
			  switch_2 : in  STD_LOGIC;
           switch_3 : in  STD_LOGIC;
			  switch_4 : in  STD_LOGIC;
           switch_5 : in  STD_LOGIC;
			  switch_6 : in  STD_LOGIC;
           switch_7 : in  STD_LOGIC;
           LED_0 : out  STD_LOGIC;
			  LED_1 : out  STD_LOGIC;
			  LED_2 : out  STD_LOGIC;
			  LED_3 : out  STD_LOGIC;
			  LED_4 : out  STD_LOGIC;
			  LED_5 : out  STD_LOGIC;
			  LED_6 : out  STD_LOGIC;
           LED_7 : out  STD_LOGIC);
end Switches_LEDs;

architecture Behavioral of Switches_LEDs is
begin
	LED_0 <= switch_0;
	LED_1 <= switch_1;
	LED_2 <= switch_2;
	LED_3 <= switch_3;
	LED_4 <= switch_4;
	LED_5 <= switch_5;
	LED_6 <= switch_6;
	LED_7 <= switch_7;
end Behavioral;