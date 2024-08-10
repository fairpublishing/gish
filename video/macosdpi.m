#import <Cocoa/Cocoa.h>

int getmacosbackingscalefactor() {
    CGFloat pixelRatio;
    for (NSScreen *screen in [NSScreen screens]) {
        pixelRatio = [screen backingScaleFactor];
        NSLog(@"Screen %@ pixel ratio: %f", [screen localizedName], pixelRatio);
    }
    return (int) pixelRatio;
}

