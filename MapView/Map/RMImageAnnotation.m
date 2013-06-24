//
//  RMImageAnnotation.m
//  MapView
//
//  Created by Michael Gledhill on 5/6/13.
//  www.MikesKnowledgeBase.com
//

#import "RMImageAnnotation.h"
#import "RMShape.h"

@implementation RMImageAnnotation
@synthesize image = _image;

- (id)initWithMapView:(RMMapView *)aMapView topLeft:(CLLocationCoordinate2D)topLeft bottomRight:(CLLocationCoordinate2D)bottomRight image:(UIImage*)image;
{
    //  Convert our top-left & bottom-right coordinates into the locations of the
    //  four corners of our UIImage's location rectangle.
    //
    CLLocation *point1 = [[CLLocation alloc] initWithLatitude:topLeft.latitude longitude:topLeft.longitude];
    CLLocation *point2 = [[CLLocation alloc] initWithLatitude:topLeft.latitude longitude:bottomRight.longitude];
    CLLocation *point3 = [[CLLocation alloc] initWithLatitude:bottomRight.latitude longitude:bottomRight.longitude];
    CLLocation *point4 = [[CLLocation alloc] initWithLatitude:bottomRight.latitude longitude:topLeft.longitude];
    
    NSArray *points = [[NSArray alloc] initWithObjects:point1, point2, point3, point4, nil];

    //  Create the RMShapeAnnotation instance, containing our rectangle area
    if (!(self = [super initWithMapView:aMapView points:points]))
        return nil;
    
    self.title = @"";
    
    //  Make a copy of the image which we want to display on the map
    self.image = [image copy];
    
    //  Set the image property of our underlying "RMShapeAnnotation" class (and it's "RMAnnotation"
    //  class) to make sure the CALayer displays our image as it's background
    [super setImage:self.image];
    return self;
}

-(void)changeOpacity:(float)opacity 
{
    if (opacity == 0)
    {
        self.layer.opacity = opacity;
        return;
    }
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.duration = 0.3;
    fadeAnimation.fromValue =  [NSNumber numberWithFloat:self.layer.opacity];
    fadeAnimation.toValue =  [NSNumber numberWithFloat:opacity];
    fadeAnimation.fillMode = kCAFillModeForwards;
    fadeAnimation.removedOnCompletion = NO;
    self.layer.opacity = opacity;
    [self.layer addAnimation:fadeAnimation forKey:@"opacity"];

}

- (RMMapLayer *)layer
{
    //  This function "displays" an invisible rectangle on our map, and when the RMAnnotation
    //  comes to display it, it'll see that there's an UIImage associated with this annotation,
    //  and display our image in this rect.
    //
    //  The "setLayer" function in RMAnnotation.m does the actual drawing on the screen.
    //
    if ( ! [super layer])
    {     
        RMShape *shape = [[RMShape alloc] initWithView:self.mapView];
        
        [shape performBatchOperations:^(RMShape *aShape)
         {
             //  We'll actually "draw" a hidden rectangle, showing where our
             //  image will be pasted.  (Useful for debugging.)
             [aShape moveToCoordinate:self.coordinate];
             
             for (CLLocation *point in self.points)
                 [aShape addLineToCoordinate:point.coordinate];
             
             [aShape closePath];
             
             aShape.fillColor = [UIColor clearColor];
             aShape.lineWidth = 0;
         }];
                
        super.layer = shape;
    }
    return [super layer]; 
} 

@end
