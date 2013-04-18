Description
---

A sample app using the ordnancesurvey-ios-sdk displaying different tile sources. One view uses standard WMTS source while another can combine this alongside an OSTiles package.

This project includes a small sample OSTiles package containing OV0, OV1 and OV2 products to demonstrate the offline capabilities and potential of the ordnancesurvey-ios-sdk.



![ScreenShot](https://github.com/OrdnanceSurvey/ios-sdk-demo-tilesources/raw/master/screenshot.png "Screenshot of demo app")


Getting started
---


#### Register for an API Key

Developers who wish to use the WMTS services will need to register an App Name in order to authenticate the API key in the following format:

APPLE_ID.BUNDLE_ID e.g. 12345678.com.example.find-a-postbox 

Apple App ID: This is a numerical value that is unique for each iOS app and has to be created in Apple's iOS Provisioning portal.
Bundle Identifier: This is the reverse domain name specified in Xcode, this is generated from the app name (how you name your project) and the company identifier specified. 

#### Registration Process

If you do not own a re-use data licence you can register for an API key to access [OS OpenSpace Pro] (https://www.ordnancesurvey.co.uk/oswebsite/web-services/os-openspace/pro/index.html) under a 90 day trial or a commercial re-use licence. 

If you own a data licence, for example, you are a member of the PSMA, you can register for an API key to access [OSOnDemand WMTS] (http://www.ordnancesurvey.co.uk/oswebsite/web-services/os-ondemand/pricing.html).

#### Download project

Copy the project to your local machine, eg:

<pre>
git clone https://github.com/OrdnanceSurvey/ios-sdk-demo-tilesources.git
</pre>

#### Download ordnancesurvey-ios-sdk

- Download the latest ordnancesurvey-ios-sdk framework from [www.ordnancesurvey.co.uk](https://www.ordnancesurvey.co.uk/oswebsite/web-services/os-openspace/pro/ios-sdk.html)
- Unzip the SDK into the `StaticFrameworks` directory at the root of the project

<pre>
$SRCROOT/StaticFrameworks
</pre>
 

#### Update demo app with your API Key and Bundle Identifier details

Copy and paste the API Key into the demo app

Update the Bundle Identifier associated with the API Key

<pre>
//In Common.m

NSString *const kOSApiKey = @"YOUR_API_KEY";
const BOOL kOSIsPro = YES;

</pre>

#### Build and run

Project can now be built and run. 

The Web Map Source tab is displaying tiles from the OS OpenSpace service and the DB Tile Source tab is displaying limited products from the `sample.ostiles` package included.

The button in each view will toggle displaying the bounds of the `OV2` product from the respective tilesource.

#### Test offline

You can test that DB Tile Source tab still functions correctly by disabling any phone data connections and panning around the map.

#### Combining tilesources

The `OSMapView` component consults tilesources in the order in which they appear in the array when passed to `OSMapView`, this allows you to add local tilesource as first choice, falling back to a web tilesource if no match for the product or tile in the local package.

There is a switch in `DBSourceViewController.m` to toggle this behaviour; find the line below to disable (set to 0) or enable (set to 1) the web map source.

<pre>
#if 0 //enable-disable the web map source
</pre>


Questions and Issues
-------

If you have any questions or issues with the ordnancesurvey-ios-sdk or this demo app then please email osopenspacepro@ordnancesurvey.co.uk

Licence
-------

The Ordnance Survey iOS SDK is protected by © Crown copyright – Ordnance
Survey 2013. It is subject to licensing terms granted by Ordnance Survey, the
national mapping agency of Great Britain.

The Ordnance Survey iOS SDK includes the Route-Me library. The Route-Me
library is copyright (c) 2008-2013, Route-Me Contributors All rights reserved
(subject to the BSD licence terms as follows):

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer. * Redistributions in binary
  form must reproduce the above copyright notice, this list of conditions and
  the following disclaimer in the documentation and/or other materials provided
  with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Route-Me depends on the Proj4 Library. [ http://trac.osgeo.org/proj/wiki/WikiStart ]
Proj4 is copyright (c) 2000, Frank
Warmerdam / Gerald Evenden Proj4 is subject to the MIT licence as follows:

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
