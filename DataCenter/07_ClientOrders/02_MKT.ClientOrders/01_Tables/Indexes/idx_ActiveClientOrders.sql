﻿CREATE NONCLUSTERED INDEX idx_ActiveClientOrders	ON MKT.ClientOrders (ClientOrderIsOpen,ClientID)
INCLUDE (ClientOrderID,ClientOrder,ClientOrderStatusID,ClientOrderStatus,PartID,ClientOrderBalance,ClientOrderDueDateID);
GO