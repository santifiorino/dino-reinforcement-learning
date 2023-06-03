import java.util.Collections;
import java.util.Iterator;

HashMap<String, PImage> game_sprites = new HashMap<String, PImage>();

Simulation simulation;

int tenth = 0;
int clock = 0;

void setup() {
  size(1280, 720);
  initialize_sprites();
  simulation = new Simulation();
}

void draw() {
  background(247);
  simulation.update();
  simulation.print();
  if (millis() - tenth > 50){
    // every 0.05 seconds
    tenth = millis();
    clock++;
    if (clock % 2 == 0){
      // every 0.1 seconds
      simulation.tenth_of_second();
    }
    if (clock % 5 == 0){
      // every 0.25 seconds
      simulation.quarter_of_second();
    }
  }
}

void initialize_sprites(){
  PImage sprite_sheet = loadImage("sprites.png");
  game_sprites.put("standing_dino", sprite_sheet.get(1338, 2, 88, 94));
  game_sprites.put("walking_dino_1", sprite_sheet.get(1514, 2, 88, 94));
  game_sprites.put("walking_dino_2", sprite_sheet.get(1602, 2, 88, 94));
  game_sprites.put("dead_dino", sprite_sheet.get(1690, 2, 88, 94));
  game_sprites.put("crouching_dino_1", sprite_sheet.get(1866, 36, 118, 60));
  game_sprites.put("crouching_dino_2", sprite_sheet.get(1984, 36, 118, 60));
  game_sprites.put("cactus_type_1", sprite_sheet.get(446, 2, 34, 70));
  game_sprites.put("cactus_type_2", sprite_sheet.get(480, 2, 68, 70));
  game_sprites.put("cactus_type_3", sprite_sheet.get(548, 2, 102, 70));
  game_sprites.put("cactus_type_4", sprite_sheet.get(652, 2, 50, 100));
  game_sprites.put("cactus_type_5", sprite_sheet.get(702, 2, 100, 100));
  game_sprites.put("cactus_type_6", sprite_sheet.get(802, 2, 150, 100));
  game_sprites.put("bird_flying_1", sprite_sheet.get(260, 2, 92, 80));
  game_sprites.put("bird_flying_2", sprite_sheet.get(352, 2, 92, 80));
  game_sprites.put("ground", sprite_sheet.get(2, 104, 2400, 24));
}
