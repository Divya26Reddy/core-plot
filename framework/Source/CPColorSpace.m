
#import "CPColorSpace.h"

@interface CPColorSpace ()

+(CGColorSpaceRef)createGenericRGBSpace;

-(void)setCGColorSpace:(CGColorSpaceRef)newSpace;

@end

/** @brief Wrapper around CGColorSpaceRef
 *  A wrapper class around CGColorSpaceRef
 *
 * @todo More documentation needed 
 **/

@implementation CPColorSpace

/** @property cgColorSpace. 
 @brief The CGColorSpace to wrap around **/
@synthesize cgColorSpace;


/** @brief Creates and returns a instance of CPColorSpace initialized with the standard RGB space
 * Creates and returns a instance of CPColorSpace initialized with the standard RGB space. 
 * For the iPhone this is CGColorSpaceCreateDeviceRGB(), for Mac OS X CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB).
 **/
+(CGColorSpaceRef)createGenericRGBSpace;
{
#if defined(TARGET_IPHONE_SIMULATOR) || defined(TARGET_OS_IPHONE)
	return CGColorSpaceCreateDeviceRGB();
#else
	return CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB); 
#endif
} 

// This caches a generic RGB colorspace for repeated use
/** @brief Returns a shared instance of CPColorSpace initialized with the standard RGB space
 * Creates and returns a instance of CPColorSpace initialized with the standard RGB space. 
 * For the iPhone this is CGColorSpaceCreateDeviceRGB(), for Mac OS X CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB).
 *
 *  @return A shared CPColorSpace object initialized with the standard RGB colorspace.
 **/
+(CPColorSpace *)genericRGBSpace;
{ 
	static CPColorSpace *space = nil;
	if(nil == space) 
	{ 
        CGColorSpaceRef cgSpace = NULL; 
#if defined(TARGET_IPHONE_SIMULATOR) || defined(TARGET_OS_IPHONE)
		cgSpace = CGColorSpaceCreateDeviceRGB();
#else
		cgSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB); 
#endif
        space = [[CPColorSpace alloc] initWithCGColorSpace:cgSpace];
	} 
	return space; 
} 

/** @brief Initializes a newly allocated colorspace object with the specified colorSpace
 *  Initializes a newly allocated colorspace object with the specified colorSpace. This is the designated initializer.
 *  @return The initialized CPColorSpace object.
 **/
-(id)initWithCGColorSpace:(CGColorSpaceRef)colorSpace {
    if ( self = [super init] ) {
        [self setCGColorSpace:colorSpace];
    }
    return self;
}

-(void)dealloc {
    [self setCGColorSpace:NULL];
    [super dealloc];
}

-(void)setCGColorSpace:(CGColorSpaceRef)newSpace {
    if ( newSpace != cgColorSpace ) {
        CGColorSpaceRelease(cgColorSpace);
        CGColorSpaceRetain(newSpace);
        cgColorSpace = newSpace;
    }
}

@end
