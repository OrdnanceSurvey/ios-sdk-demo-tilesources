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
    
    _showingPackageBounds = NO;
    
    {
        //create web tile source with API details
        id<OSTileSource> webSource = [OSMapView webTileSourceWithAPIKey:kOSApiKey appleId:kOSAppleAppId openSpacePro:kOSIsPro];
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



#pragma mark OSMapviewdelegate methods

-(OSOverlayView *)mapView:(OSMapView *)mapView viewForOverlay:(id<OSOverlay>)overlay
{
    if ( [overlay isKindOfClass:[OSPolygon class]] )
    {
        /*
         * style OSPolygon view
         */
        OSPolygonView * view = [[OSPolygonView alloc] initWithPolygon:(id)overlay];
        view.lineWidth = 1;
        view.strokeColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
        view.fillColor = [UIColor colorWithRed:50.0f/255.0f green:205.0f/255.0f blue:50.0f/255.0f alpha:0.35f];
        return view;
        
    }
    return nil;
}


#pragma mark DisplaysProductBounds methods


/*
 * Handle button tap to toggle display of the ostiles packages
 */
- (IBAction)toggleShowPackageBounds:(id)sender
{
    
    static NSString * productCodeToDisplay = @"OV2";
    
    //toggle display of tile source package bounds
    if( _showingPackageBounds ){
        
        [_mapView removeOverlays:_mapView.overlays];
        
    }else{
        
        //Grab the one tileSource
        id<OSTileSource> ts = [[_mapView tileSources] lastObject];
        
        //Grab the bounding box displayed by this tileSource
        OSGridRect gr = [ts boundsForProductCode: productCodeToDisplay];
            
        //assert if a valid OSGridRect
        if( !OSGridRectEqualToRect(gr, OSGridRectNull) )
        {
            [_mapView addOverlay: [super getPolygonForGridRect:gr]];
                
            NSLog(@"Tilesource bounds for prodcode %@ : %.0f,%.0f,%.0f,%.0f",productCodeToDisplay, gr.originSW.easting,gr.originSW.northing, gr.originSW.easting+gr.size.width, gr.originSW.northing+gr.size.height);
        }
            
        
    }
    
    _showingPackageBounds = !_showingPackageBounds;
    
}

@end
