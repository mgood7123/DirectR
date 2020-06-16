public class DirectRReflection {
  
  java.lang.reflect.Field fbStackDepthField = null;
  boolean fbStackDepthFieldAccessable = false;

  java.lang.reflect.Field fbStackField = null;
  boolean fbStackFieldAccessable = false;

  java.lang.reflect.Field currentFramebufferField = null;
  boolean currentFramebufferFieldAccessable = false;
  
  java.lang.reflect.Field bigEndianField = null;
  boolean bigEndianFieldAccessable = false;
  
  java.lang.reflect.Method dispose = null;
  boolean disposeAccessable = false;

  java.lang.reflect.Constructor FrameBuffer3Args = null;
  boolean FrameBuffer3ArgsAccessable = false;
  
  java.lang.reflect.Constructor FrameBuffer7Args = null;
  boolean FrameBuffer7ArgsAccessable = false;

  java.lang.reflect.Method contextIsOutdated = null;
  boolean contextIsOutdatedAccessable = false;

  java.lang.reflect.Method restoreGL = null;
  boolean restoreGLAccessable = false;

  java.lang.reflect.Field texture_pgField = null;
  boolean texture_pgFieldAccessable = false;

  java.lang.reflect.Field invertedXField = null;
  boolean invertedXFieldAccessable = false;

  java.lang.reflect.Field invertedYField = null;
  boolean invertedYFieldAccessable = false;
  
  java.lang.reflect.Method getGL = null;
  boolean getGLAccessable = false;
  
  java.lang.reflect.Method setCurrentPG0Args = null;
  boolean setCurrentPG0ArgsAccessable = false;
  
  java.lang.reflect.Method setCurrentPG1Arg = null;
  boolean setCurrentPG1ArgAccessable = false;
  
  java.lang.reflect.Field texCacheField = null;
  boolean texCacheFieldAccessable = false;
  
  java.lang.reflect.Method containsTextureField = null;
  boolean containsTextureAccessable = false;
  
  java.lang.reflect.Method getPrimaryPGField = null;
  boolean getPrimaryPGAccessable = false;
  
  
  
  int get_fbStackDepth(PGraphicsOpenGL PGL) {
    int fbStackDepth = 0;
    if (fbStackDepthField == null) {
      try {
        fbStackDepthField = PGraphicsOpenGL.class.getDeclaredField("fbStackDepth");
        fbStackDepthFieldAccessable = fbStackDepthField.isAccessible();
      } catch (NoSuchFieldException e) {
        PGraphics.showException(e.toString());
      }
    }
    
    try {
      if (!fbStackDepthFieldAccessable) fbStackDepthField.setAccessible(true);
      fbStackDepth = fbStackDepthField.getInt(PGL);
      if (!fbStackDepthFieldAccessable) fbStackDepthField.setAccessible(false);
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
    return fbStackDepth;
  }
  
  void put_fbStackDepth(PGraphicsOpenGL PGL, int fbStackDepth) {
    try {
      if (!fbStackDepthFieldAccessable) fbStackDepthField.setAccessible(true);
      fbStackDepthField.set(PGL, fbStackDepth);
      if (!fbStackDepthFieldAccessable) fbStackDepthField.setAccessible(false);
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
  }

  FrameBuffer[] get_fbStack(PGraphicsOpenGL PGL) {
    FrameBuffer[] fbStack = null;
    
    if (fbStackField == null) {
      try {
        fbStackField = PGraphicsOpenGL.class.getDeclaredField("fbStack");
        fbStackFieldAccessable = fbStackField.isAccessible();
      } catch (NoSuchFieldException e) {
        PGraphics.showException(e.toString());
      }
    }
    
    try {
      if (!fbStackFieldAccessable) fbStackField.setAccessible(true);
      fbStack = (FrameBuffer[]) fbStackField.get(PGL);
      if (!fbStackFieldAccessable) fbStackField.setAccessible(false);
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
    return fbStack;
  }
  
  void put_fbStack(PGraphicsOpenGL PGL, FrameBuffer[] fbStack) {
    try {
      if (!fbStackFieldAccessable) fbStackField.setAccessible(true);
      fbStackField.set(PGL, fbStack);
      if (!fbStackFieldAccessable) fbStackField.setAccessible(false);
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
  }
  
  FrameBuffer get_currentFramebuffer(PGraphicsOpenGL PGL) {
    FrameBuffer currentFramebuffer = null;
    
    if (currentFramebufferField == null) {
      try {
        currentFramebufferField = PGraphicsOpenGL.class.getDeclaredField("currentFramebuffer");
        currentFramebufferFieldAccessable = currentFramebufferField.isAccessible();
      } catch (NoSuchFieldException e) {
        PGraphics.showException(e.toString());
      }
    }
    
    try {
      if (!currentFramebufferFieldAccessable) currentFramebufferField.setAccessible(true);
      currentFramebuffer = (FrameBuffer) currentFramebufferField.get(PGL);
      if (!currentFramebufferFieldAccessable) currentFramebufferField.setAccessible(false);
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
    
    return currentFramebuffer;
  }
  
  void put_currentFramebuffer(PGraphicsOpenGL PGL, FrameBuffer currentFramebuffer) {
    try {
      if (!currentFramebufferFieldAccessable) currentFramebufferField.setAccessible(true);
      currentFramebufferField.set(PGL, currentFramebuffer);
      if (!currentFramebufferFieldAccessable) currentFramebufferField.setAccessible(false);
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
  }
  
  boolean get_BigEndian() {
    Boolean bigEndian = false;
    
    if (bigEndianField == null) {
      try {
        bigEndianField = PGL.class.getDeclaredField("BIG_ENDIAN");
        bigEndianFieldAccessable = bigEndianField.isAccessible();
      } catch (NoSuchFieldException e) {
        PGraphics.showException(e.toString());
      }
    }
    
    try {
      if (!bigEndianFieldAccessable) bigEndianField.setAccessible(true);
      bigEndian = bigEndianField.getBoolean(null);
      if (!bigEndianFieldAccessable) bigEndianField.setAccessible(false);
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
    return bigEndian.booleanValue();
  }
    
  void get_dispose_begin() {
    if (dispose == null) {
      try {
        dispose = FrameBuffer.class.getDeclaredMethod("dispose");
        disposeAccessable = dispose.isAccessible();
      } catch (NoSuchMethodException e) {
        PGraphics.showException(e.toString());
      }
    }
  }
  
  void invoke_dispose(FrameBuffer frameBuffer) {
    try {
      if (!disposeAccessable) dispose.setAccessible(true);
      dispose.invoke(frameBuffer);
      if (!disposeAccessable) dispose.setAccessible(false);
    } catch (java.lang.reflect.InvocationTargetException e) {
      PGraphics.showException(e.toString());
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
  }
  
  void get_FrameBuffer3Args_begin() {
    if (FrameBuffer3Args == null) {
      try {
        Class.forName("processing.opengl.FrameBuffer");
        FrameBuffer3Args = FrameBuffer.class.getDeclaredConstructor(
            PGraphicsOpenGL.class, int.class, int.class
        );
        FrameBuffer3ArgsAccessable = FrameBuffer3Args.isAccessible();
      } catch (ClassNotFoundException e) {
        PGraphics.showException(e.toString());
      } catch (NoSuchMethodException e) {
        PGraphics.showException(e.toString());
      }
    }
  }
  
  FrameBuffer invoke_FrameBuffer3Args(PGraphics a, int b, int c) {
    FrameBuffer fb = null;
    try {
      if (!FrameBuffer3ArgsAccessable) FrameBuffer3Args.setAccessible(true);
      fb = (FrameBuffer) FrameBuffer3Args.newInstance(a, b, c);
      if (!FrameBuffer3ArgsAccessable) FrameBuffer3Args.setAccessible(false);
    } catch (IllegalAccessException e_) {
      PGraphics.showException(e_.toString());
    } catch (InstantiationException e_) {
      PGraphics.showException(e_.toString());
    } catch (java.lang.reflect.InvocationTargetException e_) {
      PGraphics.showException(e_.toString());
    }
    return fb;
  }
  
  void get_FrameBuffer7Args_begin() {
    if (FrameBuffer7Args == null) {
      try {
        Class.forName("processing.opengl.FrameBuffer");
        FrameBuffer7Args = FrameBuffer.class.getDeclaredConstructor(
            PGraphicsOpenGL.class, 
            int.class, int.class, int.class, int.class, int.class, int.class,
            boolean.class, boolean.class
        );
        FrameBuffer7ArgsAccessable = FrameBuffer7Args.isAccessible();
      } catch (ClassNotFoundException e) {
        PGraphics.showException(e.toString());
      } catch (NoSuchMethodException e) {
        PGraphics.showException(e.toString());
      }
    }
  }
  
  FrameBuffer invoke_FrameBuffer7Args(PGraphics a, int b, int c, int d, int e, int f, int g, boolean h, boolean i) {
    FrameBuffer fb = null;
    try {
      if (!FrameBuffer7ArgsAccessable) FrameBuffer7Args.setAccessible(true);
      fb = (FrameBuffer) FrameBuffer7Args.newInstance(a, b, c, d, e, f, g, h, i);
      if (!FrameBuffer7ArgsAccessable) FrameBuffer7Args.setAccessible(false);
    } catch (IllegalAccessException e_) {
      PGraphics.showException(e_.toString());
    } catch (InstantiationException e_) {
      PGraphics.showException(e_.toString());
    } catch (java.lang.reflect.InvocationTargetException e_) {
      PGraphics.showException(e_.toString());
    }
    return fb;
  }
  
  void get_contextIsOutdated_begin() {
    if (contextIsOutdated == null) {
      try {
        contextIsOutdated = FrameBuffer.class.getDeclaredMethod("contextIsOutdated");
        contextIsOutdatedAccessable = contextIsOutdated.isAccessible();
      } catch (NoSuchMethodException e) {
        PGraphics.showException(e.toString());
      }
    }
  }
  
  boolean invoke_contextIsOutdated(FrameBuffer frameBuffer) {
    Boolean value = false;
    try {
      if (!contextIsOutdatedAccessable) contextIsOutdated.setAccessible(true);
      value = (Boolean) contextIsOutdated.invoke(frameBuffer);
      if (!contextIsOutdatedAccessable) contextIsOutdated.setAccessible(false);
    } catch (java.lang.reflect.InvocationTargetException e) {
      PGraphics.showException(e.toString());
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
    return value.booleanValue();
  }
  
  void get_restoreGL_begin() {
    if (restoreGL == null) {
      try {
        restoreGL = PGraphicsOpenGL.class.getDeclaredMethod("restoreGL");
        restoreGLAccessable = restoreGL.isAccessible();
      } catch (NoSuchMethodException e) {
        PGraphics.showException(e.toString());
      }
    }
  }
  
  void invoke_restoreGL(PGraphicsOpenGL PGL) {
    try {
      if (!restoreGLAccessable) restoreGL.setAccessible(true);
      restoreGL.invoke(PGL);
      if (!restoreGLAccessable) restoreGL.setAccessible(false);
    } catch (java.lang.reflect.InvocationTargetException e) {
      PGraphics.showException(e.toString());
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
  }
  
  PGraphicsOpenGL get_texture_pg(Texture texture) {
    PGraphicsOpenGL pg = null;
    
    if (texture_pgField == null) {
      try {
        texture_pgField = Texture.class.getDeclaredField("pg");
        texture_pgFieldAccessable = texture_pgField.isAccessible();
      } catch (NoSuchFieldException e) {
        PGraphics.showException(e.toString());
      }
    }
    
    try {
      if (!texture_pgFieldAccessable) texture_pgField.setAccessible(true);
      pg = (PGraphicsOpenGL) texture_pgField.get(texture);
      if (!texture_pgFieldAccessable) texture_pgField.setAccessible(false);
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
    
    return pg;
  }

  boolean get_texture_invertedX(Texture texture) {
    Boolean invertedX = false;
    
    if (invertedXField == null) {
      try {
        invertedXField = Texture.class.getDeclaredField("invertedX");
        invertedXFieldAccessable = invertedXField.isAccessible();
      } catch (NoSuchFieldException e) {
        PGraphics.showException(e.toString());
      }
    }
    
    try {
      if (!invertedXFieldAccessable) invertedXField.setAccessible(true);
      invertedX = invertedXField.getBoolean(texture);
      if (!invertedXFieldAccessable) invertedXField.setAccessible(false);
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
    return invertedX.booleanValue();
  }

  boolean get_texture_invertedY(Texture texture) {
    Boolean invertedY = false;
    
    if (invertedYField == null) {
      try {
        invertedYField = Texture.class.getDeclaredField("invertedY");
        invertedYFieldAccessable = invertedYField.isAccessible();
      } catch (NoSuchFieldException e) {
        PGraphics.showException(e.toString());
      }
    }
    
    try {
      if (!invertedYFieldAccessable) invertedYField.setAccessible(true);
      invertedY = invertedYField.getBoolean(texture);
      if (!invertedYFieldAccessable) invertedYField.setAccessible(false);
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
    return invertedY.booleanValue();
  }
  
  void get_getGL_begin() {
    if (getGL == null) {
      try {
        getGL = PJOGL.class.getDeclaredMethod("getGL", PGL.class);
        getGLAccessable = getGL.isAccessible();
      } catch (NoSuchMethodException e) {
        PGraphics.showException(e.toString());
      }
    }
  }
  
  void invoke_getGL(PGL pgl1, PGL pgl2) {
    try {
      if (!getGLAccessable) getGL.setAccessible(true);
      getGL.invoke(pgl1, pgl2);
      if (!getGLAccessable) getGL.setAccessible(false);
    } catch (java.lang.reflect.InvocationTargetException e) {
      PGraphics.showException(e.toString());
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
  }

  void get_setCurrentPG0Args_begin() {
    if (setCurrentPG0Args == null) {
      try {
        setCurrentPG0Args = PGraphicsOpenGL.class.getDeclaredMethod("setCurrentPG");
        setCurrentPG0ArgsAccessable = setCurrentPG0Args.isAccessible();
      } catch (NoSuchMethodException e) {
        PGraphics.showException(e.toString());
      }
    }
  }
  
  void invoke_setCurrentPG0Args(PGraphicsOpenGL PGL) {
    try {
      if (!setCurrentPG0ArgsAccessable) setCurrentPG0Args.setAccessible(true);
      setCurrentPG0Args.invoke(PGL);
      if (!setCurrentPG0ArgsAccessable) setCurrentPG0Args.setAccessible(false);
    } catch (java.lang.reflect.InvocationTargetException e) {
      PGraphics.showException(e.toString());
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
  }
  
  void get_setCurrentPG1Arg_begin() {
    if (setCurrentPG1Arg == null) {
      try {
        setCurrentPG1Arg = PGraphicsOpenGL.class.getDeclaredMethod("setCurrentPG", PGraphicsOpenGL.class);
        setCurrentPG1ArgAccessable = setCurrentPG1Arg.isAccessible();
      } catch (NoSuchMethodException e) {
        PGraphics.showException(e.toString());
      }
    }
  }
  
  void invoke_setCurrentPG1Arg(PGraphicsOpenGL PGL, PGraphicsOpenGL pg) {
    try {
      if (!setCurrentPG1ArgAccessable) setCurrentPG1Arg.setAccessible(true);
      setCurrentPG1Arg.invoke(PGL, pg);
    if (!setCurrentPG1ArgAccessable) setCurrentPG1Arg.setAccessible(false);
    } catch (java.lang.reflect.InvocationTargetException e) {
      PGraphics.showException(e.toString());
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
  }
  
  Object get_texCache(PGraphicsOpenGL PGL) {
    Object texCache = null;
    
    if (texCacheField == null) {
      try {
        texCacheField = PGraphicsOpenGL.class.getDeclaredField("texCache");
        texCacheFieldAccessable = texCacheField.isAccessible();
      } catch (NoSuchFieldException e) {
        PGraphics.showException(e.toString());
      }
    }
    
    try {
      if (!texCacheFieldAccessable) texCacheField.setAccessible(true);
      texCache = texCacheField.get(PGL);
      if (!texCacheFieldAccessable) texCacheField.setAccessible(false);
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
    return texCache;
  }

  boolean invoke_containsTexture(Object texCache, PImage image) {
    Boolean containsTexture = false;
    
    if (containsTextureField == null) {
      try {
        containsTextureField = texCache.getClass().getDeclaredMethod("containsTexture", PImage.class);
        containsTextureAccessable = containsTextureField.isAccessible();
      } catch (NoSuchMethodException e) {
        PGraphics.showException(e.toString());
      }
    }
    
    try {
      if (!containsTextureAccessable) containsTextureField.setAccessible(true);
      containsTexture = (Boolean) containsTextureField.invoke(texCache, image);
      if (!containsTextureAccessable) containsTextureField.setAccessible(false);
    } catch (java.lang.reflect.InvocationTargetException e) {
      PGraphics.showException(e.toString());
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
    return containsTexture.booleanValue();
  }
  
  PGraphicsOpenGL invoke_getPrimaryPG(PGraphicsOpenGL ppg) {
    PGraphicsOpenGL getPrimaryPG = null;
    
    if (getPrimaryPGField == null) {
      try {
        getPrimaryPGField = PGraphicsOpenGL.class.getDeclaredMethod("getPrimaryPG");
        getPrimaryPGAccessable = getPrimaryPGField.isAccessible();
      } catch (NoSuchMethodException e) {
        PGraphics.showException(e.toString());
      }
    }
    
    try {
      if (!getPrimaryPGAccessable) getPrimaryPGField.setAccessible(true);
      getPrimaryPG = (PGraphicsOpenGL) getPrimaryPGField.invoke(ppg);
      if (!getPrimaryPGAccessable) getPrimaryPGField.setAccessible(false);
    } catch (java.lang.reflect.InvocationTargetException e) {
      PGraphics.showException(e.toString());
    } catch (IllegalAccessException e) {
      PGraphics.showException(e.toString());
    }
    return getPrimaryPG;
  }
}
