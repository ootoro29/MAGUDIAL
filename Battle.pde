class Battle extends Scene {
  Background B;
  Boss boss;
  float BW_Min = 0, BW_Max = 1760, BH_Min = 300, BH_Max = 990;
  Player P;
  PImage M;
  PImage E;
  boolean practice = false;
  Battle(boolean practice) {
    this.practice = practice;
    B = new background1(this);
    BW_Min = 0;
    BW_Max = 1760;
    BH_Min = 120;
    BH_Max = 990;
    boss = (new Witch(1600, abs(BH_Max+BH_Min)/2, this));
    P = new Player(this);
    if (practice) {
      boss.wave = 8;
      boss.del_time = 64;
      time = 0;
    } else {
      conv.add(new conv_text("…………！", 0));
      conv.add(new conv_text("やっと見つけた。あなたが魔女ね！", 0));
      conv.add(new conv_text("あっちゃ～。見つかっちゃった、、、", 1));
      conv.add(new conv_text("嫌なんだよなぁ～魔法少女に見つかると。\n……戦争とか起きちゃうし、、、", 1));
      conv.add(new conv_text("まあこういう生き方を決めたのは自分なんだし、しかたないよね。", 1));
      conv.add(new conv_text("お前がこの世界に来てから\n魔場は不安定になり魔獣も狂暴化した。", 0));
      conv.add(new conv_text("結果的にそうなるよね～", 1));
      conv.add(new conv_text("おまけに天使を自称する奴が世界を仕切りはじめたこともあった。", 0));
      conv.add(new conv_text("あー大変だったみたいだね。", 1));
      conv.add(new conv_text("他人事！！！", 0));
      conv.add(new conv_text("実際、他人事だしね。私はこの世界に遊びに来ただけ。\n確かにその影響でこの世界のルールは変わっちゃったけど、", 1));
      conv.add(new conv_text("あれから10年ちょっと。この世界の住人もその事実を受け入れ適応している。\n今では魔法を起因とする諸現象を日常として認識しているのがその証拠。", 1));
      conv.add(new conv_text("もういいじゃん。\n君という魔法少女の誕生で魔法災害の被害は人類滅亡を免れる程度には抑えられてるし。", 1));
      conv.add(new conv_text("今の私はその活動の一環であなたと対峙しているんだよっ！！！", 0));
      conv.add(new conv_text("ははっ確かに。\n………いいよ。気が済むまで遊んであげる。", 1));
    }
    noCursor();

    M = loadImage("M.png");
    E = loadImage("ET.png");
    BGM_STOP();
    BGM[1].loop();
  }
  float WX = 0, WY = 0;
  int time = -240;
  ArrayList<Tama> T_list = new ArrayList();
  ArrayList<Tama> eT_list = new ArrayList();
  ArrayList<Beam> B_list = new ArrayList();
  boolean conversation = true;
  boolean con_wave = false;
  int con_time = 0;
  ArrayList<conv_text>conv = new ArrayList();
  void processScene() {
    if (practice && KeyState.Rget('q')) {
      next = new Game();
      BGM_STOP();
      BGM[0].loop();
    }
    if (conversation) {
      if (conv.size() == 0) {
        conversation = !conversation;
      } else {
        if (!conv.get(0).delete) {
          conv.get(0).process();
        } else {
          conv.remove(0);
        }
      }
      con_time ++;
      con_time = min(con_time, 20);
    } else {
      time++;
      con_time = 0;
    }
    if (time == 0) {
      boss.HP = boss.HP_Max;
      P.battle = true;
      boss.start_battle();
      con_wave = false;
      if (boss.wave == 0) {
        BGM_STOP();
        BGM[2].loop();
      }
      if (boss.wave == 2) {
        BGM_STOP();
        BGM[3].loop();
      }
      if (boss.wave == 4) {
        BGM_STOP();
        BGM[5].loop();
      }
      if (boss.wave == 7) {
        BGM_STOP();
        BGM[6].loop();
      }
    } else if (time < 0) {
      P.stop_player();
      boss.stop_boss();
      if (boss.HP < boss.HP_Max && boss.wave != 8)boss.HP += (boss.HP_Max/80);
      if (time < -120) {
        P.x += Back_P.x;
        P.y += Back_P.y;
        boss.x += Back_B.x;
        boss.y += Back_B.y;
      } else {
        if (boss.wave == 4 && !conversation && !con_wave) {
          con_wave = true;
          conversation = true;
          if (P.HP > P.HP_Max*0.5) {
            conv.add(new conv_text("はぁ…はぁ……", 0));
            conv.add(new conv_text("……へぇ、結構やるじゃん。\n正直ここまでやるとは思わなかったよ。", 1));
            conv.add(new conv_text("並の魔法少女ならもう瀕死くらいなんだけど\n………それに、すごい治癒力だ。", 1));
            conv.add(new conv_text("まあ、そこが取り柄で魔法少女やっているからね。", 0));
            conv.add(new conv_text("ふーん。………なるほどね。\nつまり'お気に入り'ってわけだ。", 1));
            conv.add(new conv_text("………？なにそれ。", 0));
            conv.add(new conv_text("いや。なんでもないよ。\nこちら側の話しだから。", 1));
            conv.add(new conv_text("そんなことよりさっさと構えたほうがいい。\n回復が間に合わない程の攻撃を浴びせてあげるから。", 1));
          } else {
            conv.add(new conv_text("はぁ…はぁ……", 0));
            conv.add(new conv_text("(やばいやばいやばい。今までにない強さだ。早く回復しないと…)", 0));
            conv.add(new conv_text("……頑張るじゃん。もうちょっと早く仕留められると思っていたんだけど…", 1));
            conv.add(new conv_text("あなたの…目的は何……？", 0));
            conv.add(new conv_text("目的、、うーん。\n生きること、、かな？", 1));
            conv.add(new conv_text("私の元居た結界世界では魔法少女がいっぱいいて\nすごく生きにくかったんだ。", 1));
            conv.add(new conv_text("見つかったら最後、魔法少女が全滅するまで\n私に襲い掛かってくるんだから大変だったんだ。", 1));
            conv.add(new conv_text("でもある日、魔法のない世界へ行く方法を見つけることができて\nそれでこの世界に来たんだよね。", 1));
            conv.add(new conv_text("そしたら私がこの世界に来たことによって\n魔法の概念がこの世界にも合流して…", 1));
            conv.add(new conv_text("世界のエネルギーは不安定になり、、、\n挙句の果て君のようにこの世界にも魔法少女が誕生してしまったってわけ。", 1));
            conv.add(new conv_text("……うーん。整理すれば整理するほど混乱してくるね。\n特に私の場合、生きているだけで罪みたいなものだし。", 1));
            conv.add(new conv_text("はぁ…はぁ……なる…ほど。\n(話し終わりそう、、、な、何か話題を、、)", 0));
            conv.add(new conv_text("聞いてきた割には反応薄いなぁ～。\n…………", 1));
            conv.add(new conv_text("…………ああ、なるほど。回復を待っているのか。", 1));
            conv.add(new conv_text("言ってくれればそれくらい待つのに。", 1));
            conv.add(new conv_text("余裕、、、だなこの人、、、", 0));
            conv.add(new conv_text("まあ、、正直、負ける気がしないしね～。\n(人扱いしてくれるんだ。)", 1));
            conv.add(new conv_text("知るはずもないか。そもそも私みたいな魔女っていう存在は\n魔法少女が単独で倒せるような存在ではないんだよ。", 1));
            conv.add(new conv_text("それでも君はこの世界の原初の魔法少女だ。\nそりゃぁ興味も沸くし、遊びにも付き合いたくなるさ。", 1));
            conv.add(new conv_text("だから準備できたら教えてよ。\n君が回復するまで待つから", 1));
            conv.add(new conv_text("…………(回復待ち)", 1));
            conv.add(new conv_text("………(回復待ち)", 1));
            conv.add(new conv_text("……(回復待ち)", 1));
            conv.add(new conv_text("…(回復待ち)", 1));
            conv.add(new conv_text("(回復待ち)", 1));
            conv.add(new conv_text("そろそろ良いかい？……じゃあ始めるよ", 1));
          }
          BGM_STOP();
          BGM[4].loop();
        }
      }
    }
    B.processBackground();
    ArrayList<Integer>remove_list = new ArrayList();
    for (int i = 0; i < T_list.size(); i++) {
      T_list.get(i).doTama();
      if (T_list.get(i).delete)remove_list.add(i);
    }
    for (int i = 0; i < remove_list.size(); i++) {
      T_list.remove(remove_list.get(i)-i);
    }
    remove_list.clear();
    for (int i = 0; i < eT_list.size(); i++) {
      eT_list.get(i).doTama();
      if (eT_list.get(i).delete)remove_list.add(i);
    }
    for (int i = 0; i < remove_list.size(); i++) {
      eT_list.remove(remove_list.get(i)-i);
    }
    remove_list.clear();
    for (int i = 0; i < B_list.size(); i++) {
      B_list.get(i).doBeam();
      if (B_list.get(i).delete)remove_list.add(i);
    }
    for (int i = 0; i < remove_list.size(); i++) {
      B_list.remove(remove_list.get(i)-i);
    }
    boss.process_Boss();
    P.do_player();
    WX = map(P.x, BW_Min, BW_Max, 320, -320);
    WY = map(P.y, BH_Min, BH_Max, 180, -180);
    if (P.HP <= 0) {
      next = new gameover_scene();
    }
  }
  void drawScene() {
    noStroke();
    B.drawBackground(WX, WY);
    boss.display();
    P.display_player();
    for (int i = 0; i < T_list.size(); i++) {
      T_list.get(i).displayTama();
    }
    for (int i = 0; i < eT_list.size(); i++) {
      eT_list.get(i).displayTama();
    }
    for (int i = 0; i < B_list.size(); i++) {
      B_list.get(i).displayBeam();
    }
    P.display_cursor();

    stroke(0);
    strokeWeight(6);
    fill(100);
    rect(660, 20, -600, 65);
    fill(255, 0, 0);
    rect(660, 20, -600*(P.red_HP/P.HP_Max), 65);
    fill(0, 255, 0);
    rect(660, 20, -600*(P.HP/P.HP_Max), 65);
    fill(100);
    rect(1760-660, 20, 600, 65);
    fill(255, 0, 0);
    rect(1760-660, 20, 600*(boss.red_HP/boss.HP_Max), 65);
    fill(0, 255, 0);
    rect(1760-660, 20, 600*(boss.HP/boss.HP_Max), 65);
    textSize(40);
    fill(255);
    draw_string("You", 60, 110, color(255, 255, 255), color(0, 0, 155), 1);
    textSize(40);
    fill(255);
    draw_string("Enemy", 1760-170, 110, color(255, 255, 255), color(155, 0, 0), 1);

    textSize(60);
    fill(255);
    if (practice) {
      text("練習ステージ", 1760/2-60*3, 60);
    } else if (boss.wave == 8) {
      fill(255, 255, 0);
      text("ゲームクリア！！！", 1760/2-60*4.5, 990/2-30);
    } else {
      text("ステージ"+(boss.wave+1), 1760/2-60*2.25, 60);
    }

    textSize(50);
    fill(0);
    if (conversation) {
      if (conv.size()!=0) {
        if (conv.get(0).talker == 1) {
          tint(155, 155, 155);
        } else {
          noTint();
        }
      } else {
        noTint();
      }
      image(M, -100+con_time*30-600, 40);
      if (conv.size()!=0) {
        if (conv.get(0).talker == 0) {
          tint(155, 155, 155);
        } else {
          noTint();
        }
      } else {
        noTint();
      }
      image(E, 1760-850-con_time*30+600, 40);
      fill(0, 155, 60, 160);
      stroke(255);
      strokeWeight(6);
      rect(25, 770, 1760-50, 200);
      if (conv.size()!=0)conv.get(0).display(45, 830);
    }
    noStroke();
    if (practice) {
      fill(255);
      textSize(20);
      text("練習モードです。'Q'で戻る。", 10, 140);
      text("W:上方向に移動", 10, 170);
      text("A:左方向に移動", 10, 200);
      text("S:下方向に移動", 10, 230);
      text("D:右方向に移動", 10, 260);
      text("スペース:ダッシュ回避", 10, 290);
      text("マウス左長押し:マウスポインターに向かって攻撃", 10, 320);
      text("マウス右長押し:低速移動", 10, 350);
    }
  }
  void stop_battle() {
    P.battle = false;
    boss.battle = false;
    if (boss.wave != 7)time = -240;
    else {
      time = -10;
    }
    for (int i = 0; i < T_list.size(); i++) {
      T_list.get(i).moveStop();
    }
    for (int i = 0; i < eT_list.size(); i++) {
      eT_list.get(i).moveStop();
    }
    for (int i = 0; i < B_list.size(); i++) {
      B_list.get(i).moveStop();
    }
    Back_P.x = (200 - P.x)/120;
    Back_P.y = ((BH_Max+BH_Min)/2 - P.y)/120;
    Back_B.x = (1600 - boss.x)/120;
    Back_B.y = ((BH_Max+BH_Min)/2 - boss.y)/120;
  }
  PVector Back_P = new PVector(0, 0);
  PVector Back_B = new PVector(0, 0);
}
class Player {
  float x, y, pr;
  int cool_hit_time = 0;
  PVector sp = new PVector(0, 0);
  PVector kaihi = new PVector(0, 0);
  int time = 0;
  float HP = 0;
  float HP_Max = 0;
  float pre_HP = 0;
  float red_HP = 0;
  boolean kaihi_flag = true;
  boolean muteki_flag = false;
  boolean pre_HP_flag = false;
  int pre_HP_time = 0;
  float stack_HP = 0;
  PImage cenP;
  PImage lefP;
  PImage rigP;
  Battle main;
  Player(Battle main) {
    this.main = main;
    x = 200;
    y = abs(main.BH_Max+main.BH_Min)/2;
    pr = 1;
    red_HP = pre_HP = HP = HP_Max = 35;
    cenP = loadImage("M1.png");
    rigP = loadImage("M2.png");
    lefP = loadImage("M3.png");

    println();
  }
  boolean battle = false;
  void do_player() {
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
    if ((main.time % 30 == 0 && !main.conversation) || (frameCount % 30 == 0 && main.conversation)) {
      HP += 0.2;
    }
    if (HP > HP_Max)HP = HP_Max;
    if (cool_kaihi > 0)cool_kaihi--;
    if (cool_hit_time > 0) {
      muteki_flag = true;
      cool_hit_time --;
    }
    if (!KeyState.get(' ')&&!kaihi_flag && cool_kaihi == 0) {
      kaihi_flag = true;
      kaihi_heal.pause();
      kaihi_heal.play(0);
    }
    if (battle)battle_player();
  }
  void stop_player() {
    sp.mult(0);
    kaihi.mult(0);
  }
  int sel_charge=0;
  int charge[] = {0};
  int charge_max[] = {30};
  int cool_kaihi = 0;
  float MX_ini, MY_ini;
  void battle_player() {

    muteki_flag = false;
    if (cool_kaihi > 45)muteki_flag = true;
    if (cool_hit_time > 0) {
      muteki_flag = true;
    }
    float theta = atan2(MY-y, MX-x);
    //float theta = atan2(MY-MY_ini, MX-MX_ini);
    float bai = 1.0;
    if (KeyState.mget(RIGHT)) {
      bai = 0.5;
    }
    if (KeyState.mget(LEFT)) {
      time++;
      if (time % 4 == 0) {
        shot1.pause();
        shot1.play(0);
        main.T_list.add(new LinerShot1(x+25*cos(theta+radians(30)), y+25*sin(theta+radians(30)), 24, theta, 2, new MPlayerTama1(14)));
        main.T_list.add(new LinerShot1(x+25*cos(theta+radians(-30)), y+25*sin(theta+radians(-30)), 24, theta, 2, new MPlayerTama1(14)));
      }
      if (time % 3 == 0) {
        main.T_list.add(new LinerShot1(x, y, 36, theta, 2, new MPlayerTama2(11)));
      }
    } else {
    }

    if (KeyState.get(' ') && kaihi.mag() == 0 && sp.mag() > 0 && kaihi_flag) {
      swing.pause();
      swing.play(0);
      kaihi.x = sp.x;
      kaihi.y = sp.y;
      kaihi_flag = false;
      kaihi.setMag(25);
      cool_kaihi = 90;
    }

    if (KeyState.get('w')) {
      if (sp.y > 0 && !KeyState.get('s')) {
        sp.mult(0.94);
      }
      sp.y -= 0.65;
    }
    if (KeyState.get('s')) {
      if (sp.y < 0 && !KeyState.get('w')) {
        sp.mult(0.94);
      }
      sp.y += 0.65;
    }
    if (KeyState.get('a')) {
      if (sp.x > 0&&!KeyState.get('d')) {
        sp.mult(0.94);
      }
      sp.x -= 0.65;
    }
    if (KeyState.get('d')) {
      if (sp.x < 0&&!KeyState.get('a')) {
        sp.mult(0.94);
      }
      sp.x += 0.65;
    }
    x += sp.x*bai + kaihi.x;
    y += sp.y*bai+ kaihi.y;
    sp.mult(0.955);
    kaihi.mult(0.94);
    if (kaihi.mag() < 1)kaihi.setMag(0);
    if (x < main.BW_Min + pr) {
      x = main.BW_Min + pr;
    }
    if (y < main.BH_Min +pr) {
      y = main.BH_Min+pr;
    }
    if (x > main.BW_Max-pr) {
      x = main.BW_Max-pr;
    }
    if (y > main.BH_Max-pr) {
      y = main.BH_Max-pr;
    }
    if (!muteki_flag && battle) {
      for (int i = 0; i < main.eT_list.size(); i++) {
        if (main.eT_list.get(i).hitTama(x, y, pr) && !main.eT_list.get(i).D) {
          HP -= main.eT_list.get(i).at;
          main.eT_list.get(i).delete = true;
          cool_hit_time = 10;
          damage.pause();
          damage.play(0);
        }
      }
      for (int i = 0; i < main.B_list.size(); i++) {
        if (main.B_list.get(i).hitBeam(x, y, pr) && !main.B_list.get(i).D) {
          HP -= main.B_list.get(i).at;
          cool_hit_time = 10;
          damage.pause();
          damage.play(0);
        }
      }
    }
  }
  void display_player() {
    float Y = 4*sin(radians(frameCount*3));
    translate(x, y+Y);
    noTint();
    if (MX > x || !battle) {
      if (sp.mag() < 0.5) {
        image(cenP, -52, -80, 160, 160);
      } else {
        if (sp.x > 0) {
          image(rigP, -52, -80, 160, 160);
        } else {
          image(lefP, -52, -80, 140, 140);
        }
      }
    } else {
      scale(-1, 1);
      if (sp.mag() < 0.5) {
        image(cenP, -52, -80, 160, 160);
      } else {
        if (sp.x > 0) {
          image(lefP, -52, -80, 140, 140);
        } else {
          image(rigP, -52, -80, 160, 160);
        }
      }
      scale(-1, 1);
    }
    translate(-x, -y-Y);
    stroke(155, 0, 0);
    strokeWeight(2);
    fill(255, 0, 0);
    ellipse(x, y, pr*9, pr*9);
    if (muteki_flag) {
      stroke(255, 240, 0);
      fill(255, 255, 0, 50);
      ellipse(x, y, pr*64, pr*64);
    }
    if (cool_kaihi > 0) {
      noFill();
      stroke(0, 255, 255);
      strokeWeight(5);
      arc(x, y, pr*80, pr*80, radians(0), radians(360*(cool_kaihi/90.0)));
    }
  }
  void display_cursor() {
    noFill();
    strokeWeight(10);
    stroke(155, 0, 0);
    ellipse(MX, MY, 50+20*sin(radians(frameCount*3)), 50+20*sin(radians(frameCount*3)));
    strokeWeight(6);
    stroke(255, 0, 0);
    ellipse(MX, MY, 50+20*sin(radians(frameCount*3)), 50+20*sin(radians(frameCount*3)));
    fill(255, 255, 0);
    noStroke();
    float l =  60+20*sin(radians(frameCount*3));
    ellipse(MX, MY, 12, 12);
    stroke(255, 155, 0);
    strokeWeight(3);
    noFill();
    ellipse(MX, MY, l*2, l*2);
    noStroke();
    fill(255, 155, 0);
    ellipse(MX+l*cos(radians(frameCount*4)), MY+l*sin(radians(frameCount*4)), 15, 15);
    ellipse(MX+l*cos(radians(frameCount*4+90)), MY+l*sin(radians(frameCount*4+90)), 15, 15);
    ellipse(MX+l*cos(radians(frameCount*4+180)), MY+l*sin(radians(frameCount*4+180)), 15, 15);
    ellipse(MX+l*cos(radians(frameCount*4+270)), MY+l*sin(radians(frameCount*4+270)), 15, 15);
  }
}
class background1 extends Background {
  background1(Battle main) {
    super(main);
    for (int i = 0; i < 50; i++) {
      Elist.add(new effect());
    }
  }
  ArrayList<effect>Elist = new ArrayList();
  void drawBackground(float X, float Y) {
    background(20, 55, 10);
    color A = lerpColor(color(55, 50, 120), color(25, 60, 80), sq(sin(radians(time_B/200))));
    color B = lerpColor(color(90, 30, 10), color(80, 60, 30), sq(cos(radians(time_B/200))));
    //color C = lerpColor(color(30, 10, 20), color(120, 30, 60), sq(sin(radians(time_B/600))));
    color D = lerpColor(A, B, sq(sin(radians(time_B/300))));
    fill(D);
    rect(0, 0, 1760+640+X, 990+320+Y);
    for (int i = 0; i < Elist.size(); i++) {
      Elist.get(i).drawEf(X, Y);
    }
  }
  int time_B = 0;
  void processBackground() {
    time_B+= 3;
    if (Elist.size() < 200 && (time_B/3) % 20 == 0) {
      for (int i = 0; i < int(random(5)); i++) {
        Elist.add(new effect());
      }
    }
    for (int i = 0; i < Elist.size(); i++) {
      Elist.get(i).processEf();
      if (Elist.get(i).delete) {
        Elist.remove(i);
      }
    }
  }
}
class effect {
  float x, y;
  PVector sp = new PVector(0, 0);
  float a;
  int time = int(random(-100, 200));
  float w;
  effect() {
    x = random(-320, 1760+320);
    y = random(-180, 990+180);
    a = random(3, 12);
    float l = map(a, 3, 12, 0.3, 0.05);
    float theta = random(0, 2*PI);
    sp.x = l*cos(theta);
    sp.y = l*sin(theta);
    T = int(random(100, 300));
    w = map(a, 3, 12, PI/40, PI/20);
  }
  int T = 0;
  float rad = 0;
  int limit_time = 1800;
  void drawEf(float X, float Y) {
    fill(255, 255, 255, min(time*3, 155)+min((limit_time-60)-time*3, 0));//
    float A = a*(1+0.2*sin(radians(frameCount/T)));
    translate(x+X, y+Y);
    rotate(rad);
    rect(-A/2, -A/2, a, a);
    rotate(-rad);
    translate(-x-X, -y-Y);
  }
  boolean delete = false;
  void processEf() {
    time ++;
    x += sp.x;
    y += sp.y;
    rad += w;
    if (time > limit_time)delete = true;
  }
}
abstract class Background {
  Battle main;
  Background(Battle main) {
    this.main = main;
  }
  abstract void drawBackground(float X, float Y);
  abstract void processBackground();
}
