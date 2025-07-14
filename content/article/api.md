+++
title = "API"
date = 2023-03-23
section = "marginalia-search"
aliases = ["/projects/edge/api.gmi"]
draft = false
categories = ["docs", "outdated"]
+++

An API for the search engine is available through <span class="text-red-900 dark:text-red-100">`api.marginalia.nu`</span>, or <span class="text-red-900 dark:text-red-100">`api.marginalia-search.com`</span>.  Both endpoints are equivalent and will work as long as the project does.

The API is simple enough to be self-explanatory. Examples:

<div class="overflow-auto text-xs text-gray-700 dark:text-gray-200 p-2">

```
https://api.marginalia.nu/public/
https://api.marginalia.nu/public/search/json+api
https://api.marginalia.nu/public/search/json+api?count=10
```

</div>

For experimentation, the key "public" is available, as used in the examples on this page. This key has a shared rate limit across all consumers. When this rate limit is hit a HTTP status 503 is returned. 



### Query Parameters

<div class="border rounded p-2 m-1 dark:text-slate-300 text-slate-800">

<table>
<tr>
<td class="font-bold">Param</td>
<td class="font-bold">Value</td>
<td class="font-bold">Description</td>
</tr>
<tr>
<td>count</td><td>int</td><td>Number of Results</td>
</tr>
<tr>
<td>dc</td><td>int</td><td>Max number of results per domain</td>
</tr>
<tr> <td class="align-top">nsfw</td><td>0</td><td>no filter</tr></tr>
<tr> <td class="align-top">nsfw</td><td>1</td><td>(experimental) reduce extreme results</tr></tr>
<tr>
<td>index</td><td>int</td><td>deprecated</td>
</tr>
</table>

</div>

## Key and license

Please send an email to contact@marginalia-search.com if you want your own key with a separate rate limit. The search engine has seen quite a lot of problems with bot abuse, making this registration step a sad necessity. 

By default the data is provided under the CC-BY-NC-SA 4.0 license. Other licensing and terms are negotiable.

* [CC-BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)

# Sample code in python 3
<div class="text-xs overflow-auto border rounded m-1 p-1">

```python
import requests

url = "https://api.marginalia.nu/{key}/search/{query}";

rsp = requests.get(url.format(key='public', query="linear b"));

if rsp.ok:
  data = rsp.json()
  print ("Query: ", data['query'])
  print ("License: ", data['license'])
  print ("")
  for result in data['results']:
      print (result['url'])
      print ("\t" + result['title'])
      print ("\t" + result['description'])
      print ("")
else:
    print ("Bad Status " + str(rsp.status_code))
```

</div>

# Something missing?

Please let me know if there are features you would like added to the API.

# See also

* [Data sets from the search engine](https://downloads.marginalia.nu/)
