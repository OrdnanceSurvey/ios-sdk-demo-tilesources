Description
---

A sample app using the iOS Openspace SDK displaying different tile sources. One view uses standard OS OpenSpace web source while another can combine this alongside an OSTiles package.

This project includes a small sample OSTiles package containing OV0, OV1 and OV2 products to demonstrate the offline capabilities and potential of the iOS Openspace SDK.



![ScreenShot](https://github.com/OrdnanceSurvey/ios-sdk-demo-tilesources/raw/master/screenshot.png "Screenshot of demo app")


Getting started
---


#### Register for an OS OpenSpace API Key

Developers will need to register and obtain an API Key for one of the [OS OpenSpace services](http://www.ordnancesurvey.co.uk/oswebsite/web-services/os-openspace/) in order to access the web mapping source.

#### Clone project

<pre>
git clone https://github.com/OrdnanceSurvey/ios-sdk-demo-tilesources.git
</pre>

#### Download ordnancesurvey-ios-sdk

 - Download the latest ordnancesurvey-ios-sdk static framework TBC 
 - Unzip into the project directory root
 <pre>
 $SRCROOT/StaticFrameworks
 </pre>
 

#### Update demo app with your API Key

Copy and paste the API Key and associated URL into the demo app

Note: if an OS OpenSpace Pro account then change kOSIsPro to YES

<pre>
//In Common.m

NSString *const kOSApiKey = @"YOUR_API_KEY";
NSString *const kOSApiKeyUrl = @"URL_HERE";
const BOOL kOSIsPro = YES;

</pre>

#### Build and run

Project can now be built and run. The button in on the DB Tile Source tab view will toggle displaying the bounds of the OV0 product from the DB tilesource.

#### Test offline

You can test the app still renders the sample.ostiles package by disabling network connection or alter the line in DBSourceViewController.m below to disable (set to 0) web map source - this removes any connection to OS Openspace

<pre>
#if 1 //enable-disable the web map source
</pre>

Questions and Issues
-------

If you have any questions or issues with the ordnancesurey-ios-sdk or this demo app then please TODO: url to o-s.co.uk openspace forum

License
-------

The Ordnance Survey iOS SDK is protected by © Crown copyright – Ordnance
Survey 2012. It is subject to licensing terms granted by Ordnance Survey, the
national mapping agency of Great Britain.

The Ordnance Survey iOS SDK includes the Route-Me library. The Route-Me
library is copyright (c) 2008-2012, Route-Me Contributors All rights reserved
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
