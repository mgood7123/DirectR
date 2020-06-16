/**
 * OpenGL renderer.
 */
public class DirectRCore extends PGraphics3D {
  
  // to be safe, prefix everything with DirectR
  
  boolean DirectRLogging = true;
  
  // use java.lang.reflection wrappers class to simplify code
  
  // all methods in DirectRReflection will cache if possible
  
  // DirectRReflection no longer extends the PGraphicsOpenGL
  // class and instead calls texCache.getClass()
  
  DirectRReflection reflection = new DirectRReflection();
  
  DirectR DirectRImage = null;
  
  protected void DirectRInit(PApplet papplet, int w, int h, boolean createDirectRImage) {
    if (DirectRLogging) {
      if (createDirectRImage) println("DirectRInit (create image)");
      else println("DirectRInit");
    }
    // PApplet cannot be cast
    setParent(papplet);
    setPrimary(false);
    setSize(w, h);
    if (createDirectRImage) {
      DirectRImage = new DirectR(papplet, w, h, false);
    }
  }
  
  DirectRCore() {
  }
  
  DirectRCore(PApplet papplet, int w, int h, boolean createDirectRImage) {
    DirectRInit(papplet, w, h, createDirectRImage);
  }

  DirectRCore(PApplet papplet, int w, int h) {
    DirectRInit(papplet, w, h, true);
  }

  void DirectRSetup() {
    beginDraw();
  }
  
  void DirectRExit() {
    DirectRImage.endDraw();
  }
    
  protected void pushFramebuffer_() {
    if (DirectRLogging) println("pushFramebuffer");
    PGraphicsOpenGL ppg = getPrimaryPG();
    // all of the following is protected
    // lets use reflection to access these

    // fbStackDepth is protected
    int fbStackDepth = reflection.get_fbStackDepth(ppg);
    
    if (fbStackDepth == FB_STACK_DEPTH) {
      throw new RuntimeException("Too many pushFramebuffer calls");
    }
    
    // fbStack is protected
    FrameBuffer[] fbStack = reflection.get_fbStack(ppg);

    // currentFramebuffer is protected

    fbStack[fbStackDepth] = reflection.get_currentFramebuffer(ppg);
    
    reflection.put_fbStack(ppg, fbStack);
        
    fbStackDepth++;
    
    reflection.put_fbStackDepth(ppg, fbStackDepth);    
  }
  
  protected void setFramebuffer_(FrameBuffer fbo) {
    if (DirectRLogging) println("setFramebuffer");
    PGraphicsOpenGL ppg = getPrimaryPG();
    // all of the following is protected
    // lets use reflection to access these

    // currentFramebuffer is protected
    FrameBuffer currentFramebuffer = reflection.get_currentFramebuffer(ppg);
    
    if (currentFramebuffer != fbo) {
      currentFramebuffer = fbo;
      reflection.put_currentFramebuffer(ppg, currentFramebuffer);
      if (currentFramebuffer != null) currentFramebuffer.bind();
    }
  }
  
  //@Override
  protected void popFramebuffer_() {
    if (DirectRLogging) println("pop frame buffer");
    PGraphicsOpenGL ppg = getPrimaryPG();
    // all of the following is protected
    // lets use reflection to access these

    // fbStackDepth is protected
    
    int fbStackDepth = reflection.get_fbStackDepth(ppg);
    
    if (fbStackDepth == 0) {
      throw new RuntimeException("popFramebuffer call is unbalanced.");
    }
    
    fbStackDepth--;
    
    reflection.put_fbStackDepth(ppg, fbStackDepth);

    // fbStack is protected
    FrameBuffer[] fbStack = reflection.get_fbStack(ppg);
    
    FrameBuffer fbo = fbStack[fbStackDepth];
    
    // currentFramebuffer is protected
    FrameBuffer currentFramebuffer = reflection.get_currentFramebuffer(ppg);

    if (currentFramebuffer != fbo) {
      if (DirectRLogging) println("framebuffer != fbo");
      currentFramebuffer.finish();
      currentFramebuffer = fbo;
      reflection.put_currentFramebuffer(ppg, currentFramebuffer);

      if (currentFramebuffer != null) {
        if (DirectRLogging) println("bind framebuffer");
        currentFramebuffer.bind();
      }
    }
  }
  
  protected void swapOffscreenTextures_() {
    if (DirectRLogging) println("swapOffscreenTextures");
    FrameBuffer ofb = offscreenFramebuffer;
    if (texture != null && ptexture != null && ofb != null) {
      int temp = texture.glName;
      texture.glName = ptexture.glName;
      ptexture.glName = temp;
      ofb.setColorBuffer(texture);
    }
  }
  
  // this draws the previous texture
  protected void drawPTexture_() {
    if (DirectRLogging) println("draw previous texture");
    if (ptexture != null) {
      // No blend so the texure replaces wherever is on the screen,
      // irrespective of the alpha
      pgl.disable(PGL.BLEND);
      pgl.drawTexture(ptexture.glTarget, ptexture.glName,
                      ptexture.glWidth, ptexture.glHeight,
                      0, 0, width, height);
      pgl.enable(PGL.BLEND);
    }
  }
  
  protected void restartPGL_() {
    if (DirectRLogging) println("restartPGL");
    initialized = false;
  }
  
  /**
   * Report on anything from glError().
   * Don't use this inside glBegin/glEnd otherwise it'll
   * throw an GL_INVALID_OPERATION error.
   */
  @Override
  protected void report(String where) {
     if (DirectRLogging) println("report");
   if (DirectRLogging) println(where);
    if (!hints[DISABLE_OPENGL_ERRORS]) {
      int err = pgl.getError();
      if (err != 0) {
        String errString = pgl.errorString(err);
        String msg = "OpenGL error " + err + " at " + where + ": " + errString;
        PGraphics.showWarning(msg);
      }
    }
  }
}
