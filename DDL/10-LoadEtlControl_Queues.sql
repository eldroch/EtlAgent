INSERT INTO ctrl.ETL_Queues_Dim
(QueueName,DefaultOrderSequence)
VALUES
('Extract source to flat file',1)
,('Load flat file into staging table',2)
,('Insert CDC records into temporal table',3)
,('Refresh replication table',4)
,('Extract deltas to flat file',5)
