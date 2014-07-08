Collector
==================================

A short description of each script is below.

To run from your local machine:

ssh <user>@<tpi> -p222 'bash -s' < <script_name>.sh

----------------------------------

pmsXchange

pmsXchange_overview - checks current and aged pmsxchangev2-access logs and outputs each partner that has sent us anything and when the last update was.

pmsxchange_updates - takes a requester ID, outputs the last update sent to us and how many updates we have ever received from the partner.

to use:

./pmsxchange_updates <pms_requestor_id>

----------------------------------

SiteConnect

siteconnect_overview - checks current and aged siteconnect-access logs and outputs each partner that has ever sent us anything and when the last update was sent.

siteconnect_inv - takes a requester ID, outputs the last inventory request and response to this partner.

to use:

./siteconnect_inv <siteconnect_requestor_id>

siteconnect_res - takes a requester ID, outputs the last reservations request and response to this partner.

to use:

./pmsxchange_updates <siteconnect_requestor_id>
