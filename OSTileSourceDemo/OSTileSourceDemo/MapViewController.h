//
//  MapViewController.h
//  OSTileSourceDemo
//
//  Created by rmurray on 16/04/2013.
//  Copyright (c) 2013 OrdnanceSurvey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OSMap/OSMap.h>

@protocol DisplaysProductBounds

- (IBAction)toggleShowPackageBounds:(id)sender;

@property (nonatomic, assign) BOOL showingPackageBounds;

@end

@interface MapViewController : UIViewController

-(OSPolygon *)getPolygonForGridRect:(OSGridRect)gr;

-(OSPolygon *) getBoundsForProductCode:(NSString *)productCode inTileSources: (NSArray *)tileSources;

@end
