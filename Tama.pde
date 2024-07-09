class LinerShot1 extends Tama {
  LinerShot1(float x, float y, float sp, float rad, float at, TamaMaterial body) {
    super(x, y, sp, rad, at, body);
  }
  void processTama() {
    x += v.x;
    y += v.y;
  }
}
class AclShot1 extends Tama {
  PVector Ac = new PVector(0, 0);
  AclShot1(float x, float y, float sp, float rad, float at, TamaMaterial body, float ac, float rad_ac) {
    super(x, y, sp, rad, at, body);
    Ac.x = ac*cos(rad_ac);
    Ac.y = ac*sin(rad_ac);
  }
  void processTama() {
    v.x += Ac.x;
    v.y += Ac.y;
    x += v.x;
    y += v.y;
  }
}
class AclShot2 extends Tama {
  PVector Ac = new PVector(0, 0);
  float sp0;
  AclShot2(float x, float y, float sp, float rad, float at, TamaMaterial body, float ac, float rad_ac) {
    super(x, y, sp, rad, at, body);
    Ac.x = ac*cos(rad_ac);
    Ac.y = ac*sin(rad_ac);
    sp0 = sp;
  }
  void processTama() {
    v.x += Ac.x;
    v.y += Ac.y;
    v.setMag(sp0);
    x += v.x;
    y += v.y;
  }
}
class LinerWaveMoveShot1 extends Tama {
  float L;
  float rad_s;
  float Rad;
  float k;
  float X, Y;
  LinerWaveMoveShot1(float x, float y, float sp, float rad, float at, TamaMaterial body, float L, float Rad, float rad_s) {
    super(x, y, sp, rad, at, body);
    X = x;
    Y = y;
    this.L = L;
    this.rad_s = rad_s;
    this.Rad = Rad;
  }
  void processTama() {
    X += v.x;
    Y += v.y;
    k += rad_s;
    x = X + (L)*cos(Rad)*(sin(k)+1);
    y = Y + (L)*sin(Rad)*(sin(k)+1);
  }
}
class ChangeSpeedMoveShot1 extends Tama {
  float L;
  float rad_s;
  float Rad;
  float k;
  float X, Y;
  PVector change_speed ;
  int lim_time = 0;
  double alpha = 0;
  int change_time = 0;
  ChangeSpeedMoveShot1(float x, float y, float sp, float rad, float at, TamaMaterial body, float sp2, float rad2, int lim_time, int change_time) {
    super(x, y, sp, rad, at, body);
    X = x;
    Y = y;

    change_speed = new PVector(sp2*cos(rad2), sp2*sin(rad2));
    this.lim_time = lim_time;
    this.change_time = change_time;
  }
  void processTama() {
    x += change_speed.x * alpha + v.x * (1-alpha);
    y += change_speed.y * alpha + v.y * (1-alpha);
    if (time >= lim_time) {
      alpha = min((time - lim_time)/(change_time), 1);
    }
  }
}
class LinerOpenMoveShot1 extends Tama {
  float L;
  float l = 0;
  int lim_time = 0;
  int time2 = 0;
  float Rad;
  float rad_s;
  float k;
  float X, Y;
  float D;
  Battle main;
  LinerOpenMoveShot1(float x, float y, float sp, float rad, float at, TamaMaterial body, float L, float Rad, int lim_time, float D, float rad_s, Battle main) {
    super(x, y, sp, rad, at, body);
    X = x;
    Y = y;
    this.L = L;
    this.lim_time = lim_time;
    this.Rad = Rad;
    this.main = main;
    this.D = D;
    this.rad_s = rad_s;
  }
  void processTama() {
    X += v.x;
    Y += v.y;
    Rad += rad_s;
    x = X + (L)*cos(Rad)*(sin(PI/2.0*(float(time2)/lim_time)));
    y = Y + (L)*sin(Rad)*(sin(PI/2.0*(float(time2)/lim_time)));

    if (dist(X, Y, main.P.x, main.P.y) < D) {
      time2 ++;
    } else {
      time2 --;
    }
    time2 = min(time2, lim_time);
    time2 = max(time2, 0);
  }
}
class OrderOpenMoveShot1 extends Tama {
  float L;
  float l = 0;
  int lim_time = 0;
  int order_time = 0;
  int order_time2 = 0;
  int time2 = 0;
  float Rad;
  float rad_s;
  float k;
  float X, Y;
  float D;
  float alpha = 0;
  Battle main;
  OrderOpenMoveShot1(float x, float y, float sp, float rad, float at, TamaMaterial body, float L, float Rad, int lim_time, float D, float rad_s, int order_time, int order_time2, Battle main) {
    super(x, y, sp, rad, at, body);
    X = x;
    Y = y;
    this.L = L;
    this.lim_time = lim_time;
    this.Rad = Rad;
    this.main = main;
    this.D = D;
    this.rad_s = rad_s;
    this.order_time = order_time;
    this.order_time2 = order_time2;
  }
  void processTama() {
    PVector Order = new PVector(main.P.x-X, main.P.y-Y);
    v.x += Order.x*alpha;
    v.y += Order.y*alpha;
    v.setMag(sp);
    X += v.x;
    Y += v.y;
    Rad += rad_s;
    x = X + (L)*cos(Rad)*(sin(PI/2.0*(float(time2)/lim_time)));
    y = Y + (L)*sin(Rad)*(sin(PI/2.0*(float(time2)/lim_time)));

    if (dist(X, Y, main.P.x, main.P.y) < D) {
      if (time2 == 0) {
        BOSS[0].pause();
        BOSS[0].play(0);
      }
      time2 ++;
    } else {
      time2 --;
    }
    time2 = min(time2, lim_time);
    time2 = max(time2, 0);
    if (time < order_time) {
      alpha = 1;
    } else if (time < order_time2 + order_time) {
      alpha = 1 - ((time-order_time) / order_time2);
    } else {
      alpha = 0;
    }
  }
}
class AutoShot extends Tama {
  float X, Y;
  float sp0;
  int time1, time2;
  AutoShot(float x, float y, float sp, float rad, float at, TamaMaterial body, float X, float Y, float sp0, int time1, int time2) {
    super(x, y, sp, rad, at, body);
    this.X = X;
    this.Y = Y;
    this.sp0 = sp0;
    this.time1 = time1;
    this.time2 = time2;
  }
  void processTama() {
    float theta = atan2(Y-y, X-x);
    if (time <= time1) {
      v.x += sp0*cos(theta);
      v.y += sp0*sin(theta);
    } else if (time <= time1 + time2) {
      v.x += sp0*cos(theta) * (1-((float)(time-time1)/time2));
      v.y += sp0*sin(theta) * (1-((float)(time-time1)/time2));
    }
    v.setMag(sp);
    x += v.x;
    y += v.y;
  }
}
class AclWaitShot1 extends Tama {
  PVector Ac = new PVector(0, 0);
  int wait_time = 0;
  AclWaitShot1(float x, float y, float sp, float rad, float at, TamaMaterial body, float ac, float rad_ac, int wait_time) {
    super(x, y, sp, rad, at, body);
    Ac.x = ac*cos(rad_ac);
    Ac.y = ac*sin(rad_ac);
    this.wait_time = wait_time;
  }
  void processTama() {
    if (time >= wait_time) {
      v.x += Ac.x;
      v.y += Ac.y;
      x += v.x;
      y += v.y;
    }
  }
}
class MPlayerTama1 extends TamaMaterial {
  MPlayerTama1(float R) {
    super(R);
  }
  void display(float x, float y, int alf) {
    noStroke();
    fill(30, 255, 100, 100+alf);
    ellipse(x, y, R*2, R*2);
    fill(160, 255, 20, 50+alf);
    ellipse(x, y, R*1.25, R*1.25);
  }
}
class MPlayerTama2 extends TamaMaterial {
  MPlayerTama2(float R) {
    super(R);
  }
  void display(float x, float y, int alf) {
    noStroke();
    fill(20, 240, 255, 100+alf);
    ellipse(x, y, R*2, R*2);
    fill(100, 180, 240, 50+alf);
    ellipse(x, y, R*1.25, R*1.25);
  }
}
class MWitchTama5 extends TamaMaterial {
  MWitchTama5(float R) {
    super(R);
  }
  void display(float x, float y, int alf) {
    noStroke();
    fill(#1D70F2, 200+alf);
    ellipse(x, y, R*2, R*2);
    fill(#FEFFC9, 120+alf);
    ellipse(x, y, R*1.25, R*1.25);
  }
}
class MWitchTama6 extends TamaMaterial {
  MWitchTama6(float R) {
    super(R);
  }
  void display(float x, float y, int alf) {
    noStroke();
    fill(#DB19FA, 200+alf);
    ellipse(x, y, R*2, R*2);
    fill(#B0FCE9, 120+alf);
    ellipse(x, y, R*1.25, R*1.25);
  }
}
class MWitchTama7 extends TamaMaterial {
  MWitchTama7(float R) {
    super(R);
  }
  void display(float x, float y, int alf) {
    noStroke();
    fill(#FC9F12, 200+alf);
    ellipse(x, y, R*2, R*2);
    fill(#FFC6C6, 120+alf);
    ellipse(x, y, R*1.25, R*1.25);
  }
}
class MWitchTama4 extends TamaMaterial {
  MWitchTama4(float R) {
    super(R);
  }
  void display(float x, float y, int alf) {
    noStroke();
    fill(#28FA93, 200+alf);
    ellipse(x, y, R*2, R*2);
    fill(#EAFCFF, 120+alf);
    ellipse(x, y, R*1.25, R*1.25);
  }
}
class MWitchTama3 extends TamaMaterial {
  MWitchTama3(float R) {
    super(R);
  }
  void display(float x, float y, int alf) {
    noStroke();
    fill(#DE070E, 200+alf);
    ellipse(x, y, R*2, R*2);
    fill(#98E3FF, 120+alf);
    ellipse(x, y, R*1.25, R*1.25);
  }
}
class MWitchTama1 extends TamaMaterial {
  MWitchTama1(float R) {
    super(R);
  }
  void display(float x, float y, int alf) {
    noStroke();
    fill(180, 0, 130, 255+alf);
    ellipse(x, y, R*2, R*2);
    fill(255, 220, 30, 100+alf);
    ellipse(x, y, R*1, R*1);
  }
}
class MWitchTama2 extends TamaMaterial {
  MWitchTama2(float R) {
    super(R);
  }
  void display(float x, float y, int alf) {
    noStroke();
    fill(0, 180, 130, 255+alf);
    ellipse(x, y, R*2, R*2);
    fill(30, 220, 255, 100+alf);
    ellipse(x, y, R*1, R*1);
  }
}

abstract class Tama {
  float x, y;
  float sp, rad;
  PVector v = new PVector(0, 0);
  boolean delete = false;
  float at;
  boolean move = true;
  TamaMaterial body;
  int del_time = 0;
  int alf = 0;
  int time = 0;
  boolean D = false;
  Tama(float x, float y, float sp, float rad, float at, TamaMaterial body) {
    this.x = x;
    this.y = y;
    this.at = at;
    this.sp = sp;
    this.rad = rad;
    this.body = body;
    v.x =  sp*cos(rad);
    v.y =  sp*sin(rad);
  }
  void doTama() {
    alf = 0;
    time ++;
    if (D) {
      move = false;
      del_time++;
      if (del_time > 60)delete = true;
      alf -= del_time*4;
    }
    if (move)processTama();
    if (x < -100 || x > 1760 + 100 || y < -100 || y > 990 + 100)delete = true;
  }
  abstract void processTama();
  void displayTama() {
    body.display(x, y, alf);
  }
  void moveStop() {
    D = true;
  }
  boolean hitTama(Tama T) {
    return dist(x, y, T.x, T.y) <= body.R+T.body.R;
  }
  boolean hitTama(float x1, float y1, float R) {
    return dist(x, y, x1, y1) <= body.R+R;
  }
}

abstract class TamaMaterial {
  float R;
  TamaMaterial(float R) {
    this.R = R;
  }
  abstract void display(float x, float y, int alf);
}
