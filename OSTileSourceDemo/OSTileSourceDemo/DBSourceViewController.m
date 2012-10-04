//
//  DBSourceViewController.m
//  OSTileSourceDemo
//
//  Created by rmurray on 04/10/2012.
//  Copyright (c) 2012 OrdnanceSurvey. All rights reserved.
//

#import "DBSourceViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "OSMAP/OSTileSource.h"


#define kOS_API_KEY @"BA08531D8339984EE0405F0AC86026A9"
#define kOS_URL @"http://openspacejseditor.ordnancesurvey.co.uk/viewer/"
#define kIS_PRO FALSE

@interface DBSourceViewController () <OSMapViewDelegate>

@end

@implementation DBSourceViewController
{
    BOOL showingPackageBounds;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    showingPackageBounds = NO;
    
    {
        //load sample ostiles package bundled with project
        id<OSTileSource> sampleSource = [OSMapView localTileSourceWithFileURL:[[NSBundle mainBundle] URLForResource:@"sample.ostiles" withExtension:nil]];
        
        // Tile sources are consulted in the order they appear in the array.
        NSMutableArray * tileSources = [NSMutableArray arrayWithObject:sampleSource];
        
#if 1 //enable-disable the web map source
        
        //create web tile source with API details
        id<OSTileSource> webSource = [OSMapView webTileSourceWithAPIKey:kOS_API_KEY refererUrl:kOS_URL openSpacePro:kIS_PRO];
        
        [tileSources addObject:webSource];
        
#endif
        _mapView.tileSources = tileSources;
        
        //use reduced set of product codes
        _mapView.mapProductCodes = [NSArray arrayWithObjects:@"OV1", @"OV2", @"MSR", @"MS", @"250KR", @"250K", @"50KR", @"50K", nil];
        
        _mapView.delegate = self;
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
    }
    
    
    //add showPackageBoundsBtn button to view
    {
        UIButton *showPackageBoundsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        showPackageBoundsBtn.frame = CGRectMake(10, 10, 40, 40);
        showPackageBoundsBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        showPackageBoundsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [showPackageBoundsBtn setImage:[UIImage imageNamed:@"screen.png"] forState:UIControlStateNormal];
        
        [[showPackageBoundsBtn layer] setCornerRadius:8.0f];
        [[showPackageBoundsBtn layer] setMasksToBounds:YES];
        [[showPackageBoundsBtn layer] setBorderColor:[[UIColor grayColor] CGColor]];
        [[showPackageBoundsBtn layer] setBackgroundColor:[[UIColor grayColor] CGColor]];
        [[showPackageBoundsBtn layer] setOpacity:0.5f];
        [[showPackageBoundsBtn layer] setBorderWidth:3.0f];
        
        [showPackageBoundsBtn addTarget:self action:@selector(toggleShowPackageBounds:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:showPackageBoundsBtn];
        [self.view bringSubviewToFront:showPackageBoundsBtn];
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    _mapView = nil;
}


/*
 * Set map centre point to static location
 */
- (void)setMapCentre
{
    OSGridPoint mapCenter = (OSGridPoint){390000, 484000};
    
    [_mapView setRegion:OSCoordinateRegionMakeWithDistance(OSCoordinateForGridPoint(mapCenter), 50000, 50000)];
}


/*
 * Handle button tap to toggle display of the ostiles packages 
 */
- (IBAction)toggleShowPackageBounds:(id)sender
{
    //toggle display
    if( showingPackageBounds == NO ){
        
        //loop through tileSources
        for(id<OSTileSource> ts in _mapView.tileSources){
            
            //Get the bounds for just the 50K product
            OSGridRect gr = [ts boundsForProductCode:@"50K"];
            
            //Were not interested in the bounds of web-based maps, just the ostiles packages
            if( !OSGridRectEqualToRect(gr, OSNationalGridBounds) ){
                [self plotTileBoundsForGR:gr];
            }
            
        }
        
        [self setMapCentre];
        
    }else{
        
        [_mapView removeOverlays:_mapView.overlays];
        
    }
    
    showingPackageBounds = !showingPackageBounds;
    
}


/*
 * Generic method to add a OSPolygon overlay for an OSGridRect
 */
-(void)plotTileBoundsForGR: (OSGridRect)gr
{
    
    OSGridPoint se;
    se.easting = gr.originSW.easting + gr.size.width;
    se.northing = gr.originSW.northing;
    
    OSGridPoint nw;
    nw.easting = gr.originSW.easting;
    nw.northing = gr.originSW.northing + gr.size.height;
    
    OSGridPoint ne;
    ne.easting = gr.originSW.easting + gr.size.width;
    ne.northing = gr.originSW.northing + gr.size.height;
    
    OSGridPoint points[] = {{gr.originSW.easting,gr.originSW.northing},{se.easting,se.northing},{ne.easting,ne.northing},{nw.easting,nw.northing}};
    
    OSPolygon * box = [OSPolygon polygonWithGridPoints:points count:4];
    [_mapView addOverlay:box];
    
}


#pragma mark OSMapviewdelegate methods

-(OSOverlayView *)mapView:(OSMapView *)mapView viewForOverlay:(id<OSOverlay>)overlay
{
    if ([overlay isKindOfClass:[OSPolygon class]])
    {
        /*
         * style OSPolygon views
         */
        OSPolygonView * view = [[OSPolygonView alloc] initWithPolygon:(id)overlay];
        view.lineWidth = 1;
        view.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        view.fillColor = [UIColor colorWithRed:0.5f green:0.5f blue:1 alpha:0.5f];
        return view;
        
    }
    return nil;
}


@end
