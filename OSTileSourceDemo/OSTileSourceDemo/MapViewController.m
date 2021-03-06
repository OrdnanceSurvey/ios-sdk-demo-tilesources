//
//  MapViewController.m
//  OSTileSourceDemo
//
//  Created by rmurray on 16/04/2013.
//  Copyright (c) 2013 OrdnanceSurvey. All rights reserved.
//

#import "MapViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //add a button to view
    {
        UIButton *showPackageBoundsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        showPackageBoundsBtn.frame = CGRectMake(10, 30, 40, 40);
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

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark TileSouce bounds


/**
 * Return an Polygon for the product code in tilesources array
 */
-(OSPolygon *) getBoundsForProductCode:(NSString *)productCode inTileSources: (NSArray *)tileSources {
    
    //loop through tileSources
    for( id<OSTileSource> ts in tileSources ) {
        
        //Grab the bounding box displayed by this tileSource
        OSGridRect gr = [ts boundsForProductCode: productCode];
        
        //assert if a valid OSGridRect
        if( !OSGridRectEqualToRect(gr, OSGridRectNull) ) {
            
            NSLog(@"Tilesource bounds for product code %@ : %.0f,%.0f,%.0f,%.0f", productCode, gr.originSW.easting,gr.originSW.northing, gr.originSW.easting+gr.size.width, gr.originSW.northing+gr.size.height);
            
            return [self getPolygonForGridRect:gr];
        }
        
    }
    
    return nil;
    
}

/*
 * Generic method to generate an OSPolygon overlay for the OSGridRect passed
 */
-(OSPolygon *)getPolygonForGridRect: (OSGridRect)gr {
    
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
    
    return [OSPolygon polygonWithGridPoints:points count:4];
    
}


@end
