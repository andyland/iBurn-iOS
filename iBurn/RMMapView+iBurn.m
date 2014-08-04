//
//  RMMapView+iBurn.m
//  iBurn
//
//  Created by Christopher Ballinger on 7/30/14.
//  Copyright (c) 2014 Burning Man Earth. All rights reserved.
//

#import "RMMapView+iBurn.h"
#import "RMMBTilesSource.h"

@implementation RMMapView (iBurn)


static NSString *const kBRCBundledTileSourceName = @"iburn";

- (void)brc_zoomToFullTileSourceAnimated:(BOOL)animated
{
    RMSphericalTrapezium bounds = [self.tileSource latitudeLongitudeBoundingBox];
    [self zoomWithLatitudeLongitudeBoundsSouthWest:bounds.southWest northEast:bounds.northEast animated:animated];
}

- (void)brc_zoomToIncludeCoordinate:(CLLocationCoordinate2D)coordinate1 andCoordinate:(CLLocationCoordinate2D)coordinate2 animated:(BOOL)animated
{
    BOOL coordinate1InBounds = [[self class] isCoordinate:coordinate1 inBounds:[self.tileSource latitudeLongitudeBoundingBox]];
    BOOL coordinate2InBounds = [[self class] isCoordinate:coordinate2 inBounds:[self.tileSource latitudeLongitudeBoundingBox]];
    
    if (coordinate1InBounds && coordinate2InBounds) {
        CLLocationDegrees minLatitude = MIN(coordinate1.latitude, coordinate2.latitude);
        CLLocationDegrees maxLatitude = MAX(coordinate1.latitude, coordinate2.longitude);
        CLLocationDegrees minLongitude = MIN(coordinate1.longitude, coordinate2.longitude);
        CLLocationDegrees maxLongitude = MAX(coordinate1.longitude, coordinate2.longitude);
        
        CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(minLatitude, minLongitude);
        CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(maxLatitude, maxLongitude);
        
        [self zoomWithLatitudeLongitudeBoundsSouthWest:southWest northEast:northEast animated:animated];
        [self zoomOutToNextNativeZoomAt:self.center animated:animated];
    }
    else if (coordinate1InBounds)
    {
        [self setCenterCoordinate:coordinate1 animated:animated];
    }
    else if (coordinate2InBounds)
    {
        [self setCenterCoordinate:coordinate2 animated:animated];
    }
    
}

+ (BOOL)isCoordinate:(CLLocationCoordinate2D)coordinate inBounds:(RMSphericalTrapezium)bounds
{
    if (coordinate.longitude >= bounds.southWest.longitude && coordinate.longitude <= bounds.northEast.longitude && coordinate.latitude >= bounds.southWest.latitude && coordinate.latitude <= bounds.northEast.latitude) {
        return YES;
    }
    return NO;
}


+ (RMMBTilesSource *)brc_defaultTileSource
{
    return [[RMMBTilesSource alloc] initWithTileSetResource:kBRCBundledTileSourceName ofType:@"mbtiles"];
}

+ (instancetype)brc_defaultMapViewWithFrame:(CGRect)frame
{
    RMMapView *mapView = [[RMMapView alloc] initWithFrame:frame andTilesource:[self brc_defaultTileSource]];
    mapView.hideAttribution = YES;
    mapView.showLogoBug = NO;
    mapView.showsUserLocation = YES;
    mapView.minZoom = 13;
    mapView.backgroundColor = [UIColor colorWithRed:232/255.0f green:224/255.0f blue:216/255.0f alpha:1.0f];
    //mapView.clusteringEnabled = YES;
    
    return mapView;
    
}

@end