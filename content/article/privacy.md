+++
title = "Privacy Considerations"
date = 2022-09-22
section = "marginalia-search"
aliases = ["/projects/edge/privacy.gmi"]
draft = false
categories = ["docs"]
+++

This privacy policy is in effect on Marginalia Search.

<table class="min-w-full divide-y divide-gray-200 dark:divide-gray-600 my-4">
<thead>
<tr>
<th class="px-2 py-1 text-left text-xs font-medium text-gray-500 dark:text-gray-100 uppercase tracking-wider">Technology</th>
<th class="px-2 py-1 text-left text-xs font-medium text-gray-500 dark:text-gray-100 uppercase tracking-wider">Use</th>
</tr>
</thead>
<tbody class="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-600 text-xs">
<tr><td class="px-3 py-3">Javascript</td><td class="px-3 py-3">Minimal</td></tr>
<tr><td class="px-3 py-3">Cookies</td><td class="px-3 py-3">Yes<sup>1</sup></td></tr>
<tr><td class="px-3 py-3">Local Storage</td><td class="px-3 py-3">No</td></tr>
<tr><td class="px-3 py-3">Tracking Pixels</td><td class="px-3 py-3">No</td></tr>
<tr><td class="px-3 py-3">Social Media Buttons</td><td class="px-3 py-3">No</td></tr>
<tr><td class="px-3 py-3">Third Party Requests</td><td class="px-3 py-3">No</td></tr>
<tr><td class="px-3 py-3">CDN</td><td class="px-3 py-3">No</td></tr>
<tr><td class="px-3 py-3">Access Log Retention</td><td class="px-3 py-3">24h</td></tr>
</tbody>
</table>

<div class="text-xs text-gray-600 dark:text-gray-400 px-4 mb-4">
[1] Cookies are used to save user settings (only when changing settings), never for anything else.
</div>

<hr>

Search queries are very sensitive and private and as a result logging is at a minimum.

No information about which links are clicked is gathered, and it is not possible to historically 
correlate IP address to search terms.  This non-retention policy exists to be able to comply with 
subpoenas and legal requests without compromising user privacy and without putting the project in 
an adversarial position with the law; I cannot give them information about you that I do not have,
and spirit of the GDPR mandates that I do not collect this information.

A short term window of information retention is necessary to allow things like rate-limiting and to 
diagnose bugs.  After this window is passed, all logs that may contain user queries are shredded. 

With sufficient time and a large IT forensics budget, someone could probably work out who you are and 
what you have searched for.  Measures are taken to make that time consuming and expensive, while at the 
same maintaining some ability to diagnose problems with the set up and infrastructure.


