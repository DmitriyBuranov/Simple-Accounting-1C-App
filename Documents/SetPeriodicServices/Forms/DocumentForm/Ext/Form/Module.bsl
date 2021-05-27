
&AtServerNoContext
Function ChoiceParamAtServer()	
    Parameters = New Structure;
    SearchParam = New Structure;
	ProductType = Enums.ProductKinds.Service;
    SearchParam.Insert("Kind", ProductType);
	
    Return  Parameters;	
EndFunction

&AtClient
Procedure ServicesServiceStartChoice(Item, ChoiceData, StandardProcessing)
	StandardProcessing = False;
	ChoiseParam = ChoiceParamAtServer();
	OpenForm("Catalog.Products.Form.ChoiceForm", ChoiseParam, Item);	
EndProcedure

