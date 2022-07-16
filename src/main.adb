with Calendar, Ada.Text_IO, Ada.Integer_Text_IO, Ada.Task_Identification, Ada.Numerics.Discrete_Random;
use Calendar, Ada.Text_IO, Ada.Integer_Text_IO, Ada.Task_Identification;

procedure main is
   type RandomGas is range 0 .. 1;
   package RandomGasInt is new Ada.Numerics.Discrete_Random(RandomGas);

   task Central is
      entry ReportPressure(L: in RandomGas; Id: in Task_Id);
   end Central;

   task body Central is
      T:Integer:=0;
      Id:Task_Id;
      Interval : constant Duration := Duration (20);
   begin
      loop
         select
            accept ReportPressure(L: in RandomGas; Id: in Task_Id) do
               if L = 1 then
                  Put_Line("INFO: Sensor " & Image(Id) & " have normal pressure");
                  Put_Line ("");
               else
                  Put_Line("WARNING: Sensor " & Image(Id) & " have low pressure");
                  Put_Line ("The Network will be disabled...");
                  Put_Line ("");
               end if;
            end ReportPressure;
         or
            delay Interval;
            Put_Line ("Sensor Fail comunicate Status");
            Put_Line ("The Network will be disabled...");
            Put_Line ("");
         end select;
      end loop;
   end Central;

   task type GasSensor is
      entry Activate;
   end GasSensor;

   task body GasSensor is
      L:RandomGas;
      Seed: RandomGasInt.Generator;
      Id:Task_Id;
   begin
      RandomGasInt.Reset(seed);
      loop
         select
            accept Activate do
               Id:=GasSensor'Identity;
               L:=RandomGasInt.Random(Seed);
               Central.ReportPressure(L,Id);
            end Activate;
         end select;
      end loop;
   end GasSensor;

   type GasSensorArray is array (Integer range 1 .. 7) of GasSensor;
   GasSensors : GasSensorArray;

   task Activation;
   task body Activation is
   begin
      loop
         for I in 1 .. 7 loop
            GasSensors(I).Activate;
            delay 2.0;
         end loop;
      end loop;
   end Activation;

begin
   null;

end main;
