#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// A `UIControl` that silently consumes touches landing within its bounds,
/// preventing them from reaching views behind it. It performs no action of its
/// own — being a `UIControl` is enough to make it track (and thus swallow) the
/// touch instead of letting React Native's gesture system deliver it elsewhere.
@interface NativeTouchConsumer : UIControl
@end

NS_ASSUME_NONNULL_END
