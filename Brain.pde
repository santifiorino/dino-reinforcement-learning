class Brain {
  
  float[] outputs = {1, 0};
  float[][] hidden_layer_weights;
  float[] hidden_layer_bias;
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
     float[] hidden_outputs = matrix_vector_multiplication(hidden_layer_weights, input_layer_values);
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
  
}
