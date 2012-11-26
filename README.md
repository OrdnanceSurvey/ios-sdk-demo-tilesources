Description
---

A sample app using the iOS Openspace SDK displaying different tile sources. One view uses standard OS OpenSpace web source while another combines this alongside an OSTiles package.

This includes a small sample OSTiles package containing 50K, 50KR, 250K and 250KR products to demonstrate the offline capabilities and potential of the iOS Openspace SDK.



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

 - Download the latest ordnancesurvey-ios-sdk static framework from [https://github.com/OrdnanceSurvey/ordnancesurvey-ios-sdk/downloads](https://github.com/OrdnanceSurvey/ordnancesurvey-ios-sdk/downloads) 
 - Unzip into the project directory root
 <pre>
 $SRCROOT/StaticFrameworks
 </pre>
 

#### Update demo app with your API Key

Copy and paste the API Key and associated URL into the demo app

Note: if an OS OpenSpace Pro account then change kIS_PRO to TRUE

<pre>
//In WebMapViewController.m and DBSourceViewController.m

#define kOS_API_KEY @"YOUR_KEY_HERE"
#define kOS_URL @"YOUR_URL_HERE"
#define kIS_PRO FALSE

</pre>

#### Build and run

Project can now be built and run. The button in on the DB Tile Source tab view will toggle displaying the bounds of the 50K product.

#### Test offline

You can test the app still renders the sample.ostiles package by disabling network connection or alter the line in DBSourceViewController.m below to disable (0) web map source

<pre>
#if 1 //enable-disable the web map source
</pre>


License
-------

Some notes about license & use TODO