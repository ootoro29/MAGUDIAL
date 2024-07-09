class MWitchBeam1 extends BeamMaterial {
  MWitchBeam1(float W) {
    super(W);
  }
  void display(float x, float y, float X, float Y, int alf) {
    stroke(255, 255, 0, 200+alf);
    strokeWeight(W);
    line(x, y, X, Y);
  }
}
class MWitchBeam2 extends BeamMaterial {
  MWitchBeam2(float W) {
    super(W);
  }
  void display(float x, float y, float X, float Y, int alf) {
    if (W <= 0) {
      stroke(255, 0, 0, 200+alf);
      strokeWeight(3);
      line(x, y, X, Y);
      stroke(255, 0, 0, 110+alf);
      strokeWeight(List[0]);
      line(x, y, X, Y);
    } else {
      stroke(255, 190, 0, 200+alf);
      strokeWeight(W);
      line(x, y, X, Y);
    }
  }
}
class LinerBeam1 extends Beam {
  int time = 0;
  int time_L = 0;
  LinerBeam1(float x, float y, float sp, float rad, float at, BeamMaterial body, int time_L) {
    super(x, y, sp, rad, at, body);
    this.time_L = time_L;
  }
  void processBeam() {
    x += v.x;
    y += v.y;
    if (time > time_L) {
      X += v.x;
      Y += v.y;
    }
    time++;
  }
}
class SetBeam1 extends Beam {
  int time = 0;
  int time_L = 0;
  int time_L2 = 0;
  int time_L3 = 0;
  float w_sp = 0;
  SetBeam1(float x, float y, float sp, float rad, float at, BeamMaterial body, int time_L, float w_sp, int time_L2, int time_L3) {
    super(x, y, sp, rad, at, body);
    this.time_L = time_L;
    this.w_sp = w_sp;
    this.time_L2 = time_L2;
    this.time_L3 = time_L3;
    body.W = 0;
    X = 2000*cos(rad)+x;
    Y = 2000*sin(rad)+y;
    body.List[0] = w_sp * time_L2;
  }
  void processBeam() {
    time++;
    if (time == time_L) {
      BOSS[5].pause();
      BOSS[5].play(0);
    }
    if (time_L <= time && time < time_L + time_L2) {
      body.W += w_sp;
    } else if (time >= time_L+time_L2+time_L3) {
      D = true;
    }
  }
}

class orderBeam extends Beam {
  orderBeam(float x, float y, float sp, float rad, float at, BeamMaterial body) {
    super(x, y, sp, rad, at, body);
  }
  void processBeam(float x, float y, float X, float Y) {
    this.x = x;
    this.y = y;
    this.X = X;
    this.Y = Y;
  }
  void processBeam() {
  }
}

abstract class Beam {
  float x, y;
  float X, Y;
  float sp, rad;
  PVector v = new PVector(0, 0);
  boolean delete = false;
  float at;
  boolean move = true;
  int del_time = 0;
  int alf = 0;
  boolean D = false;
  BeamMaterial body;
  Beam(float x, float y, float sp, float rad, float at, BeamMaterial body) {
    this.x = x;
    this.y = y;
    X = x;
    Y = y;
    this.at = at;
    this.sp = sp;
    this.rad = rad;
    this.body = body;
    v.x =  sp*cos(rad);
    v.y =  sp*sin(rad);
  }
  void doBeam() {
    alf = 0;
    if (D) {
      move = false;
      del_time++;
      if (del_time > 60)delete = true;
      alf -= del_time*4;
    }
    if (move)processBeam();
    if ((x < -100 || x > 1760 + 100 || y < -100 || y > 990 + 100)&&(X < -100 || X > 1760 + 100 || Y < -100 || Y > 990 + 100))delete = true;
  }
  abstract void processBeam();
  void displayBeam() {
    body.display(x, y, X, Y, alf);
  }
  void moveStop() {
    D = true;
  }
  boolean hitBeam(float px, float py, float R) {
    if (body.W <= 0)return false;
    return line_dist(px, py, x, y, X, Y) < R + body.W/2;
  }
}
abstract class BeamMaterial {
  float W;
  float List[] = new float[10];
  BeamMaterial(float W) {
    this.W = W;
  }
  abstract void display(float x, float y, float X, float Y, int alf);
}
