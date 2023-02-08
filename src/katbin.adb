with Ada.Text_IO;
with Ada.Command_Line;

procedure Katbin is

-- Define the command line arguments
type Cli_Data is record
Body1 : String (1..1024);
end record;
package Cli_Args is new Ada.Command_Line.Generic_Parse (Cli_Data);
use Cli_Args;

-- Read input from standard input
function Stdin_To_Args return Argument_List is
Input : String (1..1024) := Ada.Text_IO.Get_Line;
Args : Argument_List;
begin
Args := Argument_List'(1 => To_Argument (Input));
return Args;
end Stdin_To_Args;

function Create_Paste (Body1 : String) return String is
begin
return Body1;
end Create_Paste;

Args : Cli_Data;
Input : Argument_List;
Paste_ID : String;

begin

-- Check if input is from standard input
if Ada.Text_IO.End_Of_File then
Args := Cli_Args.Parse;
else
Input := Stdin_To_Args;
Args := Cli_Args.Parse (Input);
end if;

-- Call the paste creation function
Paste_ID := Create_Paste (Args.Body1);

-- Print the paste ID
Ada.Text_IO.Put_Line ("https://katb.in/" & Paste_ID);

end Katbin;
