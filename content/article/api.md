+++
title = "API"
date = 2025-12-08
section = "marginalia-search"
aliases = ["/projects/edge/api.gmi"]
draft = false
categories = ["docs"]
+++

## New API

The updated API for the search engine is available through <span class="text-red-900 dark:text-red-100">`api2.marginalia-search.com`</span>.

For all requests, pass the API-Key using the API-key header.  If you want to develop an integration, but do not yet have an API key,
you can use the API key `public`.  Note that it is blocked from creating custom filters, and very often hits a rate limit.

### Obtaining a Key
Please send an email to contact@marginalia-search.com if you want a non-commercial key with a separate rate limit for free.  The email step is necessary to prevent abuse.  If you want to skip the line and/or help support the search engine, you can also [buy a non-commercial API key](https://polar.sh/marginalia-search/products/227939be-61e6-4fab-bb81-10b7171b0cc5).  Though this is **optional**, and will always remain optional!

Non-commercial access provided under the [CC-BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) license.

Keys with no non-commercial restrictions or attribution requirements can be [bought here](https://polar.sh/marginalia-search).

## Getting Started

To make a test request using the public sample key, which is very often overloaded, you can for example call 

<div class="overflow-auto text-xs text-gray-700 dark:text-gray-200 p-2">

```bash
$ curl -H"API-Key: ${API_KEY}" -XGET https://api2.marginalia-search.com/search?query=json+api
```

</div>


These query parameters are understood

<div class="border rounded p-2 m-1 dark:text-slate-300 text-slate-800">

<table>
<tr>
<td class="font-bold">Param</td>
<td class="font-bold">Value</td>
<td class="font-bold">Description</td>
</tr>
<tr>
<td>count</td><td>1-100</td><td>Number of Results</td>
</tr>
<tr>
<td>timeout</td><td>50-250</td><td>Query execution timeout (ms)</td>
</tr>
<tr>
<td>dc</td><td>1-100</td><td>Max number of results per domain</td>
</tr>
<tr>
<td>page</td><td>int</td><td>Select results page (1-indexed)</td>
</tr>
<tr> <td class="align-top">nsfw</td><td>0</td><td>no filter</tr></tr>
<tr> <td class="align-top">nsfw</td><td>1</td><td>(experimental) reduce extreme results</tr></tr>
<td>filter</td><td>string</td><td>Use custom filter</td>
</table>

</div>

### Sample code in Python 3

```python
import requests

url = "https://api2.marginalia-search.com/search?query={query}";

rsp = requests.get(url.format(query="linear b"), headers={'API-Key': 'public'});

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

### Filters

It is possible to set up custom filters for your API key.  This is not allowed on the `public` key,
using these API endpoints.

<div class="border rounded p-2 m-1 dark:text-slate-300 text-slate-800">
<table>
<tr>
<td class="font-bold">Method</td>
<td class="font-bold">Endpoint</td>
<td class="font-bold">Description</td>
</tr>
<tr>
<td>GET</td>
<td class="font-mono px-1">/filter</td>
<td>List configured filters</td>
</tr>
<tr>
<td>POST</td>
<td class="font-mono px-1">/filter/NAME</td>
<td>Create a new filter, NAME.</td>
</tr>
<tr>
<td>GET</td>
<td class="font-mono px-1">/filter/NAME</td>
<td>Retrieve filter definition for NAME</td>
</tr>
<tr>
<td>DELETE</td>
<td class="font-mono px-1">/filter/NAME</td>
<td>Delete custom filter NAME</td>
</tr>
</table>
</div>


Custom filters are defined using an XML format.
These XML files can be either hand rolled, or generated
by the <a class="underline" href="https://marginalia-search.com/filters">filter editor</a>.

### XML example

```xml
<?xml version="1.0"?>
<filter>
    <domains-include>
        www.google.com
        *.youtube.com
    </domains-include>

    <domains-exclude>
        www.yandex.ru
    </domains-exclude>

    <domains-promote amount="-1.0">
        www.bing.com
        www.yahoo.com
    </domains-promote>

    <!-- Adjust ranking of these terms -->
    <domains-promote amount="1.0">
        www.mojeek.com
    </domains-promote>

    <temporal-bias>OLD</temporal-bias> <!-- or RECENT, or NONE -->

    <terms-require>
        foo
        bar
    </terms-require>

    <terms-exclude>
        baz
    </terms-exclude>

    <!-- Adjust ranking of these terms -->
    <terms-promote amount="5.0">
        quux
    </terms-promote>

    <!-- estimated publication year (janky) -->
    <limit param="year" type="lt" value="1996" />
    <!-- a measure of how much javascript is on the page, 
         legacy marginalia search ranking metric -->
    <limit param="quality" type="eq" value="5" />
    <!-- how many documents are on the domain -->
    <limit param="size" type="gt" value="100" />
    <!-- pagerank, 0-255 -->
    <limit param="rank" type="gt" value="20" />
</filter>
```


## Old API (DEPRECATED)

A deprecated API for the search engine is available through <span class="text-red-900 dark:text-red-100">`api.marginalia.nu`</span>, or <span class="text-red-900 dark:text-red-100">`api.marginalia-search.com`</span>.  Both endpoints are equivalent and will work as long as the project does, though will not receive new functionality.

The API is simple enough to be self-explanatory. Examples:

<div class="overflow-auto text-xs text-gray-700 dark:text-gray-200 p-2">

```
https://api.marginalia.nu/public/
https://api.marginalia.nu/public/search/json+api
https://api.marginalia.nu/public/search/json+api?count=10
```

</div>

For experimentation, the key "public" is available, as used in the examples on this page. This key has a shared rate limit across all consumers. When this rate limit is hit a HTTP status 503 is returned. 


### Query Parameters (DEPRECATED)

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
<tr>
<td>page</td><td>int</td><td>Select results page (1-indexed)</td>
</tr>
<tr> <td class="align-top">nsfw</td><td>0</td><td>no filter</tr></tr>
<tr> <td class="align-top">nsfw</td><td>1</td><td>(experimental) reduce extreme results</tr></tr>
<tr>
<td>index</td><td>int</td><td>deprecated</td>
</tr>
</table>

</div>

# Sample code in python 3 (DEPRECATED)
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
