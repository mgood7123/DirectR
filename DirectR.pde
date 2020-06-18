/**
 * OpenGL renderer.
 */
public class DirectR extends DirectRImaging {
  
  DirectR() {
  }
  
  DirectR(PApplet papplet, int w, int h, boolean createDirectRImage) {
    DirectRInit(papplet, w, h, createDirectRImage);
  }

  DirectR(PApplet papplet, int w, int h) {
    DirectRInit(papplet, w, h, true);
  }

  void imageFrameBuffer() {
    if (DirectRLogging) println("image frame buffer");
    flush();
    
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
      if (DirectRLogging) println("currentFramebuffer != fbo");
      // these do not seem to affect loop(); drawing, still nothing is drawn
      reflection.put_currentFramebuffer(ppg, fbo);
      parent.g.image(this, 0, 0);
      reflection.put_currentFramebuffer(ppg, currentFramebuffer);

      //if (fbo != null) {
      //  if (DirectRLogging) println("bind framebuffer");
      //  fbo.bind();
      //}
    }

    fbStackDepth++;
    
    reflection.put_fbStackDepth(ppg, fbStackDepth);
  }
}
