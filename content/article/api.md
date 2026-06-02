+++
title = "API"
date = 2025-12-08
section = "marginalia-search"
aliases = ["/projects/edge/api.gmi"]
draft = false
categories = ["docs"]
+++

## New API

The updated API is available through <span class="text-red-900 dark:text-red-100">`api2.marginalia-search.com`</span>.

Pass the API key in the `API-Key` header on every request.  If you want to develop an integration but do not yet have a key, you can use the key `public`.  Note that this key cannot create custom filters, and often hits a rate limit.

### Obtaining a key

<div class="grid grid-cols-1 sm:grid-cols-3 gap-2 mx-0 sm:mx-2 my-2">
    <div class="border rounded p-3 dark:border-gray-400 flex flex-col space-y-2">
        <h4 class="text-sm font-bold text-margeblue dark:text-slate-200">Free non-commercial</h4>
        <p class="grow">Email <a class="underline text-liteblue dark:text-blue-200" href="mailto:contact@marginalia-search.com">contact@marginalia-search.com</a>.  The email step is necessary to prevent mass signup abuse.</p>
        <p class="text-xs text-gray-600 dark:text-gray-400">Provided under <a class="underline text-liteblue dark:text-blue-200" href="https://creativecommons.org/licenses/by-nc-sa/4.0/">CC-BY-NC-SA 4.0</a>.</p>
    </div>
    <div class="border rounded p-3 dark:border-gray-400 flex flex-col space-y-2">
        <h4 class="text-sm font-bold text-margeblue dark:text-slate-200">Paid non-commercial</h4>
        <p class="grow"><a class="underline text-liteblue dark:text-blue-200" href="https://buy.polar.sh/polar_cl_B7026PKyFKrH5f0F1O6tcN6foD0ivufh1wX6l4fUeVV">Buy a non-commercial key</a> to skip the line and support the search engine with a one-time payment.  Optional, and will always remain optional.</p>
        <p class="text-xs text-gray-600 dark:text-gray-400">Provided under <a class="underline text-liteblue dark:text-blue-200" href="https://creativecommons.org/licenses/by-nc-sa/4.0/">CC-BY-NC-SA 4.0</a>.</p>
    </div>
    <div class="border rounded p-3 dark:border-gray-400 flex flex-col space-y-2">
        <h4 class="text-sm font-bold text-margeblue dark:text-slate-200">Commercial</h4>
        <p class="grow"><a class="underline text-liteblue dark:text-blue-200" href="https://buy.polar.sh/polar_cl_hKnbSGWkflTozpXajwIu2ycB2fYmLM8jDxsuh06Kvmt">Buy a metered commercial key</a> with no commercial usage restriction or attribution requirement.</p> 
        <p class="text-xs text-gray-600 dark:text-gray-400">Manage your subscription at <a class="underline text-liteblue dark:text-blue-200" href="https://polar.sh/marginalia-search/portal">polar.sh/marginalia-search/portal</a>.</p>
    </div>
</div>

Other terms are negotiable, email <a class="underline text-liteblue dark:text-blue-200" href="mailto:contact@marginalia-search.com">contact@marginalia-search.com</a>.

### Getting started

A test request using the `public` key:

<div class="overflow-auto text-xs text-gray-700 dark:text-gray-200 p-2">

```bash
$ curl -H"API-Key: ${API_KEY}" -XGET https://api2.marginalia-search.com/search?query=json+api
```

</div>

The following query parameters are understood.

<div class="border rounded p-2 m-1 dark:text-slate-300 text-slate-800">
<table>
<tr>
<td class="font-bold">Param</td>
<td class="font-bold">Value</td>
<td class="font-bold">Description</td>
</tr>
<tr><td>count</td><td>1-100</td><td>Number of results</td></tr>
<tr><td>timeout</td><td>50-250</td><td>Query execution timeout (ms)</td></tr>
<tr><td>dc</td><td>1-100</td><td>Max number of results per domain</td></tr>
<tr><td>page</td><td>int</td><td>Select results page (1-indexed)</td></tr>
<tr><td>nsfw</td><td>0</td><td>No filter</td></tr>
<tr><td>nsfw</td><td>1</td><td>(experimental) reduce extreme results</td></tr>
<tr><td>filter</td><td>string</td><td>Use custom filter</td></tr>
</table>
</div>

### Sample code in Python 3

<div class="overflow-auto text-xs text-gray-700 dark:text-gray-200 p-2">

```python
import requests

url = "https://api2.marginalia-search.com/search?query={query}"

rsp = requests.get(url.format(query="linear b"), headers={'API-Key': 'public'})

if rsp.ok:
    data = rsp.json()
    print("Query: ", data['query'])
    print("License: ", data['license'])
    print("")
    for result in data['results']:
        print(result['url'])
        print("\t" + result['title'])
        print("\t" + result['description'])
        print("")
else:
    print("Bad Status " + str(rsp.status_code))
```

</div>

### Filters

You can set up custom filters for your API key.  This is not allowed on the `public` key.

<div class="border rounded p-2 m-1 dark:text-slate-300 text-slate-800">
<table>
<tr>
<td class="font-bold">Method</td>
<td class="font-bold">Endpoint</td>
<td class="font-bold">Description</td>
</tr>
<tr><td>GET</td><td class="font-mono px-1">/filter</td><td>List configured filters</td></tr>
<tr><td>POST</td><td class="font-mono px-1">/filter/NAME</td><td>Create a new filter NAME</td></tr>
<tr><td>GET</td><td class="font-mono px-1">/filter/NAME</td><td>Retrieve filter definition for NAME</td></tr>
<tr><td>DELETE</td><td class="font-mono px-1">/filter/NAME</td><td>Delete custom filter NAME</td></tr>
</table>
</div>

Custom filters are defined in XML.  These can be hand rolled, or generated by the <a class="underline text-liteblue dark:text-blue-200" href="https://marginalia-search.com/filters">filter editor</a>.

### XML example

<div class="overflow-auto text-xs text-gray-700 dark:text-gray-200 p-2">

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

</div>

## Old API (deprecated)

The deprecated API is available through <span class="text-red-900 dark:text-red-100">`api.marginalia.nu`</span> or <span class="text-red-900 dark:text-red-100">`api.marginalia-search.com`</span>.  Both endpoints are equivalent and will work as long as the project does, but will not receive new functionality.

Examples:

<div class="overflow-auto text-xs text-gray-700 dark:text-gray-200 p-2">

```
https://api.marginalia.nu/public/
https://api.marginalia.nu/public/search/json+api
https://api.marginalia.nu/public/search/json+api?count=10
```

</div>

The key `public` is available for experimentation, as used in the examples above.  This key has a shared rate limit across all consumers; when the limit is hit, HTTP 503 is returned.

### Query parameters (deprecated)

<div class="border rounded p-2 m-1 dark:text-slate-300 text-slate-800">
<table>
<tr>
<td class="font-bold">Param</td>
<td class="font-bold">Value</td>
<td class="font-bold">Description</td>
</tr>
<tr><td>count</td><td>int</td><td>Number of results</td></tr>
<tr><td>dc</td><td>int</td><td>Max number of results per domain</td></tr>
<tr><td>page</td><td>int</td><td>Select results page (1-indexed)</td></tr>
<tr><td>nsfw</td><td>0</td><td>No filter</td></tr>
<tr><td>nsfw</td><td>1</td><td>(experimental) reduce extreme results</td></tr>
<tr><td>index</td><td>int</td><td>deprecated</td></tr>
</table>
</div>

### Sample code in Python 3 (deprecated)

<div class="overflow-auto text-xs text-gray-700 dark:text-gray-200 p-2">

```python
import requests

url = "https://api.marginalia.nu/{key}/search/{query}"

rsp = requests.get(url.format(key='public', query="linear b"))

if rsp.ok:
    data = rsp.json()
    print("Query: ", data['query'])
    print("License: ", data['license'])
    print("")
    for result in data['results']:
        print(result['url'])
        print("\t" + result['title'])
        print("\t" + result['description'])
        print("")
else:
    print("Bad Status " + str(rsp.status_code))
```

</div>

## Something missing?

Let me know if there are features you would like added to the API.

## See also

* [Data sets from the search engine](https://downloads.marginalia.nu/)
