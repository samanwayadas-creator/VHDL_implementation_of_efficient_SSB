----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:46:06 12/07/2017 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
---- ------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use  IEEE.STD_LOGIC_UNSIGNED.ALL;
use STD.textio.all;
use IEEE.STD_LOGIC_TEXTIO.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity main is
port(
--clk: in std_logic;
clk_200mhz_p: in std_logic;
clk_200mhz_n: in std_logic;
reset: in std_logic; 
imagereject45: out std_logic_vector( 15 downto 0);
--SSB:out std_logic_vector( 15 downto 0);
SSB:out std_logic_vector( 63 downto 0);
imagereject90: out std_logic_vector( 15 downto 0));
end main;

architecture Behavioral of main is
COMPONENT sinecos
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
COMPONENT Losc
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mul
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END COMPONENT;
--component LP
--	port (
--	clk: in std_logic;
--	rfd: out std_logic;
--	rdy: out std_logic;
--	din: in std_logic_vector(15 downto 0);
--	dout: out std_logic_vector(15 downto 0));
--end component;
--component band1
--	port (
--	clk: in std_logic;
----	nd: in std_logic;
--	rfd: out std_logic;
--	rdy: out std_logic; 
--	din: in std_logic_vector(7 downto 0);
--	dout: out std_logic_vector(7 downto 0));
--end component;
COMPONENT band1
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

--component band2
--	port (
--	clk: in std_logic;
--	rfd: out std_logic;
--	rdy: out std_logic;
--	din: in std_logic_vector(7 downto 0);
--	dout: out std_logic_vector(7 downto 0));
--end component;
COMPONENT band2
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

--component hilbert
--	port (
--	clk: in std_logic;
--	rfd: out std_logic;
--	rdy: out std_logic;
--	din: in std_logic_vector(15 downto 0);
--	dout: out std_logic_vector(15 downto 0));
--end component;
COMPONENT fir_compiler_hilbert
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
COMPONENT mult_gen_0
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END COMPONENT;
COMPONENT mult_gen_1
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
-------clk_9.8mhz_gen-------------------------------
component clk_wiz_0
port
 (-- Clock in ports
  clk_in1_p         : in     std_logic;
  clk_in1_n         : in     std_logic;
  -- Clock out ports
  clk_out1          : out    std_logic;
  -- Status and control signals
  reset             : in     std_logic;
  locked            : out    std_logic
 );
end component;
COMPONENT fir_compiler_0
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
  );
END COMPONENT;
signal rfd1,rfd2,rfd3,rfd4,rdy1,rdy2,rdy3,rdy4,rfd5,rfd6,rdy6,rdy5,rdy7,rfd7,nd1:std_logic;
--signal mulout1,mulout2:std_logic_vector(15 downto 0);
signal mulout1,mulout2:std_logic_vector(47 downto 0);
signal mulout3,conventional_op:std_logic_vector(47 downto 0);
signal mulout4:std_logic_vector(31 downto 0);
--signal mu1out3,mulout4:integer;
--signal lpout1,lpout2,hilout,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13: std_logic_vector(15 downto 0);
signal sine1,sine2,cosine1,cosine2:std_logic_vector(15 downto 0);
signal bpout1,bpout2:std_logic_vector(31 downto 0);
signal SSB_op:std_logic_vector(47 downto 0);
--signal sin1,sin2,cos1,cos2: integer;
signal rf_valid,lo_valid: std_logic;
signal message_signal,lo_signal: std_logic_vector(31 downto 0);
--sine1<=std_logic_vector( to_signed(sin1,sin1'length));
signal lock_clk: std_logic;
signal clk_9_8_mhz:std_logic;
signal counter: integer range 0 to 255;
signal clk_49khz: std_logic;
signal final_op: std_logic_vector(63 downto 0);
signal final_op_conventional: std_logic_vector(63 downto 0);
signal hilbert_op: std_logic_vector(31 downto 0);
begin
clk_9_8mhz_gen : clk_wiz_0
   port map ( 
   -- Clock in ports
   clk_in1_p => clk_200mhz_p,
   clk_in1_n => clk_200mhz_n,
  -- Clock out ports  
   clk_out1 => clk_9_8_mhz,
  -- Status and control signals                
   reset => reset,
   locked => lock_clk            
 );

 
 process(clk_9_8_mhz)
  begin
  if (reset ='1') then
  clk_49khz<='0';
  counter<=0;
  elsif rising_edge(clk_9_8_mhz) then
      if (counter =199) then
          clk_49khz <= '1';
          counter <= 0;                     
      else
          counter <= counter + 1;
        clk_49khz <= '0';
      end if;                
  end if;
end process;
 
 
--RF: sinecos---1kz
--		port map (
--			clk => clk_49khz,
--	 		cosine => cosine2,
--			sine => sine2);		
RF : sinecos
              PORT MAP (
                aclk => clk_49khz,
                aresetn => not(reset),
                m_axis_data_tvalid => rf_valid,
                m_axis_data_tdata => message_signal  --1khz
              );			
	sine2<=message_signal(31 downto 16);
	cosine2<=message_signal(15 downto 0);		
			
			
			
			
--LO: Losc---5kz
--		port map (
--			clk => clk_49khz,
--	 		cosine => cosine1,
--			sine => sine1);			
LO : Losc
              PORT MAP (
                aclk => clk_49khz,
                aresetn => not(reset),
                m_axis_data_tvalid => lo_valid,
                m_axis_data_tdata => lo_signal
              );
  sine1<=lo_signal(31 downto 16);--5khz
  cosine1<=lo_signal(15 downto 0); ---5khz         
              
              			
	
mul1: mul
		port map ( 
			clk => clk_49khz,
	 		a => bpout1,
			b => cosine1,
			p => mulout1);	
			
		
mul2: mul
		port map (
			clk => clk_49khz,
	 		a => bpout2,
			b => sine1,
			p => mulout2);	
			
--LP1: LP
--	port map (
--		clk=> clk,
--		rfd=> rfd1,
--		rdy=> rdy1,
--		din=>mulout1, 
--		dout=>lpout1 );
--		
--LP2: LP
--	port map (
--		clk=> clk,
--		rfd=> rfd2,
--		rdy=> rdy2,
--		din=>mulout2,
--		dout=>lpout2 );
		
--BP1: band1
--	port map (
--		clk=> clk_49khz,
--		--nd=> nd1,
--		rfd=> rfd3,
--		rdy=> rdy4,
--		din=>sine2,
--		dout=>bpout1 );
		
BP1 : band1
          PORT MAP (
            aclk => clk_49khz,
            s_axis_data_tvalid => '1',
            s_axis_data_tready => open,
            s_axis_data_tdata => sine2,
            m_axis_data_tvalid => open,
            m_axis_data_tdata => bpout1
          );		
		
		
		
		

--BP2: band2
--	port map (
--		clk=> clk_49khz,
--		rfd=> rfd5,
--		rdy=> rdy6,
--		din=>sine2,
--		dout=>bpout2);
BP2 : band2
          PORT MAP (
            aclk => clk_49khz,
            s_axis_data_tvalid => '1',
            s_axis_data_tready => open,
            s_axis_data_tdata => sine2,
            m_axis_data_tvalid => open,
            m_axis_data_tdata => bpout2
          );		
final_filter : fir_compiler_0
            PORT MAP (
              aclk => clk_49khz,
              s_axis_data_tvalid => '1',
              s_axis_data_tready => open,
              s_axis_data_tdata => SSB_op,
              m_axis_data_tvalid => open,
              m_axis_data_tdata => final_op
            );		
		
--
--H: hilbert
--	port map (
--		clk=> clk,
--		rfd=> rfd7,
--		rdy=> rdy7,
--		din=>lpout1,
--		dout=>hilout);		
				
	
--sin2<=to_integer(signed(sine2));
--cos2<=to_integer(signed(cosine1));
--sin1<=to_integer(signed(sine1));
--mulout1<= std_logic_vector(to_signed(mu1out3,mulout1'length));
--mulout2<= std_logic_vector(to_signed(mulout4,mulout2'length));
--process(clk)
--begin 
--if rising_edge(clk) then
--d1<=lpout2;	
--d2<=d1;
--d3<=d2;
--d4<=d3;	
--d5<=d4;
--d6<=d5;
--d7<=d6;	
--d8<=d7;
--d9<=d8;
--d10<=d9;	
--d11<=d10;
--d12<=d11;
--d13<=d12;	
--end if;
--mu1out3<= sin2*cos2;
--mulout4<= sin1*sin2;
--imagereject45<= bpout1;--+bpout2;
--imagereject90<= hilout+lpout2;
SSB_op<=mulout1+mulout2;
ssb<=final_op;

--------------------------------------conventional method--------------------------------

hilbert : fir_compiler_hilbert
  PORT MAP (
    aclk => clk_49khz,
    s_axis_data_tvalid => '1',
    s_axis_data_tready => open,
    s_axis_data_tdata => sine2,
    m_axis_data_tvalid => open,
    m_axis_data_tdata => hilbert_op
  );

mul3 : mult_gen_0
  PORT MAP (
    CLK => clk_49khz,
    A => hilbert_op,
    B => sine1,
    P => mulout3
  );

mult4 : mult_gen_1
  PORT MAP (
    CLK => clk_49khz,
    A => sine2,
    B => cosine1,
    P => mulout4
  );
conventional_op<=mulout3+mulout4;

final_filter_conventional : fir_compiler_0
            PORT MAP (
              aclk => clk_49khz,
              s_axis_data_tvalid => '1',
              s_axis_data_tready => open,
              s_axis_data_tdata => conventional_op,
              m_axis_data_tvalid => open,
              m_axis_data_tdata => final_op_conventional
            );	



stim_proc: process(clk_49khz)
	             file outfile : text is out "ssb_dual_filter_OUTPUT.txt";
	             file outfile1 : text is out "ssb_conventional_OUTPUT.txt";
                 variable D :std_logic_vector(63 downto 0);
                 variable D1 :std_logic_vector(63 downto 0);
                 variable buf : line;
                 variable buf1 : line;
	       BEGIN
	           if clk_49khz'event and clk_49khz='1' then
		       D:=final_op;
		       D1:=final_op_conventional;
             write(buf,D);
             writeline(outfile,buf);
		       write(buf1,D1);
             writeline(outfile1,buf1);
		   -- end if;
         end if;
		
	END PROCESS;













--end process;
end Behavioral;

