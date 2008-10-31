/*
 *  RMFoundation.h
 *  MapView
 *
 *  Created by David Bainbridge on 10/28/08.
 *
 */



#define RMLatLong					CLLocationCoordinate2D

typedef struct {
	double x, y;
} RMXYPoint;

typedef struct {
	double width, height;
} RMXYSize;

typedef struct {
	RMXYPoint origin;
	RMXYSize size;
} RMXYRect;

RMXYPoint RMScaleXYPointAboutPoint(RMXYPoint point, float factor, RMXYPoint pivot);
RMXYRect  RMScaleXYRectAboutPoint (RMXYRect rect,   float factor, RMXYPoint pivot);
RMXYPoint RMTranslateXYPointBy    (RMXYPoint point, RMXYSize delta);
RMXYRect  RMTranslateXYRectBy     (RMXYRect rect,   RMXYSize delta);

