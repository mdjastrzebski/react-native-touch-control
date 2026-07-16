package com.touchcontrol

import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.ViewGroupManager
import com.facebook.react.uimanager.ViewManagerDelegate
import com.facebook.react.viewmanagers.TouchControlViewManagerInterface
import com.facebook.react.viewmanagers.TouchControlViewManagerDelegate

@ReactModule(name = TouchControlViewManager.NAME)
class TouchControlViewManager : ViewGroupManager<TouchControlView>(),
  TouchControlViewManagerInterface<TouchControlView> {
  private val mDelegate: ViewManagerDelegate<TouchControlView>

  init {
    mDelegate = TouchControlViewManagerDelegate(this)
  }

  override fun getDelegate(): ViewManagerDelegate<TouchControlView>? {
    return mDelegate
  }

  override fun getName(): String {
    return NAME
  }

  public override fun createViewInstance(context: ThemedReactContext): TouchControlView {
    return TouchControlView(context)
  }

  companion object {
    const val NAME = "TouchControlView"
  }
}
