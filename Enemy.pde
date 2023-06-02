abstract class Enemy extends GameObject {
  
  Enemy() {
    x_pos = 1350; 
  }
  
  void update(int speed) {
    x_pos -= speed;
  }
  
  boolean is_offscreen() {
    return x_pos + obj_width < 0;
  }
}

class Cactus extends Enemy {

  int type;
  int[] cactus_widths = {30, 64, 98, 46, 96, 146};
  int[] cactus_heights = {66, 66, 66, 96, 96, 96};
  int[] cactus_y_pos = {470, 470, 470, 444, 444, 444};

  Cactus() {
    type = (int)random(6);
    obj_width = cactus_widths[type];
    obj_height = cactus_heights[type];
    y_pos = cactus_y_pos[type];
    sprite = "cactus_type_" + (type + 1);
    sprite_offset[0] = -2;
    sprite_offset[1] = -2;
  }
    
}

class Bird extends Enemy {

  int type;
  int[] birds_y_pos = {435, 480, 370};
   
  Bird() {
    x_pos = 1350;
    obj_width = 84;
    obj_height = 40;
    type = (int)random(3);
    y_pos = birds_y_pos[type];
    sprite = "bird_flying_1";
    sprite_offset[0] = -4;
    sprite_offset[1] = -16;
  }
  
  void toggle_sprite() {
    if (sprite.equals("bird_flying_1")) {
      sprite = "bird_flying_2";
    } else {
      sprite = "bird_flying_1";
    }
  }
    
}
