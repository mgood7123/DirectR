/**
 * OpenGL renderer.
 */
public class DirectRDraw extends DirectROffscreen {

  DirectRDraw() {
  }
  
  DirectRDraw(PApplet papplet, int w, int h, boolean createDirectRImage) {
    DirectRInit(papplet, w, h, createDirectRImage);
  }

  DirectRDraw(PApplet papplet, int w, int h) {
    DirectRInit(papplet, w, h, true);
  }
  
  void beginDraw_() {
    if (DirectRLogging) println("beginDraw_");
    // the function getGL is protected, lets call it via Reflection
    
    reflection.get_getGL_begin();
    reflection.invoke_getGL(pgl, getPrimaryPGL());
    
    // the function setCurrentPG is protected, lets call it via Reflection
    
    reflection.get_setCurrentPG1Arg_begin();
    reflection.invoke_setCurrentPG1Arg(getPrimaryPG(), this);

    // This has to go after the surface initialization, otherwise offscreen
    // surfaces will have a null gl object.
    report("top beginDraw()");

    if (!checkGLThread()) {
      if (DirectRLogging) println("if (!checkGLThread()) return;");
      return;
    }

    if (drawing) {
      if (DirectRLogging) println("if (drawing) return;");
      return;
    }
    
    // the method texCache is protected
    // lets access it via reflection
    
    TexCache texCache = (TexCache) reflection.get_texCache(getPrimaryPG());
    
    // the function texCache.containsTexture(this) is protected
    // lets call it via Reflection

    if (!primaryGraphics && reflection.invoke_containsTexture(texCache, this)) {
      // This offscreen surface is being used as a texture earlier in draw,
      // so we should update the rendering up to this point since it will be
      // modified.
      if (DirectRLogging) println("getPrimaryPG().flush();");
      getPrimaryPG().flush();
    }

    if (!glParamsRead) {
      if (DirectRLogging) println("getGLParameters();");
      getGLParameters();
    }

    setViewport();
    beginOffscreenDraw_();
    checkSettings();

    drawing = true;
    
    report("bot beginDraw()");
  }
  
  void endDraw_() {
    if (DirectRLogging) println("endDraw_");
    report("top endDraw()");
    
    if (!drawing) {
      return;
    }
    
    println("multisampleFramebuffer = " + multisampleFramebuffer);
    println("offscreenFramebuffer = " + offscreenFramebuffer);
    
    endOffscreenDraw_();
    
    // the function setCurrentPG is protected, lets call it via Reflection
    
    reflection.get_setCurrentPG0Args_begin();
    reflection.invoke_setCurrentPG0Args(getPrimaryPG());
    
    drawing = false;
    
    // 27 - 30 FPS if not null, otherwise 60 FPS
    //DirectRImage = null;
    if (DirectRImage != null) {
      
      // fast - no FPS reduction
      //DirectRImage.beginDraw();
  
      //// slow - reduces FPS by a range from 10 to 16 -- 27 to 30 FPS
      //// image draws of the texture of the argument given to it
      //DirectRImage.image_(this, 0, 0);

      // slow - reduces FPS by a range from 5 to 13 -- 47 to 55 FPS
      // image draws of the texture of the argument given to it
      //parent.g.image(this, 0, 0);
      
      // slow - reduces FPS by a range from 13 to 20 -- 40 to 47 FPS
      // if DirectRImage is not null this will recursive loop untill null
      //DirectRImage.endDraw_();
    }
    
    //DirectRImage.loadPixels();
    //image_(this, width, height);
    // IMPORTANT: without texture.get() the performance jumps up signifigantly
    
    // with: 11 FPS for 400x400 32 draws
    // without: 60 FPS for 400x400 32 draws
    
    // DirectRImage = get(); // THIS IS AS SLOW AS texture.get()
    
    //PImage test = createImage(500, 500, ARGB);
    //test.loadPixels();
    //texture_get(test.pixels);
    //test.updatePixels();
    //test = null;
    
    //DirectRImage.updatePixels();
    report("bot endDraw()");
  }
}
