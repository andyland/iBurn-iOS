//
//  BRCMapViewController.m
//  iBurn
//
//  Created by David Chiles on 7/28/14.
//  Copyright (c) 2014 Burning Man Earth. All rights reserved.
//

#import "BRCMapViewController.h"
#import <Mapbox-iOS-SDK/Mapbox.h>

NSString *const bundledTileSourceName = @"iburn";

@interface BRCMapViewController ()

@property (nonatomic, strong) RMMapView *mapView;

@end

@implementation BRCMapViewController

- (instancetype) init {
    if (self = [super init]) {
        self.title = @"Map";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RMMBTilesSource *tileSource = [self bundledTileSource];
    self.mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:tileSource];
    self.mapView.adjustTilesForRetinaDisplay = YES;
    self.mapView.hideAttribution = YES;
    self.mapView.showLogoBug = NO;
    self.mapView.showsUserLocation = YES;
    
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.mapView];
    
    RMUserTrackingBarButtonItem *userTrackingBarButtonItem = [[RMUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    self.navigationItem.rightBarButtonItem = userTrackingBarButtonItem;
    
    [self zoomToFullTileSource:tileSource animated:NO];
}

- (void)zoomToFullTileSource:(RMMBTilesSource *)tileSource animated:(BOOL)animated
{
    RMSphericalTrapezium bounds = [tileSource latitudeLongitudeBoundingBox];
    [self.mapView zoomWithLatitudeLongitudeBoundsSouthWest:bounds.southWest northEast:bounds.northEast animated:animated];
}

- (RMMBTilesSource *)bundledTileSource
{
    return [[RMMBTilesSource alloc] initWithTileSetResource:bundledTileSourceName ofType:@"mbtiles"];
}

@end