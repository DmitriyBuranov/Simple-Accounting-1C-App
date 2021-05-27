
Procedure Posting(Cancel, PostingMode)	
	RecordSet = Informationregisters.ServiceCost.CreateRecordSet();
		
	For each Item In Services Do 	   
	   Record = RecordSet.Add(); 	   
	   Record.Cost = Item.Cost;
	   Record.PayDay = Item.PayDay;
	   Record.Period = CurrentSessionDate();
	   Record.ServicesPeriod = Period;
	EndDo; 

	RecordSet.Write(False); 	
EndProcedure

