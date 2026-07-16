# react-native-touch-control

A React Native view backed by a real native iOS `UIControl`. Its presence in the view hierarchy makes iOS treat the region as an interactive control, so system behaviors that defer to controls will skip over it.

The motivating case is scroll-to-top: on iOS, tapping the status bar scrolls the nearest scroll view to the top. That is great by default, but it fires even when the tap lands on a button you placed in the top bar, which can yank a list back up when the user meant to press the button. Wrapping that button in a `NativeTouchControl` opts the region out of the behavior.

> [!NOTE]
> This is an **iOS-only** behavior. On Android the component is a plain passthrough container (see [Platform support](#platform-support)).

## Demo

<p align="center">
  <img src="./docs/NativeTouchControlExample.gif" alt="Pressing a nav-bar button wrapped in NativeTouchControl no longer triggers scroll-to-top" width="300" />
</p>

The nav-bar buttons sit in the status-bar tap zone. Because their labels are wrapped in `NativeTouchControl`, pressing them no longer scrolls the list to the top. A runnable version lives in [`example/`](./example).

## Installation

```sh
npm install react-native-touch-control
```

Then install pods (or let your build do it):

```sh
cd ios && pod install
```

This library uses the New Architecture (Fabric). No extra linking steps are required beyond autolinking.

## Usage

Wrap whatever should sit in an "opt-out" region:

```tsx
import { NativeTouchControl } from 'react-native-touch-control';

function TopBarButton({ label, onPress }) {
  return (
    <Pressable onPress={onPress}>
      {/*
        This button lives in the status-bar tap zone. Hosting its content
        inside NativeTouchControl makes iOS see a UIControl here and skip
        scroll-to-top, so pressing the button no longer scrolls the list up.
      */}
      <NativeTouchControl>
        <Text>{label}</Text>
      </NativeTouchControl>
    </Pressable>
  );
}
```

`NativeTouchControl` accepts all standard `View` props, so you can lay it out and style it like any other view. Children render inside it.

## How it works

iOS's scroll-to-top logic does not blindly scroll on a status-bar tap. Before scrolling, UIKit walks the view hierarchy under the touch and checks whether an interactive `UIControl` is there. If it finds one, it assumes the tap belongs to that control and leaves the scroll view alone.

`NativeTouchControl` exploits that check. The native view is a `UIControl` subclass that does nothing on its own — it defines no target/action and consumes no events. It is a **passive marker**: its mere presence in the hierarchy is enough for iOS's heuristic to detect a control and back off.

Because this is a general UIKit heuristic rather than a scroll-to-top-specific hook, the same trick can shield a region from other system behaviors that defer to `UIControl`s, not just scroll-to-top.

A couple of implementation details worth knowing:

- The control is stretched to the view's **full bounds**, padding included, so there is no uncovered ring around the edges where a tap could slip past it to the system.
- React children are mounted underneath the control, so transparent regions show your content through while the control still overlays the whole area.

## Platform support

| Platform | Behavior                                                                                     |
| -------- | -------------------------------------------------------------------------------------------- |
| iOS      | Renders a native `UIControl` region; opts the area out of `UIControl`-deferring system behaviors such as scroll-to-top. |
| Android  | No-op passthrough. It renders its children and behaves like an ordinary view. There is no equivalent scroll-to-top behavior to suppress. |

Writing the component once and letting it be a no-op on Android means you can use it in cross-platform code without branching.

## Contributing

- [Development workflow](CONTRIBUTING.md#development-workflow)
- [Sending a pull request](CONTRIBUTING.md#sending-a-pull-request)
- [Code of conduct](CODE_OF_CONDUCT.md)

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
