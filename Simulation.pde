class Simulation {
  ArrayList<Dino> dinos;
  ArrayList<Enemy> enemies;
  float speed;
  Ground ground;
  // Information
  int score;
  int generation;
  int last_gen_avg_score;
  int last_gen_max_score;
  int dinos_alive;
  
  Simulation() {
    dinos = new ArrayList<Dino>();
    for (int i = 0; i < DINOS_PER_GENERATION; i++) {
      dinos.add(new Dino());
    }
    enemies = new ArrayList<Enemy>();
    speed = 15;
    ground = new Ground();
    
    score = 0;
    generation = 1;
    last_gen_avg_score = 0;
    last_gen_max_score = 0;
    dinos_alive = DINOS_PER_GENERATION;
  }
  
  void update() {
    for (Dino dino : dinos) {
      dino.update(next_obstacle_info(dino), (int)speed);
    }
    Iterator<Enemy> iterator = enemies.iterator();
    while (iterator.hasNext()) {
      Enemy enemy = iterator.next();
      enemy.update((int)speed);
      if (enemy.is_offscreen()) {
        iterator.remove(); // Safe removal using the iterator
      }
    }
    check_collisions();
    ground.update((int)speed);
    speed += 0.001;
  }

  void check_collisions() {
    dinos_alive = 0;
    for (Dino dino : dinos) {
      for (Enemy enemy : enemies) {
        if (dino.alive && dino.is_collisioning_with(enemy)) {
          dino.die(score);
        }
      }
      if (dino.alive) {
        dinos_alive++;
      }
    }
    if (dinos_alive == 0) {
      next_generation();
    }
  }
  
  void next_generation() {
    score = 0;
    generation++;
    enemies.clear();
    int dinos_score_sum = 0;
    for (Dino dino : dinos) {
      dinos_score_sum += dino.score;
    }
    last_gen_avg_score = dinos_score_sum / DINOS_PER_GENERATION;
    Collections.sort(dinos);
    Collections.reverse(dinos);
    last_gen_max_score = dinos.get(0).score;
    // The best 10% will be kept as they are
    ArrayList<Dino> new_dinos = new ArrayList<Dino>();
    for (int i = 0; i < DINOS_PER_GENERATION * 0.1; i++) {
      new_dinos.add(dinos.get(i));
      new_dinos.get(i).reset();
    }
    // Another 10% will be completely new
    for (int i = 0; i < DINOS_PER_GENERATION * 0.1; i++) {
      new_dinos.add(new Dino());
    }
    // Another 20% will mutate from the best
    for (int i = 0; i < DINOS_PER_GENERATION * 0.1; i++) {
      Dino father = dinos.get(0);
      Dino son = new Dino();
      son.genome = father.genome.mutate();
      son.init_brain();
      new_dinos.add(son);
    }
    // Another 20% will have a father from the best 10% and mutate its brain
    for (int i = 0; i < DINOS_PER_GENERATION * 0.3; i++) {
      Dino father = dinos.get((int)random(DINOS_PER_GENERATION * 0.1));
      Dino son = new Dino();
      son.genome = father.genome.mutate();
      son.init_brain();
      new_dinos.add(son);
    }
    // The last 40% will have a father and a mother from the best 10%
    for (int i = 0; i < DINOS_PER_GENERATION * 0.4; i++) {
      Dino father = dinos.get((int)random(DINOS_PER_GENERATION * 0.1));
      Dino mother = dinos.get((int)random(DINOS_PER_GENERATION * 0.1));
      Dino son = new Dino();
      son.genome = father.genome.crossover(mother.genome);
      son.init_brain();
      new_dinos.add(son);
    }
    dinos = new_dinos;
  }
  
  float[] next_obstacle_info(Dino dino){
    float[] result = {1280, 0, 0, 0, 0};
    for (Enemy enemy : enemies){
      if (enemy.x_pos > dino.x_pos){
        result[0] = enemy.x_pos - dino.x_pos;
        result[1] = enemy.x_pos;
        result[2] = enemy.y_pos;
        result[3] = enemy.obj_width;
        result[4] = enemy.obj_height;
        break;
      }
    } 
    return result;
  }
  
  void print() {
    ground.print();
    for (Enemy enemy : enemies ) {
      enemy.print();
    }
    for (Dino dino : dinos) {
      dino.print();
    }
    display_info();
  }
  
  void display_info(){
    fill(0);
    textSize(30);
    text(score, 1200, 80);
    text("Generation: " + generation, 80, 80);
    text("Average Score (last gen): " + last_gen_avg_score, 80, 120);
    text("Max Score (last gen): " + last_gen_max_score, 80, 160);
    text("Alive: " + dinos_alive, 80, 200);
    }
  
  void tenth_of_second() {
    for (Dino dino : dinos) {
      dino.toggle_sprite();
    }
    score++;
  }
  
  void quarter_of_second() {
    for (Enemy enemy : enemies ) {
      enemy.toggle_sprite();
    }
  }

  void second() {
    if (random(1) < 0.5) {
      enemies.add(new Cactus());
    } else {
      enemies.add(new Bird());
    }
  }
  
}
