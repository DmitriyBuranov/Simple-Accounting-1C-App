
&AtServer
Procedure OnOpenAtServer()
	TotalSpentMonth = CalculateSpents();
EndProcedure

&AtServer
Function CalculateSpents()
	
	Query = New Query;
	Query.Text = "SELECT
	             |	SUM(SpendingAccumulationTurnovers.AmountTurnover) AS AmountTurnover
	             |FROM
	             |	AccumulationRegister.SpendingAccumulation.Turnovers(&StartPeriod, &EndPeriod, Period, ) AS SpendingAccumulationTurnovers";
	Query.SetParameter("StartPeriod",BegOfMonth(CurrentDate()));
	Query.SetParameter("EndPeriod",EndOfMonth(CurrentDate()));
	Selection = Query.Execute().Select();
	
	While Selection.Next() do
		Return Selection.AmountTurnover;
	EndDo;	
EndFunction

&AtClient
Procedure OnOpen(Cancel)
	OnOpenAtServer();
EndProcedure

&AtClient
Procedure AddProduct(Command)
	OpenForm( "Catalog.Products.Form.ItemForm");
EndProcedure

&AtClient
Procedure SetPeriodicServices(Command)
	OpenForm( "Document.SetPeriodicServices.Form.DocumentForm");
EndProcedure

&AtClient
Procedure AddPayment(Command)
	OpenForm( "Document.Payment.Form.DocumentForm");
EndProcedure

&AtClient
Procedure Recalculate(Command)
	RecalculateOnServer();
EndProcedure

&AtServer
Procedure RecalculateOnServer()
	TotalSpentMonth = CalculateSpents();
EndProcedure

