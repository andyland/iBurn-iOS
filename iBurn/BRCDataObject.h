//
//  BRCDataObject.h
//  iBurn
//
//  Created by Christopher Ballinger on 7/28/14.
//  Copyright (c) 2014 Burning Man Earth. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import <CoreLocation/CoreLocation.h>

@interface BRCDataObject : MTLModel <MTLJSONSerializing>

#pragma mark Mutable Properties

/**
 *  Whether or not user has favorited this object in the app.
 */
@property (nonatomic, readwrite) BOOL isFavorite;

/**
 *  This property is periodically recalculated in the background on significant location change.
 */
@property (nonatomic, readwrite) CLLocationDistance distanceFromUser;


#pragma mark Constant Properties

/**
 *  All of the below properties are from the PlayaEvents API
 */

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *detailDescription;
@property (nonatomic, strong, readonly) NSString *email;
@property (nonatomic, strong, readonly) NSURL *url;

/**
 *  Real GPS coordinate
 */
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


/**
 *  Unique 'id' from PlayaEvents API
 */
@property (nonatomic, strong, readonly) NSString *uniqueID;

/**
 *  Year of data's origin e.g. "2014"
 */
@property (nonatomic, strong, readonly) NSString *year;

/**
 *  Playa Coordinates
 */
@property (nonatomic, strong, readonly) NSNumber *playaHour;
@property (nonatomic, strong, readonly) NSNumber *playaMinute;
@property (nonatomic, strong, readonly) NSString *playaStreet;

/**
 *  The YapDatabase collection of this class
 *
 *  @return collection for this class
 */
+ (NSString*) collection;

@end
