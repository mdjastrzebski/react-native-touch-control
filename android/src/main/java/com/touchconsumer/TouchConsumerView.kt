package com.touchconsumer

import android.content.Context
import android.util.AttributeSet
import android.view.View

/**
 * On Android this is intentionally a plain [View] no-op: there is no use case
 * for consuming touches here, so it simply renders (optionally colored) and
 * lets touch handling behave like any ordinary view. The touch-consuming
 * behaviour only exists on iOS.
 */
class TouchConsumerView : View {
  constructor(context: Context?) : super(context)
  constructor(context: Context?, attrs: AttributeSet?) : super(context, attrs)
  constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(
    context,
    attrs,
    defStyleAttr
  )
}
