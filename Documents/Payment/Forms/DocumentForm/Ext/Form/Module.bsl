
&AtClient
Procedure ItemsCostOnChange(Item)
	CurrentRow = Items.Items.CurrentData;
	CommonFunctions.ReCalculate(CurrentRow);
EndProcedure

&AtClient
Procedure ItemsQuantityOnChange(Item)
	CurrentRow = Items.Items.CurrentData;
	CommonFunctions.ReCalculate(CurrentRow);
EndProcedure

&AtClient
Procedure ItemsItemOnChange(Item)
	CurrentRow = Items.Items.CurrentData;
	CurrentRow.cost = SavedCost(CurrentRow.Product);
	CommonFunctions.ReCalculate(CurrentRow);
EndProcedure

&AtServer
Function SavedCost(Product)
	Query = New Query;
	Query.Text = "SELECT
	             |	ProductCostsSliceLast.Cost AS Cost
	             |FROM
	             |	InformationRegister.ProductCosts.SliceLast(, Product = &product) AS ProductCostsSliceLast";
	Query.SetParameter("product",Product);	
	Selection = Query.Execute().Select();
	
	While Selection.Next() do
		Return Selection.Cost;
	EndDo;	
EndFunction
