
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

&AtClient
Procedure AddByBarCode(Command)
	Write();
	//  #If MobileApplicationClient Then -- doesn't work
	#If МобильноеПриложениеКлиент  Then
	If MultimediaTools.BarcodeScanningSupported() Then
		ScanProcedure = New NotifyDescription("ScanBarCode", thisForm);
		MultimediaTools.ShowBarcodeScanning("Scan", ScanProcedure,,BarCodeType.Linear);
	Else
		Message("Not Barcode Scanning Supported!");
	EndIf;
	#Else
	  	Message("Wrong context");
	#EndIf
EndProcedure

&AtClient
Procedure ScanBarCode(Barcode, Result, Message, AdditionalParam)Export
	If Result Then
		#If МобильноеПриложениеКлиент  Then
		MultimediaTools.CloseBarcodeScanning();
		#EndIf
		FindProductByBarCode(Barcode);		
 	Else
    	Message("Can't scan");  
	EndIf; 
EndProcedure

&AtServer
Procedure  FindProductByBarCode(Barcode)
	Query = New Query;
	Query.Text = "SELECT
	             |	Barcodes.Product AS Product
	             |FROM
	             |	InformationRegister.Barcodes AS Barcodes
	             |WHERE
	             |	Barcodes.Barcode = &Barcode";
	Query.SetParameter("Barcode",Barcode);
	Selection = Query.Execute().Select();
	
	While Selection.Next() do
		Product = Selection.Product;
	EndDo;
	
	If ValueIsFilled(Product) then
		NewString = object.Items.Add();
		NewString.Product = Product;
		NewString.Cost = SavedCost(Product);
	Else
		Message("Can't find product by this Barcode");
	EndIf;
EndProcedure 

&AtServer
Procedure ItemsOnChangeAtServer()
	object.DocumentSum = object.Items.Total("Amount");
EndProcedure

&AtClient
Procedure ItemsOnChange(Item)
	ItemsOnChangeAtServer();
EndProcedure
