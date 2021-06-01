
Procedure Posting(Cancel, Mode)
	RegisterRecords.SpendingAccumulation.Write = True;
	For Each CurRowItems In Items Do
		RecordSpending = RegisterRecords.SpendingAccumulation.Add();
		RecordSpending.Period = Date;
		RecordSpending.Product = CurRowItems.Product;
		RecordSpending.Quantity = CurRowItems.Quantity;
		RecordSpending.Amount = CurRowItems.Amount;
	EndDo;

	
	RegisterRecords.ProductCosts.Write = True;
	For Each CurRowItems In Items Do
		RecordCosts = RegisterRecords.ProductCosts.Add();
		RecordCosts.Period = Date;
		RecordCosts.Product = CurRowItems.Product;
		RecordCosts.Cost = CurRowItems.Cost;
	EndDo;
EndProcedure
