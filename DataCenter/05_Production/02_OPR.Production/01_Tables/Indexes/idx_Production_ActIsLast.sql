CREATE NONCLUSTERED INDEX idx_Production_ActISLast ON OPR.ProductionReport (ActIsLast)
INCLUDE		(
				[ProductionRowID],
				[ProductionFormID],
				[ProductionForm],
				[WrkOrdID],
				[PartID],
				[ActID],
				[ProductionPassQuant],
				[ProductionFailQuant],
				[ProductionDateID],
				[ProductionDate],
				[ProdTime],
				[WorkCenterID]
			);


GO