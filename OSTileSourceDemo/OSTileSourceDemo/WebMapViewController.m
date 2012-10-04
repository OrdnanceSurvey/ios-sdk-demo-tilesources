//
//  ViewController.m
//  OSTileSourceDemo
//
//  Created by rmurray on 04/10/2012.
//  Copyright (c) 2012 OrdnanceSurvey. All rights reserved.
//

#import "WebMapViewController.h"

#define kOS_API_KEY @"BA08531D8339984EE0405F0AC86026A9"
#define kOS_URL @"http://openspacejseditor.ordnancesurvey.co.uk/viewer/"
#define kIS_PRO FALSE

@interface WebMapViewController () <OSMapViewDelegate>

@end

@implementation WebMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    {
        //create web tile source with API details
        id<OSTileSource> webSource = [OSMapView webTileSourceWithAPIKey:kOS_API_KEY refererUrl:kOS_URL openSpacePro:kIS_PRO];
        _mapView.tileSources = [NSArray arrayWithObjects:webSource, nil];
        
        _mapView.delegate = self;
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        OSGridPoint mapCenter = (OSGridPoint){437293,115505};
        
        [_mapView setRegion:OSCoordinateRegionMakeWithDistance(OSCoordinateForGridPoint(mapCenter), 2000, 2000)];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    _mapView = nil;
}

@end
