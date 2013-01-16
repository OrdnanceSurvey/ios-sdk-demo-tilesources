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



@interface DBSourceViewController () <OSMapViewDelegate>

@end

@implementation DBSourceViewController
{
    BOOL showingPackageBounds;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    showingPackageBounds = NO;
    
    {
        NSMutableArray *tileSources = [NSMutableArray new];
        NSMutableArray *products = [NSMutableArray new];
        
        
        //load sample ostiles package bundled with project
        id<OSTileSource> sampleSource = [self sampleTilePackage];
        
        // Tile sources are consulted in the order they appear in the array.
        [tileSources addObject:sampleSource];
        
        //use reduced set of product codes
        [products addObjectsFromArray:[NSArray arrayWithObjects:@"OV0", @"OV1", @"OV2", nil]];
        
#if 0 //enable-disable the web map source
        
        //create web tile source with API details
        id<OSTileSource> webSource = [OSMapView webTileSourceWithAPIKey:kOSApiKey refererUrl:kOSApiKeyUrl openSpacePro:kOSIsPro];
        
        [tileSources addObject:webSource];
        
        //add more products
        [products addObjectsFromArray:[NSArray arrayWithObjects:@"MSR", @"MS", @"250KR", @"250K", @"50KR", @"50K", nil]];
        
#endif
        
        _mapView.tileSources = [NSArray arrayWithArray:tileSources];
        _mapView.mapProductCodes = [NSArray arrayWithArray:products];
        
        _mapView.delegate = self;
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        NSLog(@"Using SDK Version: %@",[OSMapView SDKVersion]);
        
    }
    
    
    //add a button to view
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
    
}



/*
 * return a sample tilesource package
 * Product codes: @"OV0", @"OV1", @"OV2"
 * Bounds: 0,0,700000,1300000
 */
- (id<OSTileSource>)sampleTilePackage
{
    return [OSMapView localTileSourceWithFileURL:[[NSBundle mainBundle] URLForResource:@"sample.ostiles" withExtension:nil]];
}



#pragma mark IBAction methods


/*
 * Handle button tap to toggle display of the ostiles packages 
 */
- (IBAction)toggleShowPackageBounds:(id)sender
{
    
    static NSString * productCodeToDisplay = @"OV2";

    
    //toggle display of tile source package bounds
    if( showingPackageBounds ){
        
        [_mapView removeOverlays:_mapView.overlays];
        
    }else{
        
        //loop through tileSources
        for(id<OSTileSource> ts in _mapView.tileSources)
        {
            //proceed if tilesource is local - not web source
            if([ts isLocal])
            {
                OSGridRect gr = [ts boundsForProductCode: productCodeToDisplay];
                
                //assert if a valid OSGridRect
                if( !OSGridRectEqualToRect(gr, OSGridRectNull) )
                {
                    [self plotTileBoundsForGridRect: gr];
                    
                    NSLog(@"Tilesource bounds for prodcode %@ : %.0f,%.0f,%.0f,%.0f",productCodeToDisplay, gr.originSW.easting,gr.originSW.northing, gr.originSW.easting+gr.size.width, gr.originSW.northing+gr.size.height);
                }

                
            }
            
        }
        
    }

    showingPackageBounds = !showingPackageBounds;
    
}


/*
 * Generic method to add a OSPolygon overlay for the OSGridRect passed
 */
-(void)plotTileBoundsForGridRect: (OSGridRect)gr
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
         * style OSPolygon view
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
