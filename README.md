Collector
==================================

A short description of each script is below.

----------------------------------

pmsXchange

pmsXchange_overview - checks current and aged pmsxchangev2-access logs and outputs each partner that has sent us anything and when the last update was.

pmsxchange_updates - takes a requester ID, outputs the last update sent to us and how many updates we have ever received from the partner.

to use:

./pmsxchange_updates.sh <pms_requestor_id>

----------------------------------

SiteConnect

siteconnect_overview - checks current and aged siteconnect-access logs and outputs each partner that has ever sent us anything and when the last update was sent.
Options:
-r - returns partners from recent logs (usually today and yesterday).
-a - retursn partners from aged logs (usually 2 days ago and as far back as the logs go).

siteconnect_inv - takes a requester ID, outputs the last inventory request and response to this partner.

to use:

./siteconnect_inv.sh <siteconnect_requestor_id>

siteconnect_res - takes a requester ID, outputs the last reservations request and response to this partner.

to use:

./pmsxchange_updates.sh <siteconnect_requestor_id>
