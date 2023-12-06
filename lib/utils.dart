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