abstract class GameObject {
  
  float x_pos, y_pos;
  float obj_width, obj_height;
  String sprite;
  int[] sprite_offset = {0, 0};
  
  void print() {
    // fill(0);
    // rect(x_pos, y_pos, obj_width, obj_height); // hitbox
    image(game_sprites.get(sprite), x_pos + sprite_offset[0], y_pos + sprite_offset[1]);
  }
  
  boolean is_collisioning_with(GameObject anObject) {
    return (x_pos + obj_width > anObject.x_pos && x_pos < anObject.x_pos + anObject.obj_width) &&
           (y_pos + obj_height  > anObject.y_pos && y_pos < anObject.y_pos + anObject.obj_height);
  }
  
  void toggle_sprite() {}
  
}

class Ground extends GameObject {
 
  Ground() {
    x_pos = 2400;
    y_pos = 515;
    sprite = "ground";
  }

  void update(int speed) {
    x_pos -= speed;
    if (x_pos <= 0) {
      x_pos = 2400;
    }
  }
  
  void print() {
    image(game_sprites.get(sprite), x_pos, y_pos);
    image(game_sprites.get(sprite), x_pos - 2400, y_pos);
  }
  
}
