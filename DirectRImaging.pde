/**
 * OpenGL renderer.
 */
public class DirectRImaging extends DirectRDraw {
  
  DirectRImaging() {
  }
  
  DirectRImaging(PApplet papplet, int w, int h, boolean createDirectRImage) {
    DirectRInit(papplet, w, h, createDirectRImage);
  }

  DirectRImaging(PApplet papplet, int w, int h) {
    DirectRInit(papplet, w, h, true);
  }

  /**
   * Flips intArray along the X axis.
   * @param intArray int[]
   * @param mult int
   */
  protected void flipArrayOnX(int[] intArray, int mult)  {
    if (DirectRLogging) println("flipArrayOnX");
    int index = 0;
    int xindex = mult * (width - 1);
    for (int x = 0; x < width / 2; x++) {
      for (int y = 0; y < height; y++)  {
        int i = index + mult * y * width;
        int j = xindex + mult * y * width;

        for (int c = 0; c < mult; c++) {
          int temp = intArray[i];
          intArray[i] = intArray[j];
          intArray[j] = temp;

          i++;
          j++;
        }

      }
      index += mult;
      xindex -= mult;
    }
  }


  /**
   * Flips intArray along the Y axis.
   * @param intArray int[]
   * @param mult int
   */
  protected void flipArrayOnY(int[] intArray, int mult) {
    if (DirectRLogging) println("flipArrayOnY");
    int index = 0;
    int yindex = mult * (height - 1) * width;
    for (int y = 0; y < height / 2; y++) {
      for (int x = 0; x < mult * width; x++) {
        int temp = intArray[index];
        intArray[index] = intArray[yindex];
        intArray[yindex] = temp;

        index++;
        yindex++;
      }
      yindex -= mult * width * 2;
    }
  }
  
  /**
   * Reorders an OpenGL pixel array (RGBA) into ARGB. The array must be
   * of size width * height.
   * @param pixels int[]
   */
  protected void convertToARGB(int[] pixels) {
    if (DirectRLogging) println("convert to ARGB (Alpha Red Green Blue)");
    int t = 0;
    int p = 0;
    // BIG_Endian is private
    
    if (reflection.get_BigEndian()) {
      // RGBA to ARGB conversion: shifting RGB 8 bits to the right,
      // and placing A 24 bits to the left.
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          int pixel = pixels[p++];
          pixels[t++] = (pixel >>> 8) | ((pixel << 24) & 0xFF000000);
        }
      }
    } else {
      // We have to convert ABGR into ARGB, so R and B must be swapped,
      // A and G just brought back in.
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          int pixel = pixels[p++];
          pixels[t++] = ((pixel & 0xFF) << 16) | ((pixel & 0xFF0000) >> 16) |
                          (pixel & 0xFF00FF00);
        }
      }
    }
  }
  
  /**
   * Copy texture to pixels. Involves video memory to main memory transfer (slow).
   */
   void texture_get(int[] pixels) {
    if (DirectRLogging) println("texture_get");
    // texture.pg is protected
    PGraphicsOpenGL pg = reflection.get_texture_pg(texture);

    // FrameBuffer is private, obtain it via reflection
    FrameBuffer tempFbo = null;
    
    reflection.get_FrameBuffer3Args_begin();
    tempFbo = reflection.invoke_FrameBuffer3Args(pg, texture.glWidth, texture.glHeight);
    
    tempFbo.setColorBuffer(texture);
    
    pushFramebuffer_();

    setFramebuffer_(tempFbo);
    
    tempFbo.readPixels();
    
    popFramebuffer_();

    tempFbo.getPixels(pixels);
    convertToARGB(pixels);

    // texture.invertedX and texture.invertedY are private, obtain it via reflection
    
    if (reflection.get_texture_invertedX(texture)) flipArrayOnX(pixels, 1);
    if (reflection.get_texture_invertedY(texture)) flipArrayOnY(pixels, 1);
  }
  
  /**
   * Expects x1, y1, x2, y2 coordinates where (x2 >= x1) and (y2 >= y1).
   * If tint() has been called, the image will be colored.
   * <p/>
   * The default implementation draws an image as a textured quad.
   * The (u, v) coordinates are in image space (they're ints, after all..)
   */
  protected void imageImpl_(PImage img,
                           float x1, float y1, float x2, float y2,
                           int u1, int v1, int u2, int v2) {
    if (DirectRLogging) println("imageImpl");
    boolean savedStroke = stroke;
    int savedTextureMode = textureMode;

    stroke = false;
    textureMode = IMAGE;


    u1 *= img.pixelDensity;
    u2 *= img.pixelDensity;
    v1 *= img.pixelDensity;
    v2 *= img.pixelDensity;

    beginShape(QUADS);
    //texture(img);
    // texture(img) just calls:
    // public void texture(PImage image) { textureImage = image; }
    textureImage = img;
    vertex(x1, y1, u1, v1);
    vertex(x1, y2, u1, v2);
    vertex(x2, y2, u2, v2);
    vertex(x2, y1, u2, v1);
    endShape();

    stroke = savedStroke;
    textureMode = savedTextureMode;
  }
  
  public void image_(PImage img, float a, float b) {
    if (DirectRLogging) println("image");
    // Starting in release 0144, image errors are simply ignored.
    // loadImageAsync() sets width and height to -1 when loading fails.
    if (img.width == -1 || img.height == -1) return;

    if (imageMode == CORNER || imageMode == CORNERS) {
      imageImpl_(img,
                a, b, a+img.width, b+img.height,
                0, 0, img.width, img.height);

    } else if (imageMode == CENTER) {
      float x1 = a - img.width/2;
      float y1 = b - img.height/2;
      imageImpl_(img,
                x1, y1, x1+img.width, y1+img.height,
                0, 0, img.width, img.height);
    }
  }
}
