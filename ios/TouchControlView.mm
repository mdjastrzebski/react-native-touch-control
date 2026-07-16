#import "TouchControlView.h"

#import "NativeTouchControl.h"

#import <React/RCTConversions.h>

#import <react/renderer/components/TouchControlViewSpec/ComponentDescriptors.h>
#import <react/renderer/components/TouchControlViewSpec/Props.h>
#import <react/renderer/components/TouchControlViewSpec/RCTComponentViewHelpers.h>

#import "RCTFabricComponentsPlugins.h"

using namespace facebook::react;

@implementation TouchControlView {
    NativeTouchControl * _view;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
    return concreteComponentDescriptorProvider<TouchControlViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const TouchControlViewProps>();
    _props = defaultProps;

    // The content view is a UIControl so it silently consumes any touch that
    // lands on it. It is kept sized to the full bounds (see updateLayoutMetrics:)
    // so the control always spans the whole area, padding included.
    //
    // React children are mounted (by RCTViewComponentView) as siblings *beneath*
    // this contentView, since it is added first and stays topmost in the subview
    // stack. The control therefore overlays and consumes touches across the whole
    // area, while transparent regions let the children show through — the same
    // effect as an absolute-fill overlay, but with the children hosted here.
    _view = [[NativeTouchControl alloc] init];

    self.contentView = _view;
  }

  return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
    const auto &oldViewProps = *std::static_pointer_cast<TouchControlViewProps const>(_props);
    const auto &newViewProps = *std::static_pointer_cast<TouchControlViewProps const>(props);

    if (oldViewProps.color != newViewProps.color) {
        [_view setBackgroundColor: RCTUIColorFromSharedColor(newViewProps.color)];
    }

    [super updateProps:props oldProps:oldProps];
}

- (void)updateLayoutMetrics:(const LayoutMetrics &)layoutMetrics
           oldLayoutMetrics:(const LayoutMetrics &)oldLayoutMetrics
{
    [super updateLayoutMetrics:layoutMetrics oldLayoutMetrics:oldLayoutMetrics];

    // RCTViewComponentView sizes contentView to the *content* frame, which is
    // inset by border + padding. That would leave an uncovered ring around the
    // edges where touches slip past the control to the system (e.g. triggering
    // scroll-to-top). Stretch the control over the full bounds so it consumes
    // every touch in the view, padding included.
    _view.frame = self.bounds;
}

@end
