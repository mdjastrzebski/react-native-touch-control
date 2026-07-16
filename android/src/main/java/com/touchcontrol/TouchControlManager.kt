package com.touchcontrol

import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.ViewGroupManager
import com.facebook.react.uimanager.ViewManagerDelegate
import com.facebook.react.viewmanagers.TouchControlManagerInterface
import com.facebook.react.viewmanagers.TouchControlManagerDelegate

@ReactModule(name = TouchControlManager.NAME)
class TouchControlManager : ViewGroupManager<TouchControl>(),
  TouchControlManagerInterface<TouchControl> {
  private val mDelegate: ViewManagerDelegate<TouchControl>

  init {
    mDelegate = TouchControlManagerDelegate(this)
  }

  override fun getDelegate(): ViewManagerDelegate<TouchControl>? {
    return mDelegate
  }

  override fun getName(): String {
    return NAME
  }

  public override fun createViewInstance(context: ThemedReactContext): TouchControl {
    return TouchControl(context)
  }

  companion object {
    const val NAME = "TouchControl"
  }
}
