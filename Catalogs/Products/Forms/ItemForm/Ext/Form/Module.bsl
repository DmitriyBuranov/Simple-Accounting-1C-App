
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

&AtClient
Procedure ScanBarCode(Command)
	Write();
	//  #If MobileApplicationClient Then -- doesn't work
	#If МобильноеПриложениеКлиент Then  
	If MultimediaTools.BarcodeScanningSupported() Then
		ScanProcedure = New NotifyDescription("AddBarCode", thisForm);
		MultimediaTools.ShowBarcodeScanning("Scan", ScanProcedure,,BarCodeType.Linear);
	Else
		Message("Not Barcode Scanning Supported!");
	EndIf;
	#Else
	  	Message("Wrong context");
	#EndIf
EndProcedure

&AtClient
Procedure AddBarCode(Barcode, Result, Message, AdditionalParam) Export
	If Result Then
		#If МобильноеПриложениеКлиент  Then
		MultimediaTools.CloseBarcodeScanning();
		#EndIf
		MakeRecord(Barcode);
		Message(Barcode + " added"); 
 	Else
    	Message("Can't scan");  
	EndIf; 
EndProcedure

&AtServer
Procedure MakeRecord(Barcode)
	Record = Informationregisters.Barcodes.CreateRecordManager();
	Record.Barcode = Barcode;
	Record.Product = Object.Ref;
	Record.Write(False);
EndProcedure



