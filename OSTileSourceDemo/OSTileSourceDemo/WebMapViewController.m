//
//  ViewController.m
//  OSTileSourceDemo
//
//  Created by rmurray on 04/10/2012.
//  Copyright (c) 2012 OrdnanceSurvey. All rights reserved.
//

#import "WebMapViewController.h"


@interface WebMapViewController () <OSMapViewDelegate>

@end

@implementation WebMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    {
        //create web tile source with API details
        id<OSTileSource> webSource = [OSMapView webTileSourceWithAPIKey:kOSApiKey refererUrl:kOSApiKeyUrl openSpacePro:kOSIsPro];
        _mapView.tileSources = [NSArray arrayWithObjects:webSource, nil];
        
        _mapView.delegate = self;
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        NSLog(@"Using SDK Version: %@",[OSMapView SDKVersion]);
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
