#import "TouchConsumerView.h"

#import "NativeTouchConsumer.h"

#import <React/RCTConversions.h>

#import <react/renderer/components/TouchConsumerViewSpec/ComponentDescriptors.h>
#import <react/renderer/components/TouchConsumerViewSpec/Props.h>
#import <react/renderer/components/TouchConsumerViewSpec/RCTComponentViewHelpers.h>

#import "RCTFabricComponentsPlugins.h"

using namespace facebook::react;

@implementation TouchConsumerView {
    NativeTouchConsumer * _view;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
    return concreteComponentDescriptorProvider<TouchConsumerViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const TouchConsumerViewProps>();
    _props = defaultProps;

    // The content view is a UIControl so it silently consumes any touch that
    // lands on it. RCTViewComponentView sizes contentView to the component's
    // content frame, so the control always spans the whole area.
    _view = [[NativeTouchConsumer alloc] init];

    self.contentView = _view;
  }

  return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
    const auto &oldViewProps = *std::static_pointer_cast<TouchConsumerViewProps const>(_props);
    const auto &newViewProps = *std::static_pointer_cast<TouchConsumerViewProps const>(props);

    if (oldViewProps.color != newViewProps.color) {
        [_view setBackgroundColor: RCTUIColorFromSharedColor(newViewProps.color)];
    }

    [super updateProps:props oldProps:oldProps];
}

@end
