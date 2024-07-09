Minim minim;
AudioPlayer shot1;
AudioPlayer hit;
AudioPlayer swing;
AudioPlayer beam1;
AudioPlayer kaihi_heal;
AudioPlayer beat;
AudioPlayer damage;

AudioPlayer BOSS[] = new AudioPlayer[10];
AudioPlayer BGM[] = new AudioPlayer[10];
void sound() {
  minim = new Minim(this);
  shot1 = minim.loadFile("shot1 (1).wav");
  swing = minim.loadFile("se_swing1.mp3");
  hit = minim.loadFile("hit.wav");
  beam1 = minim.loadFile("hit.wav");
  kaihi_heal = minim.loadFile("kaihi_max.mp3");
  beat = minim.loadFile("se_damage11.mp3");
  damage = minim.loadFile("hit.mp3");
  BOSS[0] = minim.loadFile("se_magic14.mp3");
  BOSS[1] = minim.loadFile("se_beam05.mp3");
  BOSS[2] = minim.loadFile("se_beam1.mp3");
  BOSS[3] = minim.loadFile("se_beam06.mp3");
  BOSS[4] = minim.loadFile("se_zushuun3.mp3");
  BOSS[5] = minim.loadFile("se_beam03.mp3");
  BOSS[6] = minim.loadFile("se_beam03.mp3");
  BOSS[7] = minim.loadFile("se_beam03.mp3");
  
  BGM[0] = minim.loadFile("Galaxy-Battle.wav");
  BGM[1] = minim.loadFile("Castaway-of-the-Universe.wav");
  BGM[2] = minim.loadFile("binary-star.wav");
  BGM[3] = minim.loadFile("Mysterious-space-creatures.wav");
  BGM[4] = minim.loadFile("To-survive.wav");
  BGM[5] = minim.loadFile("A-Space-Odyssey.wav");
  BGM[6] = minim.loadFile("full-throttle.wav");
  //kaihi_max.mp3
  shot1.setGain(-10);
  swing.setGain(-10);
  hit.setGain(-10);
  beam1.setGain(-10);
  kaihi_heal.setGain(-10);
  beat.setGain(-10);
  damage.setGain(-10);
  for (int i = 0; i < 8; i++) {
    BOSS[i].setGain(-12);
  }
  BOSS[2].setGain(-15);
  
  for (int i = 0; i < 7; i++) {
    BGM[i].setGain(-20);
  }
}
void BGM_STOP(){
  for(int i = 0; i < 7; i++){
    BGM[i].pause();
    BGM[i].play(0);
    BGM[i].pause();
  }
}
