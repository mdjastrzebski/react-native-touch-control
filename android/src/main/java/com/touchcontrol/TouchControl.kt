package com.touchcontrol

import android.content.Context
import android.util.AttributeSet
import com.facebook.react.views.view.ReactViewGroup

/**
 * On Android this is intentionally a no-op container: there is no use case for
 * consuming touches here, so it simply renders its children and lets touch
 * handling behave like any ordinary view. The touch-consuming behaviour only
 * exists on iOS.
 *
 * It extends [ReactViewGroup] (rather than a plain View) so that React can add
 * child views to it; a non-ViewGroup would crash with "Trying to add a view
 * that is not a ViewGroup".
 */
class TouchControl : ReactViewGroup {
  constructor(context: Context?) : super(context)
  constructor(context: Context?, attrs: AttributeSet?) : super(context)
  constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(context)
}
