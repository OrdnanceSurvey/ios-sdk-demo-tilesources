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


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _showingPackageBounds = NO;
    
    {
        //create web tile source with API details
        id<OSTileSource> webSource = [OSMapView webTileSourceWithAPIKey:kOSApiKey openSpacePro:kOSIsPro];
        _mapView.tileSources = [NSArray arrayWithObjects:webSource, nil];
        
        [_mapView setDelegate: self];
        
        [_mapView setRegion: OSCoordinateRegionForGridRect(OSNationalGridBounds)];
        
        NSLog(@"Using SDK Version: %@",[OSMapView SDKVersion]);
        
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



#pragma mark OSMapviewdelegate methods

-(OSOverlayView *)mapView:(OSMapView *)mapView viewForOverlay:(id<OSOverlay>)overlay {
    
    /*
     * style OSPolygon view
     */
    if ( [overlay isKindOfClass:[OSPolygon class]] ) {
        
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
- (IBAction)toggleShowPackageBounds:(id)sender {
    
    static NSString * productCodeToDisplay = @"OV2";
    
    //toggle display of tile source package bounds
    if( _showingPackageBounds ) {
        
        [_mapView removeOverlays:_mapView.overlays];
        
    }else{
        
        [_mapView addOverlay: [super getBoundsForProductCode:productCodeToDisplay inTileSources:_mapView.tileSources]];
        
    }
    
    _showingPackageBounds = !_showingPackageBounds;
    
}

@end
