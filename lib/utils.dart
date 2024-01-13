
import 'package:flutter/material.dart';

textSize(var width, var height, var per){
  if (width > 600 && height > 600){
    per = per - 0.004;
    if (width > height) {
      return width * per;
    }
    else{
      return height * per; 
    }
  } else
    if (width > height) {
      return width * per;
    }
    else{
      return height * per; 
    }
}

size(var width, var height, double size){
  if (width > 600 && height > 600){
    return (size + 6).toDouble();
  }else{
    return size.toDouble();
  }
}

iconSize(var width, var height, var per){
  if (width > 600 && height > 600){
    per = per + 0.04;
    if (width > height) {
      return width * per;
    }
    else{
      return height * per; 
    }
  } else
    if (width > height) {
      return width * per;
    }
    else{
      return height * per; 
    }
}

logoSize(var width, var height, var per){
  if (width > 600 && height > 600) {
    per = per + 0.10;
  }
  
  return height * per; 
}


getMinor(var width, var height){
  if(width < height){
    return width;
  }else{
    return height;
  }
}


textFieldPadding(var width, var height){
  if(width > 600 && height > 600){
    return width * 0.25;
  }else{
    return width * 0.1;
  }
}

buttonWidth(var width, var height){
  if(width > 600 && height > 600){
    return width * 0.25;
  }else{
    return width * 0.45;
  }
}


isTabletVertica(MediaQueryData mediaQueryData){
  if(getMinor(mediaQueryData.size.width, mediaQueryData.size.height) > 660 && mediaQueryData.orientation == Orientation.portrait){
    return true;
  }
  return false;
}

isTablet(MediaQueryData mediaQueryData){
  if(getMinor(mediaQueryData.size.width, mediaQueryData.size.height) > 660){
    return true;
  }
  return false;
}