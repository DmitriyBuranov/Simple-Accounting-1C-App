
&AtClient
Procedure KindOnChange(Item)
	ShowProp();
EndProcedure

&AtClient
Procedure OnOpen(Cancel)
	ShowProp();
EndProcedure

&AtServerNoContext
Function TypeForProduct()
	Return Enums.ProductKinds.Product;
Endfunction

&AtServerNoContext
Function TypeForSrvice()
	Return Enums.ProductKinds.Service;
Endfunction

&AtClient
Procedure ShowProp()
	If Object.Kind =  TypeForProduct() then
		Items.ProductsType.Visible = True;
		Items.Periodicity.Visible = False;
	EndIf;
	
	If Object.Kind =  TypeForSrvice() then
	    Items.ProductsType.Visible = False;
		Items.Periodicity.Visible =  True;
	EndIf;
EndProcedure

