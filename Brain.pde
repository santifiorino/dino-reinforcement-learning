class Brain {
  
  float[] inputs;
  float[] outputs = {1, 0};
  float[][] hidden_layer_weights;
  float[] hidden_layer_bias;
  float[] hidden_outputs;
  float[][] output_layer_weights;
  float[] output_layer_bias;
  
  
  Brain(Genome genome) {
    // Initialize weights and biases from genome
    hidden_layer_weights = zeroes_matrix(7, 7);
    output_layer_weights = zeroes_matrix(2, 7);
    for (Gen gen : genome.genes) {
      if (gen.source_hidden_layer) {
        hidden_layer_weights[gen.id_target_neuron][gen.id_source_neuron] = gen.weight;
      } else {
        output_layer_weights[gen.id_target_neuron][gen.id_source_neuron] = gen.weight;
      }
    }
    hidden_layer_bias = genome.hidden_layer_bias;
    output_layer_bias = genome.output_layer_bias;
  }
  
  void feed_forward(float[] input_layer_values) {
     inputs = input_layer_values;
     hidden_outputs = matrix_vector_multiplication(hidden_layer_weights, input_layer_values);
     for (int i = 0; i < hidden_outputs.length; i++) {
       hidden_outputs[i] += hidden_layer_bias[i];
       hidden_outputs[i] = ReLU(hidden_outputs[i]);
     }
     outputs = matrix_vector_multiplication(output_layer_weights, hidden_outputs);
      for (int i = 0; i < outputs.length; i++) {
        outputs[i] += output_layer_bias[i];
        outputs[i] = ReLU(outputs[i]);
      }
  }

  float ReLU(float x) {
    return max(0, x);
  }
  
  void set_neural_connection_stroke(float weight){
    if (weight > 0){
      stroke(0, 255, 0);
    } else if (weight < 0) {
      stroke(255, 0, 0);
    } else {
      stroke(200);
    }
    weight = abs(weight);
    weight = map(weight, 0, 1, 0.5, 5);
    strokeWeight(weight);
  }
  
  void print() {
    fill(0);
    textSize(16);
    text("(obstacle) distance", 550, 67);
    text("(obstacle) x", 598, 107);
    text("(obstacle) y", 598, 147);
    text("(obstacle) width", 568, 187);
    text("(obstacle) height", 563, 227);
    text("(dino) y", 625, 267);
    text("(game) speed", 586, 307);
    text("jump", 927, 168);
    text("crouch", 925, 208);
    
    for (int i = 0; i < 7; i++){
      // Input layer to hidden layer lines
      for (int j = 0; j < 7; j++){
        float weight = hidden_layer_weights[i][j];
        set_neural_connection_stroke(weight);
        line(700 + 16, 64+i*40, 800 - 16, 64+j*40);
      }
      // Hidden layer to output layer lines
      for (int j = 0; j < 2; j++){
        float weight = output_layer_weights[j][i];
        set_neural_connection_stroke(weight);
        line(800 + 16, 64 + i * 40, 900 - 16, 165 + j * 40);
      }
      // Input layer circles
      strokeWeight(1);
      stroke(83);
      fill(255);
      circle(700, 64 + i * 40, 32);
      // Hidden layer circles
      stroke(0);
      if (hidden_outputs[i] == 0){
        fill(255);
      } else {
        fill(170);
      }
      circle(800, 64 + i * 40, 32);
      // Input texts
      textSize(11);
      fill(0);
      if (inputs[i] > 99){
        text(inputs[i], 688, 68+i*40);
      } else {
        text(inputs[i], 688, 68+i*40);
      }
    }
    // Output circles
      if (outputs[0] == 0){
        fill(255);
      } else {
          fill(170);
      }
      circle(900, 165, 32);
      if (outputs[1] == 0){
          fill(255);
      } else {
          fill(170);
      }
      circle(900, 205, 32);
  }
  
}
