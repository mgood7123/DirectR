/**
 * OpenGL renderer.
 */
public class DirectROffscreen extends DirectRCore {
  
  DirectROffscreen() {
  }
  
  DirectROffscreen(PApplet papplet, int w, int h, boolean createDirectRImage) {
    DirectRInit(papplet, w, h, createDirectRImage);
  }

  DirectROffscreen(PApplet papplet, int w, int h) {
    DirectRInit(papplet, w, h, true);
  }
  
  protected void initOffscreen_() {
    if (DirectRLogging) println("init off screen");
    // Getting the context and capabilities from the main renderer.
    loadTextureImpl(textureSampling, false);

    FrameBuffer ofb = offscreenFramebuffer;
    FrameBuffer mfb = multisampleFramebuffer;

    // dispose is private, obtain it via reflection
    // In case of re-initialization (for example, when the smooth level
    // is changed), we make sure that all the OpenGL resources associated
    // to the surface are released by calling delete().
    if (ofb != null || mfb != null) {
      reflection.get_dispose_begin();
      if (ofb != null) {
        reflection.invoke_dispose(ofb);
        ofb = null;
      }
      if (mfb != null) {
        reflection.invoke_dispose(mfb);
        mfb = null;
      }
    }
    boolean packed = depthBits == 24 && stencilBits == 8 &&
                     packedDepthStencilSupported;
    
    // FrameBuffer is private, obtain it via reflection
    
    reflection.get_FrameBuffer7Args_begin();
    
    if (PGraphicsOpenGL.fboMultisampleSupported && 1 < PGL.smoothToSamples(smooth)) {
      mfb = reflection.invoke_FrameBuffer7Args(this, texture.glWidth, texture.glHeight, PGL.smoothToSamples(smooth), 0,
                            depthBits, stencilBits, packed, false);
      mfb.clear();
      multisampleFramebuffer = mfb;
      offscreenMultisample = true;

      // The offscreen framebuffer where the multisampled image is finally drawn
      // to. If depth reading is disabled it doesn't need depth and stencil buffers
      // since they are part of the multisampled framebuffer.
      if (hints[ENABLE_BUFFER_READING]) {
        ofb = reflection.invoke_FrameBuffer7Args(this, texture.glWidth, texture.glHeight, 1, 1,
                              depthBits, stencilBits, packed, false);
      } else {
        ofb = reflection.invoke_FrameBuffer7Args(this, texture.glWidth, texture.glHeight, 1, 1,
                          0, 0, false, false);
      }
    } else {
      smooth = 0;
      ofb = reflection.invoke_FrameBuffer7Args(this, texture.glWidth, texture.glHeight, 1, 1,
                            depthBits, stencilBits, packed, false);
      offscreenMultisample = false;
    }
    
    ofb.setColorBuffer(texture);
    ofb.clear();
    offscreenFramebuffer = ofb;

    initialized = true;
  }

  protected void beginOffscreenDraw_() {
    if (DirectRLogging) println("beginOffscreenDraw");
    if (!initialized) {
      if (DirectRLogging) println("not initialized");
      initOffscreen_();
    } else {
      if (DirectRLogging) println("initialized");
      FrameBuffer ofb = offscreenFramebuffer;
      FrameBuffer mfb = multisampleFramebuffer;
      // contextIsOutdated is private, obtain it via reflection
      
      reflection.get_contextIsOutdated_begin();
      boolean outdated = ofb != null && reflection.invoke_contextIsOutdated(ofb);
      boolean outdatedMulti = mfb != null && reflection.invoke_contextIsOutdated(mfb);
      
      if (outdated || outdatedMulti) {
        if (DirectRLogging) println("outdated");
        restartPGL_();
        initOffscreen_();
      } else {
        // The back texture of the past frame becomes the front,
        // and the front texture becomes the new back texture where the
        // new frame is drawn to.
        swapOffscreenTextures_();
      }
    }
    
    pushFramebuffer_();
    
    if (offscreenMultisample) {
      FrameBuffer mfb = multisampleFramebuffer;
      if (mfb != null) {
        if (DirectRLogging) println("set framebuffer mfb");
        setFramebuffer_(mfb);
      }
    } else {
      FrameBuffer ofb = offscreenFramebuffer;
      if (ofb != null) {
        if (DirectRLogging) println("set framebuffer ofb");
        setFramebuffer_(ofb);
      }
    }

    // Render previous back texture (now is the front) as background
    drawPTexture_();

    // Restoring the clipping configuration of the offscreen surface.
    if (clip) {
      pgl.enable(PGL.SCISSOR_TEST);
      pgl.scissor(clipRect[0], clipRect[1], clipRect[2], clipRect[3]);
    } else {
      pgl.disable(PGL.SCISSOR_TEST);
    }
  }

  protected void endOffscreenDraw_() {
    if (DirectRLogging) println("endOffscreenDraw");
    // the only functions which appear to copy the texture are:
    //   popFramebuffer();
    //   if (texture != null) {
    //     texture.updateTexels(); // Mark all texels in screen texture as modified.
    //   }
    
    
    
    // this seems to be essential, even tho mfb = ofb, and ofb = mfb,
    // themselves, have no effect
    
    if (offscreenMultisample) {
      if (DirectRLogging) println("multi sample offscreen");
      FrameBuffer ofb = offscreenFramebuffer;
      FrameBuffer mfb = multisampleFramebuffer;
      if (ofb != null && mfb != null) {
        if (DirectRLogging) println("mfb.copyColor(ofb)");
        mfb.copyColor(ofb);
      }
    }

    popFramebuffer_();
    
    if (backgroundA == 1) {
      // this seems to have no effect
      if (DirectRLogging) println("backgroundA");
      // Set alpha channel to opaque in order to match behavior of JAVA2D, not
      // on the multisampled FBO because it leads to wrong background color
      // on some Macbooks with AMD graphics.
      pgl.colorMask(false, false, false, true);
      pgl.clearColor(0, 0, 0, backgroundA);
      pgl.clear(PGL.COLOR_BUFFER_BIT);
      pgl.colorMask(true, true, true, true);
    }

    if (texture != null) {
      if (DirectRLogging) println("texture.updateTexels()");
      texture.updateTexels(); // Mark all texels in screen texture as modified.
    }
    
    // the function restoreGL is protected, lets call it via Reflection
    
    reflection.get_restoreGL_begin();
    //reflection.invoke_restoreGL(getPrimaryPG());
  }
}
