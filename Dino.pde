class Dino extends GameObject implements Comparable<Dino>{
  
  float jump_stage;
  boolean alive = true;
  int score;

  Genome genome;
  Brain brain;
  float[] brain_inputs = new float[7];

  Dino() {
    x_pos = (int)random(100, 300);
    y_pos = 450;
    obj_width = 80;
    obj_height = 86;
    
    genome = new Genome();
    init_brain();
    jump_stage = 0;
    
    sprite = "walking_dino_1";
    sprite_offset[0] = -4;
    sprite_offset[1] = -2;
  }

  void init_brain() {
    brain = new Brain(genome);
  }

  void print() {
    if (alive) {
      image(game_sprites.get(sprite), x_pos + sprite_offset[0], y_pos + sprite_offset[1]);
    }
  }
  
  void update(float[] next_obstacle_info, int speed) {
    update_brain_inputs(next_obstacle_info, speed);
    brain.feed_forward(brain_inputs);
    process_brain_output();
    if ( jumping() ){
      update_jump();
    }
  }

  void update_brain_inputs(float[] next_obstacle_info, int speed){
    brain_inputs[0] = next_obstacle_info[0] / 900;                  // normalized distance
    brain_inputs[1] = (next_obstacle_info[1] - 450) / (1350 - 450); // normalized obstacle x pos
    brain_inputs[2] = (next_obstacle_info[2] - 370) / (480 - 370);  // normalized obstacle y pos
    brain_inputs[3] = (next_obstacle_info[3] - 30) / (146 - 30);    // normalized obstacle width
    brain_inputs[4] = (next_obstacle_info[4] - 40) / (96 - 40);     // normalized obstacle height
    brain_inputs[5] = (y_pos - 278) / (484-278);                    // normalized dino y pos
    brain_inputs[6] = (speed - 15) / (30 - 15);                     // normalized speed
    
  }
  
  void update_jump() {
    y_pos = (int)(450 - ((-4 * jump_stage * (jump_stage - 1)) * 172));
    jump_stage += 0.03;
    if ( jump_stage > 1 ){
      stop_jump();
    }
  }
  
  void process_brain_output() {
    // brain.outputs[0] = up key
    // brain.outputs[1] = down key

    if ( brain.outputs[0] != 0 ) {
      if (!crouching() && !jumping()) {
        jump();
      }
    }
    if ( brain.outputs[1] == 0 ) {
      if (crouching()){
        stop_crouch();
      }
    } else {
      if ( jumping() ) {
        stop_jump();
      }
      crouch();
    }
  }
  
  void jump(){
    jump_stage = 0.0001;
    sprite = "standing_dino";
  }
  
  void stop_jump() {
    jump_stage = 0;
    y_pos = 450; 
    sprite = "walking_dino_1";
  }
  
  void crouch(){
    if ( !crouching() ) {
      y_pos = 484;
      obj_width = 110;
      obj_height = 52;
      sprite = "crouching_dino_1";
    }
  }
  
  void stop_crouch(){
    y_pos = 450;
    obj_width = 80;
    obj_height = 86;
    sprite = "walking_dino_1";
  }
  
  boolean jumping() {
    return jump_stage > 0;
  }
  
  boolean crouching() {
    return obj_width == 110;
  }

  void die(int sim_score) {
    alive = false;
    score = sim_score;
  }

  void reset() {
    alive = true;
    score = 0;
  }
  
  void toggle_sprite() {
    if ( sprite.equals("walking_dino_1") ) {
      sprite = "walking_dino_2";
    } else if ( sprite.equals("walking_dino_2") ) {
      sprite = "walking_dino_1";
    } else if ( sprite.equals("crouching_dino_1") ) {
      sprite = "crouching_dino_2";
    } else if ( sprite.equals("crouching_dino_2") ) {
      sprite = "crouching_dino_1";
    }
  }
  
  @Override
  public int compareTo(Dino otherDino) {
    return Integer.compare(this.score, otherDino.score);
  }
}
