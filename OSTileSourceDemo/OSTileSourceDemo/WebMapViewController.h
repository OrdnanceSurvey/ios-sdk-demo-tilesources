//
//  ViewController.h
//  OSTileSourceDemo
//
//  Created by rmurray on 04/10/2012.
//  Copyright (c) 2012 OrdnanceSurvey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface WebMapViewController : MapViewController <DisplaysProductBounds>

@property (weak, nonatomic) IBOutlet OSMapView *mapView;

@property (nonatomic, assign) BOOL showingPackageBounds;

@end
