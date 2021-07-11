
&AtServer
Procedure OnOpenAtServer()
	// Insert handler content
EndProcedure

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
