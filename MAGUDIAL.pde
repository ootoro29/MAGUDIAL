import org.quark.stegnos.*;

import java.util.Map;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

void setup() {//16:9
  KeyState.initialize();
  //fullScreen();
  size(1760, 990);
  windowRatio(1760, 990);
  //windowRatio(1760,990);
  text = loadFont("HGPGothicE-48.vlw");
  textFont(text);
  sound();
  //noSmooth();
  main = new Title(true);
  tmain = loadImage("MT.png");
}
Scene main;
PImage back;
PImage tmain;
int MX, MY;
PFont text;
void draw() {

  main = main.doScene();
  MX = mouseX;
  MY = mouseY;
}
class Title extends Scene {
  Button_list blist = new Buttons();
  PFont title;
  Title(boolean music) {
    cursor();
    title = loadFont("LeelawadeeUI-Bold-200.vlw");
    colorMode(RGB);

    Button_Material bd = new button1();
    blist.addButton(new list_button("GAME START", 1000, 550, 70, bd));
    blist.addButton(new list_button("OPTION", 1000, 650, 70, bd));
    blist.addButton(new list_button("EXIT", 1000, 750, 70, bd));
    blist.setW();
    if (music) {
      BGM_STOP();
      BGM[0].loop();
    }
  }
  float x, y;
  void processScene() {
    blist.Button_list_process();
    if (blist.isButtonFlag(0)) {
      next = new Game();
    }
    if (blist.isButtonFlag(1)) {
      next = new option_scene();
    }
    if (blist.isButtonFlag(2)) {
      exit();
    }
  }
  void drawScene() {
    background(155);
    textSize(150);
    image(tmain, 0, 40*sin(radians(frameCount*4))-60, tmain.width*1.4, tmain.height*1.4);
    textFont(title);
    draw_string("-MAGUDIAL-",500,220,color(255),color(0),1);
    draw_string("-MAGUDIAL-",500,220,color(255),color(0),2);
    textFont(text);
    blist.Button_list_display();
  }
}
class option_scene extends Scene {
  Button_list blist = new Buttons();
  option_scene() {
    colorMode(RGB);
    Button_Material bd = new button1();
    blist.addButton(new list_button("BACK", 1350, 850, 70, bd));
    blist.setW();
  }
  void processScene() {
    blist.Button_list_process();
    if (blist.isButtonFlag(0)) {
      next = new Title(false);
    }
  }
  void drawScene() {
    background(155, 120, 120);
    blist.Button_list_display();
  }
}
class gameover_scene extends Scene {
  Button_list blist = new Buttons();
  gameover_scene() {
    colorMode(RGB);
    Button_Material bd = new button1();
    blist.addButton(new list_button("BACK", 1350, 850, 70, bd));
    blist.setW();
    BGM_STOP();
    cursor();
  }
  void processScene() {
    blist.Button_list_process();
    if (blist.isButtonFlag(0)) {
      next = new Title(true);
    }
  }
  void drawScene() {
    background(0);
    textSize(180);
    fill(255, 0, 0);
    text("GAME OVER", 50, 200);
    blist.Button_list_display();
  }
}
abstract class Scene {
  Scene next;
  Scene() {
    next = this;
  }
  Scene doScene() {
    processScene();
    drawScene();
    KeyState.Rini();
    KeyState.mRini();
    return next;
  }
  abstract void processScene();
  abstract void drawScene();
}
class button1 extends Button_Material {
  void display(float x, float y, float w, float h, int size, String s, float dx, float dy) {
    stroke(0, 0, 30);
    strokeWeight(6);
    fill(60, 80, 240);
    rect(x, y, w, h, 5);
    fill(200);
    textSize(size);
    text(s, x+dx, y+dy);
  }
  void ondisplay(float x, float y, float w, float h, int size, String s, float dx, float dy) {
    stroke(0, 0, 60);
    strokeWeight(6);
    fill(80, 120, 255);
    rect(x, y, w, h, 5);
    fill(255);
    textSize(size);
    text(s, x+dx, y+dy);
  }
}
abstract class Button_Material {
  abstract void display(float x, float y, float w, float h, int size, String s, float dx, float dy);
  abstract void ondisplay(float x, float y, float w, float h, int size, String s, float dx, float dy);
}
class Buttons extends Button_list {
  Buttons() {
  }
  void Button_process() {
  }
}
class list_button extends Button {
  Scene next;
  list_button(String s, float x, float y, int size, Button_Material M, float ... a) {
    super(s, x, y, size, M, a);
  }
  void ButtonProcess() {
    if ((onButton() && KeyState.mRget(LEFT))||((onButton()||select) && (KeyState.Rget('z')))) {
      flag = true;
    } else {
      flag = false;
    }
  }
}
abstract class Button_list {
  ArrayList<Button>set_Button = new ArrayList();
  Button_list() {
  }
  void addButton(Button x) {
    set_Button.add(x);
  }
  int index = -1;
  void Button_list_display() {
    for (int i = 0; i < set_Button.size(); i++) {
      set_Button.get(i).display();
    }
  }
  void setW() {
    float max = 0;
    for (int i = 0; i < set_Button.size(); i++) {
      max = max(max, set_Button.get(i).w);
    }
    for (int i = 0; i < set_Button.size(); i++) {
      float dw = (max - set_Button.get(i).w)/2;
      set_Button.get(i).w = max;
      set_Button.get(i).dx += dw;
    }
  }
  void Button_list_process() {
    if (KeyState.Rget(UP)&&index > 0) {
      index--;
    }
    if (KeyState.Rget(DOWN)&&index<set_Button.size()-1) {
      index++;
    }
    for (int i = 0; i < set_Button.size(); i++) {
      set_Button.get(i).process();
      set_Button.get(i).select = false;
      if (set_Button.get(i).onButton()) {
        index = i;
      }
    }
    if (0<=index&&index <= set_Button.size()-1) {
      set_Button.get(index).select = true;
    }
  }
  boolean isButtonFlag(int index) {
    if (0<=index && index < set_Button.size()) {
      return set_Button.get(index).flag;
    } else {
      return false;
    }
  }
  abstract void Button_process();
}
abstract class Button {
  float x, y, w, h;
  Button_Material M;
  String s;
  float dx = 0, dy = 0;
  int size = 30;
  boolean flag = false;
  Button(String s, float x, float y, int size, Button_Material M, float ... a) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.M = M;
    this.s = s;
    w = (s.length()+1) * size*0.75 + 10;
    h = size+5;
    dy = h - 10;
    dx = 30;
    if (a.length >= 2) {
      dx = a[0];
      dy = a[1];
    }
  }
  boolean onButton() {
    boolean ans = false;
    if (x <= MX && MX <= x + w && y <= MY && MY <= y+h) {
      ans = true;
    }
    return ans;
  }
  boolean onFlag() {
    return flag;
  }
  boolean select = false;
  void display() {
    if (onButton()||select) {
      M.ondisplay(x, y, w, h, size, s, dx, dy);
    } else {
      M.display(x, y, w, h, size, s, dx, dy);
    }
  }
  void process() {
    ButtonProcess();
  }
  abstract void ButtonProcess();
}
public static class KeyState {
  private static final HashMap<Integer, Boolean> states = new HashMap<Integer, Boolean>();
  private static final HashMap<Character, Boolean> Csta = new HashMap<Character, Boolean>();

  private static final HashMap<Integer, Boolean> Rstates = new HashMap<Integer, Boolean>();
  private static final HashMap<Character, Boolean> RCsta = new HashMap<Character, Boolean>();

  private static final HashMap<Integer, Boolean> Rmouse = new HashMap<Integer, Boolean>();
  private static final HashMap<Integer, Boolean> mouse = new HashMap<Integer, Boolean>();
  private KeyState() {
  }

  static void initialize() {
    states.put(LEFT, false);
    states.put(RIGHT, false);
    states.put(UP, false);
    states.put(DOWN, false);
    states.put(SHIFT, false);
    Csta.put('w', false);
    Csta.put('a', false);
    Csta.put('s', false);
    Csta.put('d', false);
    Csta.put(' ', false);
    Rstates.put(LEFT, false);
    Rstates.put(RIGHT, false);
    Rstates.put(UP, false);
    Rstates.put(DOWN, false);
    RCsta.put('z', false);
    RCsta.put('q', false);
    RCsta.put(' ', false);

    mouse.put(LEFT, false);
    Rmouse.put(LEFT, false);
    mouse.put(RIGHT, false);
    Rmouse.put(RIGHT, false);
  }

  public static boolean mget(int code) {
    return mouse.get(code);
  }
  public static boolean mRget(int code) {
    return Rmouse.get(code);
  }
  public static boolean get(int code) {
    return states.get(code);
  }
  public static boolean get(char code) {
    return Csta.get(code);
  }
  public static boolean Rget(int code) {
    return Rstates.get(code);
  }
  public static boolean Rget(char code) {
    return RCsta.get(code);
  }
  public static void mput(int code, boolean state) {
    mouse.put(code, state);
  }
  public static void put(int code, boolean state) {
    states.put(code, state);
  }
  public static void put(char code, boolean state) {
    Csta.put(code, state);
  }
  public static void Rput(int code, boolean state) {
    Rstates.put(code, state);
  }
  public static void Rput(char code, boolean state) {
    RCsta.put(code, state);
  }
  public static void mRput(int code, boolean state) {
    Rmouse.put(code, state);
  }
  public static void Rini() {
    for (HashMap.Entry m : Rstates.entrySet()) {
      Rstates.put((Integer)m.getKey(), false);
    }
    for (HashMap.Entry m : RCsta.entrySet()) {
      RCsta.put((Character)m.getKey(), false);
    }
  }
  public static void mRini() {
    for (HashMap.Entry m : Rmouse.entrySet()) {
      Rmouse.put((Integer)m.getKey(), false);
    }
  }
}
void keyPressed() {
  KeyState.put(keyCode, true);
  KeyState.put(key, true);
}

void keyReleased() {
  KeyState.put(keyCode, false);
  KeyState.put(key, false);
  KeyState.Rput(keyCode, true);
  KeyState.Rput(key, true);
}
void mousePressed() {
  KeyState.mput(mouseButton, true);
}

void mouseReleased() {
  KeyState.mRput(mouseButton, true);
  KeyState.mput(mouseButton, false);
}
