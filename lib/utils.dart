
import 'package:flutter/material.dart';

isTextStep(String s){
  if(s.endsWith(':')) {
    return true;
  } else {
    return false;
  }
}

getMinor(var width, var height){
  if(width < height){
    return width;
  }else{
    return height;
  }
}


textFieldPadding(var width, var height){
  if(width > 500 && height > 500){
    return width * 0.25;
  }else{
    return width * 0.1;
  }
}

buttonWidth(var width, var height){
  if(width > 500 && height > 500){
    return width * 0.25;
  }else{
    return width * 0.45;
  }
}


logoSize(var width, var height, var per){
  if (width > 500 && height > 500) {
    per = per + 0.05;
  }
  
  return height * per; 
}


isTablet(MediaQueryData mediaQueryData){
  if(mediaQueryData.size.width > 500 && mediaQueryData.size.height > 500){
    return true;
  }
  return false;
}

isTabletVerticale(MediaQueryData mediaQueryData){
  if(isTablet(mediaQueryData) && mediaQueryData.orientation == Orientation.portrait){
    return true;
  }
  return false;
}


isTabletOrizzontale(MediaQueryData mediaQueryData){
  if(isTablet(mediaQueryData) && mediaQueryData.orientation == Orientation.landscape){
    return true;
  }
  return false;
}