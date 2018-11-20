float x1, y1, z1; 
float x2, y2, z2; 
float x3, y3, z3; 
float x4, y4, z4; 

float[] temp; 
int click;

void setup() 
{ 
  size(1200, 700, P3D);
  
  //x1 = 0; 
  //y1 = 200; 
  //z1 = 0; 

  //x2 = 200; 
  //y2 = 0; 
  //z2 = 0; 

  x3 = 0; 
  y3 = 220; 
  z3 = 0; 

  x4 = 0; 
  y4 = 0; 
  z4 = 200; 
}


void draw() 
{ 
  background(255); 
  drawSurface(click);
}


void drawSurface(int click)
{
 pushMatrix();
    textSize(32);
    fill(255, 0 ,0);
    if(click == 0)
      text("Ruled surface:", 20 , 40);
         if(click == 1)
      text("Projection on x = 0:", 20 , 40);
          if(click == 2)
      text("Projection on y = 0:", 20 , 40);
          if(click == 3)
      text("Projection on z = 0:", 20 , 40);
    noFill();
    camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
    translate(width/2, height/2, 0);
    stroke(0);
    line(-width/2, 0, width/2, 0);
    line(0, -height/2, 0, height/2);
    beginShape();
    vertex(0, 0, width);
    vertex(0, 0, -width);
    vertex(0, 0, width);
    endShape();
    
    stroke(255, 0, 0);
    strokeWeight(2);
    scale(1.3);
   
    for(float u = 0; u < 1; u += 0.0025) 
    { 
       for(float w = 0; w < 1; w += 0.05) 
       { 
          temp = Q(u,w);
          if(click == 0)
            point(temp[0], temp[1], temp[2]);
          if(click == 1)
            point(0, temp[1], temp[2]);
          if(click == 2)
            point(temp[0], 0, temp[2]);
          if(click == 3)
            point(temp[0], temp[1], 0);
       }  
    } 
    popMatrix(); 
}

  
void mousePressed()
{
  click += 1;
  if (click > 3)
  {
    click = 0;
  }
}  


float[] FindCoef(int x1, int y1, int x2, int y2, int x3, int y3)
{   
    float a = ((y3 - y1)*(x2 - x1) - (y2 - y1)*(x3 - x1)) / ((pow(x3, 2) - pow(x1, 2) )*(x2 - x1) - (pow(x2, 2) - pow(x1, 2))*(x3- x1));
    float b = (y2 - y1 - a*(pow(x2,2) - pow(x1, 2))) / (x2 - x1);
    float c = y1 - (a * pow(x1, 2) + b * x1);
    
    float[] res = {a, b, c};

    return res;
}


//float[] P0w(float t) 
//{ 
//   float[] res = { x1 + t * (x2 - x1), y1 + t * (y2 - y1), z1 + t * (z2 - z1)}; 
//   return res; 
//} 


float[] P0w(float t)
{
  float[] coefs = FindCoef(1000, 20, 90, 90, 200, 100);
  float a = coefs[0]; 
  float b = coefs[1];
  float c = coefs[2];
  float[] res = { (a * pow(t, 2)) + 2 * b * t + c, (a * pow(t, 2)) + 2 * b * t + c, (a * pow(t, 2)) + 2 * b + c };
  return res;
}


float[] P1w(float t) 
{ 
   float[] res = { x3 + t * (x4 - x3), y3 + t * (y4 - y3), z3 + t * (z4 - z3)}; 
   return res; 
} 


//float[] Pu0(float t) 
//{ 
//   float[] res = { x1 + t * (x2 - x1), y1 + t * (y2 - y1), z1 + t * (z2 - z1)}; 
//   return res; 
//} 


//float[] Pu1(float t) 
//{ 
//   float[] res = { x3 + t * (x4 - x3), y3 + t * (y4 - y3), z3 + t * (z4 - z3)}; 
//   return res; 
//}


float[] Q(float u, float w)
{     
   float[] p0w = P0w(w); 
   float[] p1w = P1w(w); 
   //float[] p0u = Pu0(u); 
   //float[] p1u = Pu1(u); 
   
   float[] res = {p0w[0] * (1 - u) + p1w[0] * w,
                  p0w[1] * (1 - u) + p1w[1] * w,
                  p0w[2] * (1 - u) + p1w[2] * w};
                  
   return res;
}
