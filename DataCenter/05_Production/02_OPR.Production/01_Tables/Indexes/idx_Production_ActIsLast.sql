CREATE NONCLUSTERED INDEX idx_Production_ActISLast ON OPR.Production (ActIsLast)
INCLUDE		(
				[ProductionRowID],
				[ProductionFormID],
				[ProductionForm],
				[WrkOrdID],
				[PartID],
				[ActID],
				[ProductionPass],
				[ProductionFail],
				[ProductionDateID],
				[ProductionDate],
				[ProdTime],
				[WorkCenterID]
			);


GO