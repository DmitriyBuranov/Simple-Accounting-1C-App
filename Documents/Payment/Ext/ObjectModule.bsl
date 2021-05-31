
Procedure Posting(Cancel, Mode)
	RegisterRecords.SpendingAccumulation.Write = True;
	For Each CurRowItems In Items Do
		Record = RegisterRecords.SpendingAccumulation.Add();
		Record.Period = Date;
		Record.Product = CurRowItems.Product;
		Record.Quantity = CurRowItems.Quantity;
		Record.Amount = CurRowItems.Amount;
	EndDo;
EndProcedure
