//
//  RMImageAnnotation.h
//  MapView
//
//  Created by Michael Gledhill on 5/6/13.
//  www.MikesKnowledgeBase.com
//

#import "RMShapeAnnotation.h"

@interface RMImageAnnotation : RMShapeAnnotation

- (id)initWithMapView:(RMMapView *)aMapView topLeft:(CLLocationCoordinate2D)topLeft bottomRight:(CLLocationCoordinate2D)bottomRight image:(UIImage*)image;

-(void)changeOpacity:(float)opacity bAnimated:(bool)bAnimated;

@property (nonatomic, strong) UIImage *image;

@end
