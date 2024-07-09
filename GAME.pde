class Game extends Scene {
  Button_list blist = new Buttons();
  Game() {
    Button_Material bd = new button1();
    blist.addButton(new list_button("Practice", 1100, 550, 70, bd));
    blist.addButton(new list_button("Battle", 1100, 650, 70, bd));
    cursor();
    blist.setW();
  }
  void processScene() {
    blist.Button_list_process();
    if(blist.isButtonFlag(0)){
      next = new Battle(true);
    }else if(blist.isButtonFlag(1)){
      next = new Battle(false);
    }
  }
  void drawScene() {
    background(200,255,200);
    blist.Button_list_display();
  }
}
