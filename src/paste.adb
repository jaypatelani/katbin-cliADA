with Ada.Text_IO;
with Ada.Json_Utilities;
with HTTP.Client;
with HTTP.Request_Response;
with Interfaces.C;

type Paste_Response is record
   Content : String := "";
   Id      : String := "";
   Is_Url  : Boolean := False;
end record;

function Create_Paste(Body : String) return HTTP.Client.Result is
   Client    : HTTP.Client.Client;
   Json_Data : Ada.Json_Utilities.Json_Value;
   Request   : HTTP.Client.Request;
   Response  : HTTP.Client.Response;
begin
   -- Create the HTTP client
   Client := HTTP.Client.Client.Create;

   -- Create the JSON data for the request
   Json_Data := Ada.Json_Utilities.To_Json(("paste", (("content", Body),)));

   -- Create the request
   Request := Client.Create_Request("POST", "https://katb.in/api/paste");
   Request.Add_Header("Content-Type", "application/json");
   Request.Set_Body(Ada.Json_Utilities.To_String(Json_Data));

   -- Send the request and get the response
   Response := Client.Send_Request(Request);

   -- Return the result
   return Response.Json_Body(Paste_Response'(Unchecked_Access));
end Create_Paste;

