
class Witch extends Boss {
  Witch(float x, float y, Battle main) {
    super(x, y, main);
    ene = loadImage("E.png");
    wave = 0;
  }
  PImage ene;
  int pre_wave = -1;
  ArrayList<orderBeam>O_Beam = new ArrayList();
  void move() {
    if (pre_wave != wave) {
      O_Beam.clear();
      bai[0] = 1.4;
      bai[1] = 1.4;
      bai[2] = 1.0;
      this.HP = this.HP_Max = 300;
      if (wave == 5) {
        bai[0] = 0;
        bai[1] = 0;
        bai[2] = 0;
        this.HP = this.HP_Max = 1500;
        O_Beam.add(new orderBeam(x, y, 30, 0, 1, new MWitchBeam1(70)));
        O_Beam.add(new orderBeam(x, y, 30, 0, 1, new MWitchBeam1(70)));
        main.B_list.add(O_Beam.get(0));
        main.B_list.add(O_Beam.get(1));
      }
      if (wave == 6) {
        //O_Beam.add(new orderBeam(0, 0, 30, 0, 1, new MWitchBeam1(70)));
        //O_Beam.add(new orderBeam(1760, 0, 30, 0, 1, new MWitchBeam1(120)));
        //main.B_list.add(O_Beam.get(0));
        //main.B_list.add(O_Beam.get(1));
        bai[0] = 0.8;
        bai[1] = 1.1;
        bai[2] = 0.6;
        xl[0] = 1760/2;
        xl[1] = 1760-20;
        xl[2] = 1;
        xl[3] = 1;
        this.HP = this.HP_Max = 300;
      }
      if (wave == 7) {
        bai[0] = 0;
        bai[1] = 0;
        bai[2] = 0;
        this.HP = this.HP_Max = 600;
      }
      if (wave == 8) {
        bai[0] = 0;
        bai[1] = 0;
        bai[2] = 0;
        this.HP = 0;
      }
      red_HP = pre_HP = this.HP;
      pre_HP_time = 0;
      pre_HP_flag = false;
      pre_wave = wave;
    }
    if (del_time > 64) {
      delete = true;
    }
    attack();
    walk();
  }
  void attack() {
    float theta = atan2(main.P.y-y, main.P.x-x);
    if (wave == 0) {
      if (time % 210 <= 25 && time % 5 == 0) {
        BOSS[3].pause();
        BOSS[3].play(0);
        for (int i = 0; i < 360; i+= 36) {
          main.eT_list.add(new LinerShot1(x, y+25, 18, theta+radians(i+time*4), 1, new MWitchTama1(18)));
          main.eT_list.add(new LinerShot1(x, y+25, 12, theta+radians(i+18+time*4), 1, new MWitchTama2(18)));
        }
      }
      if (30 <= time % 240&&time % 240<=70) {
        if (30 <= time % 240&&time % 240<=40)at_ac.add(new PVector(3*cos(theta+radians(210)), 3*sin(theta+radians(210))));
        if (time % 30 == 0) {
          BOSS[5].pause();
          BOSS[5].play(0);
        }
        if (time % 30 == 10) {
          BOSS[6].pause();
          BOSS[6].play(0);
        }
        if (time % 30 == 20) {
          BOSS[7].pause();
          BOSS[7].play(0);
        }
        if (time % 5 == 0) {
          float d = radians((time % 240-30)*3-60);
          main.eT_list.add(new LinerShot1(x, y+25, 18, theta+d, 1, new MWitchTama3(32)));
          main.eT_list.add(new LinerShot1(x, y+25, 21, theta+d, 1, new MWitchTama3(32)));
          main.eT_list.add(new LinerShot1(x, y+25, 24, theta+d, 1, new MWitchTama3(32)));
          main.eT_list.add(new LinerShot1(x, y+25, 27, theta+d, 1, new MWitchTama3(32)));
        }
      }
      if (110 <= time % 240&&time % 240<=150) {
        if (110 <= time % 240&&time % 240<=120)at_ac.add(new PVector(3*cos(theta+radians(150)), 3*sin(theta+radians(150))));
        if (time % 30 == 0) {
          BOSS[5].pause();
          BOSS[5].play(0);
        }
        if (time % 30 == 10) {
          BOSS[6].pause();
          BOSS[6].play(0);
        }
        if (time % 30 == 20) {
          BOSS[7].pause();
          BOSS[7].play(0);
        }
        if (time % 5 == 0) {
          float d = radians((time % 240-110)*3-60);
          main.eT_list.add(new LinerShot1(x, y+25, 18, theta-d, 1, new MWitchTama3(32)));
          main.eT_list.add(new LinerShot1(x, y+25, 21, theta-d, 1, new MWitchTama3(32)));
          main.eT_list.add(new LinerShot1(x, y+25, 24, theta-d, 1, new MWitchTama3(32)));
          main.eT_list.add(new LinerShot1(x, y+25, 27, theta-d, 1, new MWitchTama3(32)));
        }
      }
    } else if (wave == 1) {
      if (time % 45 == 0) {
        BOSS[1].pause();
        BOSS[1].play(0);
        main.eT_list.add(new LinerShot1(x, y, 18, theta+radians(30), 1, new MWitchTama4(25)));
        main.eT_list.add(new LinerShot1(x, y, 18, theta+radians(15), 1, new MWitchTama4(25)));
        main.eT_list.add(new LinerShot1(x, y, 18, theta, 1, new MWitchTama4(25)));
        main.eT_list.add(new LinerShot1(x, y, 18, theta+radians(-15), 1, new MWitchTama4(25)));
        main.eT_list.add(new LinerShot1(x, y, 18, theta+radians(-30), 1, new MWitchTama4(25)));
      }
      if (time % 200 == 10) {
        BOSS[4].pause();
        BOSS[4].play(0);
        for (int i = 0; i < 360; i += 45) {
          main.eT_list.add(new AclShot1(x, y, 12, theta+radians(i+180), 1, new MWitchTama5(20), 0.5, theta+radians(i+30)));
        }
        for (int i = 0; i < 360; i += 45) {
          main.eT_list.add(new AclShot1(x, y, 12, theta+radians(i+180), 1, new MWitchTama5(20), 0.5, theta+radians(i-30)));
        }
      }
      if (time % 200 == 110) {
        BOSS[3].pause();
        BOSS[3].play(0);
        for (int i = 0; i < 360; i += 45) {
          main.eT_list.add(new AclShot1(x, y, 15, theta+radians(i+180), 1, new MWitchTama3(25), 0.3, theta+radians(i+5)));
        }
        for (int i = 0; i < 360; i += 45) {
          main.eT_list.add(new AclShot1(x, y, 15, theta+radians(i+180), 1, new MWitchTama3(25), 0.3, theta+radians(i-5)));
        }
      }
    } else if (wave == 2) {
      if (time % 120 == 0) {
        if (time % 240 == 0)at_ac.add(new PVector(20*cos(theta+radians(45)), 20*sin(theta+radians(45))));
        if (time % 240 == 120)at_ac.add(new PVector(20*cos(theta+radians(-45)), 20*sin(theta+radians(-45))));
        BOSS[2].pause();
        BOSS[2].play(0);
        main.B_list.add(new LinerBeam1(x, y, 30, theta+radians(50), 1, new MWitchBeam1(40), 5));
        main.B_list.add(new LinerBeam1(x, y, 30, theta+radians(25), 1, new MWitchBeam1(40), 5));
        main.B_list.add(new LinerBeam1(x, y, 36, theta, 1, new MWitchBeam1(45), 10));
        main.B_list.add(new LinerBeam1(x, y, 30, theta+radians(-25), 1, new MWitchBeam1(40), 5));
        main.B_list.add(new LinerBeam1(x, y, 30, theta+radians(-50), 1, new MWitchBeam1(40), 5));
      }
      if ((time) % 60 <= 9) {
        if (!flag[0]) {
          BOSS[4].pause();
          BOSS[4].play(0);
        }
        data_flag(0, theta);
        if (time % 3 == 0) {
          for (int i = 0; i < 360; i += 45) {
            main.eT_list.add(new AclShot2(xl[0], yl[0], 12, radian[0]+radians(i-45), 1, new MWitchTama6(30), 0.25, radian[0]+radians(i+200 + ((time) % 60)*2)));
          }
        }
      } else {
        flag[0] = false;
      }
      if (time % 45 <= 12 && time % 4 == 0) {
        data_flag(1, theta);
        BOSS[3].pause();
        BOSS[3].play(0);
        for (int i = 0; i < 360; i += 24) {
          main.eT_list.add(new AclShot2(xl[1], yl[1], 20, radian[1]+radians(i+45), 1, new MWitchTama1(20), 0.5, radian[1]+radians(i+120)));
        }
      } else {
        flag[1] = false;
      }
    } else if (wave == 3) {
      if (time % 80 == 0) {
        radian[0] = theta;
        BOSS[4].pause();
        BOSS[4].play(0);
        for (int i = 0; i < 360; i += 24) {
          main.eT_list.add(new LinerShot1(x, y, 9, theta+radians(i), 1, new MWitchTama3(40)));
        }
      }
      if (24 <= time % 120 && time % 120 <= 48 && time % 2 == 0) {
        radian[0] += radians(12);
        if (time % 8 == 0) {
          BOSS[3].pause();
          BOSS[3].play(0);
        }
        for (int i = 0; i < 360; i += 48) {
          main.eT_list.add(new LinerShot1(x+30*cos(radian[0]), y+30*sin(radian[0]), 20, theta+radians(i)+radian[0], 1, new MWitchTama4(24)));
        }
        for (int i = 0; i < 360; i += 48) {
          main.eT_list.add(new LinerShot1(x+30*cos(radian[0]), y+30*sin(radian[0]), 28, theta+radians(i)-radian[0], 1, new MWitchTama6(18)));
        }
      }
      if (time % 120 == 45) {
        BOSS[0].pause();
        BOSS[0].play(0);
        main.B_list.add(new SetBeam1(x, y, 30, theta, 1, new MWitchBeam2(70), 40, 9, 15, 10));
      } else if (time % 120 == 0) {
        at_ac.add(new PVector(30*cos(theta+radians(30)), 30*sin(theta+radians(30))));
      }
    } else if (wave == 4) {
      if (time % 40 == 0) {
        BOSS[1].pause();
        BOSS[1].play(0);
        for (int i = 0; i < 360; i += 60) {
          for (int j = 0; j < 360; j += 45) {
            main.eT_list.add(new LinerWaveMoveShot1(x+45*cos(radians(j)), y+45*sin(radians(j)), 12, theta+radians(i), 1, new MWitchTama3(30), 40, radians(j), radians(4)));
          }
        }
      }
      if (time % 80 == 0) {
        BOSS[4].pause();
        BOSS[4].play(0);
        for (int j = 0; j < 360; j += 45) {
          main.eT_list.add(new OrderOpenMoveShot1(x, y, 4, theta, 1, new MWitchTama2(40), 300, radians(j), 40, 300, radians(2), 60, 40, main));
        }
      }
      if (time % 20 == 0) {
        BOSS[3].pause();
        BOSS[3].play(0);
        for (int i = 0; i < 360; i += 60) {
          main.eT_list.add(new ChangeSpeedMoveShot1(x, y, 20, theta+radians(i), 1, new MWitchTama5(25), 20, theta+radians(i+15), 30, 10));
          main.eT_list.add(new ChangeSpeedMoveShot1(x, y, 20, theta+radians(i), 1, new MWitchTama5(25), 20, theta+radians(i-15), 30, 10));
        }
      }
    } else if (wave == 5) {
      float T = pow(sin(radians(frameCount*3)), 1);
      O_Beam.get(0).processBeam(x + 100*T, 30, x + 300*T, 2000 );
      O_Beam.get(1).processBeam(x - 100*T, 30, x - 300*T, 2000 );
      radian[0] = radians(30)*T;
      if (time % 40 == 0) {
        BOSS[0].pause();
        BOSS[0].play(0);
        for (int i = 0; i < 360; i += 30) {
          main.eT_list.add(new AutoShot(x, y, 30, theta+radians(i), 1, new MWitchTama5(35), main.P.x, main.P.y, 8, 45, 60));
        }
      }
      if (time % 40 == 0) {
        for (int i = 0; i < 360; i += 30) {
          main.eT_list.add(new AutoShot(x, y, 20, theta+radians(i), 1, new MWitchTama7(25), main.P.x-100, main.P.y+60, 3, 25, 45));
        }
      }
      if (time % 40 == 0) {
        for (int i = 0; i < 360; i += 30) {
          main.eT_list.add(new AutoShot(x, y, 20, theta+radians(i), 1, new MWitchTama7(25), main.P.x-100, main.P.y-60, 3, 25, 45));
        }
      }
      if (time % 8 == 0) {
        BOSS[3].pause();
        BOSS[3].play(0);
        for (int i = 0; i < 360; i += 20) {
          main.eT_list.add(new LinerShot1(x, y, 12, theta+radians(i)+radian[0], 1, new MWitchTama3(20)));
        }
      }
      if (time % 8 == 4) {
        for (int i = 0; i < 360; i += 20) {
          main.eT_list.add(new LinerShot1(x, y, 12, theta+radians(i+10)+radian[0], 1, new MWitchTama3(12)));
        }
      }
    } else if (wave == 6) {
      if (60 <= time % 300&&time % 300<=100) {
        if (80 <= time % 300&&time % 300<=90)at_ac.add(new PVector(3*cos(theta+radians(150)), 3*sin(theta+radians(150))));
        if (time % 5 == 0) {
          BOSS[3].pause();
          BOSS[3].play(0);
          float d = radians((time % 300 - 80)*3);
          for (int i = 0; i < 360; i+= 36) {
            main.eT_list.add(new LinerShot1(x, y+25, 22, theta-d+radians(i), 1, new MWitchTama3(16)));
            main.eT_list.add(new LinerShot1(x, y+25, 26, theta-d+radians(i), 1, new MWitchTama3(16)));
            main.eT_list.add(new LinerShot1(x, y+25, 30, theta-d+radians(i), 1, new MWitchTama3(16)));
            main.eT_list.add(new LinerShot1(x, y+25, 34, theta-d+radians(i), 1, new MWitchTama3(16)));
          }
        }
      }
      if ((10<=time % 300 && time % 300 <= 70) || (120<=time % 300 && time % 300 <= 180)) {
        if (time % 10 == 0) {
          BOSS[2].pause();
          BOSS[2].play(0);
          main.B_list.add(new LinerBeam1(x, y, 30, theta+radians(60), 1, new MWitchBeam1(30), 4));
          main.B_list.add(new LinerBeam1(x, y, 30, theta+radians(30), 1, new MWitchBeam1(30), 4));
          main.B_list.add(new LinerBeam1(x, y, 30, theta, 1, new MWitchBeam1(30), 4));
          main.B_list.add(new LinerBeam1(x, y, 30, theta+radians(-30), 1, new MWitchBeam1(30), 4));
          main.B_list.add(new LinerBeam1(x, y, 30, theta+radians(-60), 1, new MWitchBeam1(30), 4));
        }
      }
      if (180 <= time % 300 && time % 300 <= 240 && time % 6 == 0) {
        radian[0] += radians(24);
        BOSS[1].pause();
        BOSS[1].play(0);
        for (int i = 0; i < 360; i += 36) {
          main.eT_list.add(new AclShot1(x+30*cos(radian[0]), y+30*sin(radian[0]), 20, theta+radians(i+180)+radian[0], 1, new MWitchTama4(24), 0.5, theta+radians(i+2)+radian[0]));
        }
        for (int i = 0; i < 360; i += 36) {
          main.eT_list.add(new AclShot1(x+30*cos(radian[0]), y+30*sin(radian[0]), 0, theta+radians(i)+radian[0], 1, new MWitchTama6(24), 0.5, theta+radians(i-2)+radian[0]));
        }
      }
    } else if (wave == 7) {
      if (time % 120 == 0) {
        at_ac.add(new PVector(30*cos(theta+radians(45)), 30*sin(theta+radians(45))));
      }
      if (time % 120 == 45) {
        BOSS[0].pause();
        BOSS[0].play(0);
        for (int i = 0; i < 360; i+= 45) {
          main.B_list.add(new SetBeam1(x, y, 30, theta+radians(i), 1, new MWitchBeam2(30), 40, 9, 15, 10));
        }
      }

      if (60 <= time % 120 && time % 120 <= 90 && (time %120) % 10 == 0) {

        for (int i = 0; i < 360; i+= 45) {
          if (i % 90 == 0) {
            if (i == 0) {
              BOSS[2].pause();
              BOSS[2].play(0);
            }
            float theta2 = theta + radians(22.5+i);
            main.B_list.add(new LinerBeam1(x, y, 36, theta2, 1, new MWitchBeam1(45), 5));
            main.B_list.add(new LinerBeam1(x, y, 30, theta2+radians(10), 1, new MWitchBeam1(30), 6));
            main.B_list.add(new LinerBeam1(x, y, 30, theta2+radians(-10), 1, new MWitchBeam1(30), 6));
          } else {
            if (i == 45) {
              BOSS[1].pause();
              BOSS[1].play(0);
            }
            float theta2 = theta + radians(22.5+i);
            for (int j = 0; j < 360; j += 45) {
              main.eT_list.add(new LinerShot1(x+80*cos(radians(j)), y+80*sin(radians(j)), 16, theta2, 1, new MWitchTama3(20)));
              main.eT_list.add(new LinerShot1(x+60*cos(radians(j)), y+60*sin(radians(j)), 12, theta2+radians(20), 1, new MWitchTama3(20)));
              main.eT_list.add(new LinerShot1(x+60*cos(radians(j)), y+60*sin(radians(j)), 12, theta2+radians(-20), 1, new MWitchTama3(20)));
            }
          }
        }
      }

      if (time % 240 <= 120 && (time%240) % 30 == 0) {
        BOSS[1].pause();
        BOSS[1].play(0);
        if (time%240 == 0)radian[0] = theta;
        for (int i = 0; i < 360; i+= 60) {
          float theta2 = radian[0] + radians(i+90);
          if ((time%240)%60 == 0)theta2 += radians(30);
          for (int j = 0; j < 5; j++) {
            main.eT_list.add(new LinerShot1(x+(j-2)*120*cos(theta2), y+(j-2)*120*sin(theta2), 12, theta2+radians(-90), 1, new MWitchTama6(40)));
          }
        }
      }
    }
    if (wave == 8) {
      del_time++;
    }
  }
  boolean delete = false;
  void display() {
    fill(255, 255, 255, 200-max(del_time, 0)*4);
    ellipse(x, y, R*2+15*sin(radians(frameCount*2)), R*2+15*sin(radians(frameCount*2)));
    fill(255, 255, 255, 80-max(del_time, 0)*4);
    ellipse(x, y, R*7+20*sin(radians(frameCount*2)), R*7+20*sin(radians(frameCount*2)));
    translate(x, y);
    tint(255, 255, 255, 255-max(del_time, 0)*4);
    if (x > main.P.x) {
      image(ene, -120, -100, 200, 200);
    } else {
      scale(-1, 1);
      image(ene, -120, -100, 200, 200);
      scale(-1, 1);
    }

    translate(-x, -y);
  }
}
abstract class Boss {
  float x, y;
  float rad, sp;
  float R = 40;
  float HP;
  float HP_Max;
  float pre_HP = 0;
  float red_HP = 0;
  PVector v = new PVector(0, 0);
  int del_time = -60;
  int wave = 0;
  int time = 0;
  Battle main;
  float bai[] = {1, 0.75, 0.5};
  float radian[] = new float[10];
  float xl[] = new float[10];
  float yl[] = new float[10];
  boolean flag[] = new boolean[10];
  boolean pre_HP_flag = false;
  int pre_HP_time = 0;
  float stack_HP = 0;
  Boss(float x, float y, Battle main) {
    red_HP = pre_HP = HP = HP_Max = 250;
    this.x = x;
    this.y = y;
    this.main = main;
    for (int i = 0; i < 10; i++) {
      radian[i] = 0;
      xl[i] = 0;
      yl[i] = 0;
      flag[i] = false;
    }
  }
  PVector at_ac = new PVector(0, 0);
  void stop_boss() {
    v.mult(0);
    for (int i = 0; i < 10; i++) {
      radian[i] = 0;
    }
  }
  void walk() {
    PVector ac = new PVector(0, 0);
    float theta = atan2(main.P.y-y, main.P.x-x);
    float rad = atan2(MY-main.P.y, MX-main.P.x);
    if (dist(main.P.x, main.P.y, x, y) > 350) {  //プレイヤー参照で加速度決め
      float d = map(dist(main.P.x, main.P.y, x, y), 350, dist(0, 0, 1760, 990), 0.05, 3.5);
      ac.x += d*cos(theta)*bai[0];
      ac.y += d*sin(theta)*bai[0];
    } else if (dist(main.P.x, main.P.y, x, y) < 200) {
      float d = sq(map(dist(main.P.x, main.P.y, x, y), R, 200, 0.5, 0));
      ac.x += d*cos(theta+PI)*bai[0];
      ac.y += d*sin(theta+PI)*bai[0];
    } else {
      float d = 0.05;
      ac.x += d*cos(theta+PI/2)*bai[0];
      ac.y += d*sin(theta+PI/2)*bai[0];
    }
    float line_d = line_dist(x, y, main.P.x, main.P.y, main.P.x+cos(rad)*600, main.P.y+sin(rad)*600);//射線参照で加速度決め
    if (line_d < 300) {
      float d = map(line_d, 0, 300, 0.8, 0);
      if (line_dist(x+line_d*0.1*cos(rad+PI/2), y+line_d*0.1*sin(rad+PI/2), main.P.x, main.P.y, main.P.x+cos(rad)*600, main.P.y+sin(rad)*600)<line_dist(x+line_d*0.1*cos(rad-PI/2), y+line_d*0.1*sin(rad-PI/2), main.P.x, main.P.y, main.P.x+cos(rad)*600, main.P.y+sin(rad)*600)) {
        ac.x += d * cos(rad-PI/2)*bai[1];
        ac.y += d * sin(rad-PI/2)*bai[1];
      } else {
        ac.x += d * cos(rad+PI/2)*bai[1];
        ac.y += d * sin(rad+PI/2)*bai[1];
      }
    }

    PVector m = new PVector(0, 0);
    int n = 0;
    for (int i = 0; i < main.T_list.size(); i++) {
      float rad1 = atan2(main.T_list.get(i).v.y, main.T_list.get(i).v.x);
      float B = main.T_list.get(i).y-tan(rad1)*main.T_list.get(i).x;
      if (dis_l(-tan(rad1), 1, -B, x, y) < main.T_list.get(i).body.R+10 + 75) {
        float d = map(dis_l(-tan(rad1), 1, -B, x, y), 0, main.T_list.get(i).body.R+10 + 75, main.T_list.get(i).body.R/5.0, 0);
        float rad2 = atan2(y-main.T_list.get(i).y, x-main.T_list.get(i).x);
        float rad0 = rad2-rad1;
        float Rad = 0;

        if (rad0 < 0) {
          Rad = rad1 - radians(90);
        } else {
          Rad = rad1 + radians(90);
        }

        if (dis_l(-tan(rad1), 1, -B, x, y)>main.T_list.get(i).body.R+10+75)d = 0;
        if ((x- main.T_list.get(i).x)*main.T_list.get(i).v.x + (y-main.T_list.get(i).y)*main.T_list.get(i).v.y > 0) {
          n++;
          m.x += d*cos(Rad);
          m.y += d*sin(Rad);
          //t.get(i).condition = 1;
        } else {
          //t.get(i).condition = 0;
        }
      } else {
        //t.get(i).condition = 0;
      }
    }
    if (n!=0) {
      m.mult(1.0/n);
      v.x += m.x*bai[2];
      v.y += m.y*bai[2];
    }


    if (line_dist(x, y, main.BW_Min, main.BH_Min, main.BW_Min, main.BH_Max) < 400) {
      v.x += 2.5*(100/line_dist(x, y, main.BW_Min, main.BH_Min, main.BW_Min, main.BH_Max));
    }
    if (line_dist(x, y, main.BW_Max, main.BH_Min, main.BW_Max, main.BH_Max) < 400) {
      v.x -= 2.5*(100/line_dist(x, y, main.BW_Max, main.BH_Min, main.BW_Max, main.BH_Max));
    }
    if (line_dist(x, y, main.BW_Min, main.BH_Min, main.BW_Max, main.BH_Min) < 400) {
      v.y += 2.5*(100/line_dist(x, y, main.BW_Min, main.BH_Min, main.BW_Max, main.BH_Min));
    }
    if (line_dist(x, y, main.BW_Min, main.BH_Max, main.BW_Max, main.BH_Max) < 400) {
      v.y -= 2.5*(100/line_dist(x, y, main.BW_Min, main.BH_Max, main.BW_Max, main.BH_Max));
    }
    v.add(ac.add(at_ac));
    x += v.x;
    y += v.y;
    if (x < main.BW_Min+R) {
      x = main.BW_Min+R;
      v.x *= -1;
    }
    if (x > main.BW_Max - R) {
      x = main.BW_Max - R;
      v.x *= -1;
    }
    if (y < main.BH_Min+R) {
      y = main.BH_Min+R;
      v.y *= -1;
    }
    if (y > main.BH_Max - R) {
      y = main.BH_Max - R;
      v.y *= -1;
    }
    v.mult(0.94);
    at_ac.mult(0);
  }
  boolean battle = false;
  void process_Boss() {
    if (!pre_HP_flag) {
      if (pre_HP_time > 0) {
        pre_HP_time--;
        if (pre_HP_time == 0) {
          pre_HP_flag = true;
          pre_HP_time = 60;
        }
      }
    } else {
      if (pre_HP_time > 0) {
        pre_HP_time--;
        red_HP = HP*(1-pre_HP_time/60.0) + stack_HP*(pre_HP_time/60.0);
        if (pre_HP_time == 0) {
          pre_HP_flag = false;
          pre_HP_time = 0;
        }
      }
    }
    if (pre_HP != HP) {
      if (pre_HP_time == 0 && !pre_HP_flag) {
        stack_HP = pre_HP;
        pre_HP_time = 60;
      }
      pre_HP = HP;
    }



    time ++;
    if (time < 0) {
      battle = false;
    } else if (time == 0) {
      battle = true;
    }
    if (HP < 0 && battle) {
      main.stop_battle();
      beat.pause();
      beat.play(0);
      wave ++;
    }
    if (battle)move();
    for (int i = 0; i < main.T_list.size(); i++) {
      if (main.T_list.get(i).hitTama(x, y, R)&&wave < 8) {
        if (battle) {
          HP -= main.T_list.get(i).at;
          hit.pause();
          hit.play(0);
        }
        main.T_list.get(i).delete = true;
      }
    }
  }
  void data_flag(int index, float theta) {
    if (!flag[index]) {
      radian[index] = theta;
      xl[index] = x;
      yl[index] = y;
      flag[index] = true;
    }
  }
  void start_battle() {
    time = 0;
    battle = true;
  }
  abstract void move();
  abstract void display();
}
