float line_dist(float x, float y, float x1, float y1, float x2, float y2) {
  float a = (y2-y1)/(x2-x1);
  float b = - a*x2 + y2; //y -ax -b = 0
  PVector P1 = new PVector(x2-x1, y2-y1);
  PVector Q1 = new PVector(x-x1, y-y1);
  PVector Q2 = new PVector(x-x2, y-y2);
  float d;
  if (P1.dot(Q1) > 0 && ((P1.mult(-1)).dot(Q2) > 0)) {
    d = abs(-a*x+y-b)/sqrt(1+a*a);
  } else {
    d = min(dist(x, y, x1, y1), dist(x, y, x2, y2));
  }
  return d;
}
float dis_l(float a, float b, float c, float x0, float y0) {
  return abs(a*x0+b*y0+c)/sqrt(sq(a)+sq(b));
}
class conv_text {
  String message = "";
  boolean delete = false;
  int talker = 0;
  int time = 0;
  int time_per = 5;
  conv_text(String message, int talker) {
    this.message = message;
    this.talker = talker;
  }
  void process() {
    time++;
    String m = message + "▼";
    if (KeyState.mRget(LEFT)) {
      if (min(time/time_per, m.length()) == m.length()) {
        delete = true;
      } else {
        time = m.length()*time_per;
      }
    }
  }
  void display(float x, float y) {
    String m = message + "▼";
    String s = m.substring(0, min(time/time_per, m.length()));
    textSize(45);
    if (talker == 1)fill(255, 200, 200);
    if (talker == 0)fill(200, 200, 255);
    text(s, x, y);
  }
}
void draw_string(String S, int x, int y, color c1, color c2,int step) {

  int[][] a = { {step, 0},
    {0, step},
    {-step, 0},
    {0, -step},
    {step, step},
    {step, -step},
    {-step, step},
    {-step, -step},
  };
  fill(c2);
  for (int i = 0; i < 8; i++) {
    text(S, x+a[i][0]*3, y+a[i][1]*3);
  }
  for (int i = 0; i < 8; i++) {
    text(S, x+a[i][0]*2, y+a[i][1]*2);
  }
  fill(c2);
  for (int i = 0; i < 8; i++) {
    text(S, x+a[i][0], y+a[i][1]);
  }
  fill(c1);
  text(S, x, y);
}
