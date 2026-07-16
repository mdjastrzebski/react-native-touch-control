#import "TouchControlViewNativeComponent.h"

#import <react/renderer/components/TouchControlViewSpec/ComponentDescriptors.h>
#import <react/renderer/components/TouchControlViewSpec/Props.h>
#import <react/renderer/components/TouchControlViewSpec/RCTComponentViewHelpers.h>

#import "RCTFabricComponentsPlugins.h"

using namespace facebook::react;

@implementation TouchControlView {
    UIControl * _view;
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

    // The content view is a passive UIControl marker. It defines no
    // target/action and does nothing on its own; its mere presence in the UIKit
    // hierarchy is enough for system heuristics that defer to a UIControl (such
    // as scroll-to-top) to detect a control here and back off. It does not
    // interfere with React Native's own touch dispatch. It is kept sized to the
    // full bounds (see updateLayoutMetrics:) so the marker always spans the
    // whole area, padding included.
    //
    // A bare UIControl is enough — the heuristic only checks for a UIControl in
    // the hierarchy, so no subclass or custom behavior is needed.
    //
    // React children are mounted (by RCTViewComponentView) as siblings *beneath*
    // this contentView, since it is added first and stays topmost in the subview
    // stack. The control therefore overlays the whole area while transparent
    // regions let the children show through — the same effect as an
    // absolute-fill overlay, but with the children hosted here.
    _view = [[UIControl alloc] init];

    self.contentView = _view;
  }

  return self;
}

- (void)updateLayoutMetrics:(const LayoutMetrics &)layoutMetrics
           oldLayoutMetrics:(const LayoutMetrics &)oldLayoutMetrics
{
    [super updateLayoutMetrics:layoutMetrics oldLayoutMetrics:oldLayoutMetrics];

    // RCTViewComponentView sizes contentView to the *content* frame, which is
    // inset by border + padding. That would leave an uncovered ring around the
    // edges where the marker is absent, so a tap there could still reach the
    // system behavior (e.g. triggering scroll-to-top). Stretch the control over
    // the full bounds so the marker covers every point in the view, padding
    // included.
    _view.frame = self.bounds;
}

@end
