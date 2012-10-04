//
//  ViewController.m
//  OSTileSourceDemo
//
//  Created by rmurray on 04/10/2012.
//  Copyright (c) 2012 OrdnanceSurvey. All rights reserved.
//

#import "WebMapViewController.h"

#define kOS_API_KEY @"YOUR_KEY_HERE"
#define kOS_URL @"YOUR_URL_HERE"
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
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    _mapView = nil;
}

@end
