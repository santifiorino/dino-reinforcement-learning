class Gen {
  
  boolean source_hidden_layer;
  int id_source_neuron;
  int id_target_neuron;
  float weight;
  
  Gen(){
    source_hidden_layer = (random(1) < 0.5);
    id_source_neuron = (int)random(0, 7);
    if (source_hidden_layer){
      id_target_neuron = (int)random(0, 7);
    } else {
      id_target_neuron = (int)random(0, 2);
    }
    weight = random(-1000, 1000);
  }
  
}

class Genome {
  
  int length;
  ArrayList<Gen> genes;
  float[] hidden_layer_bias;
  float[] output_layer_bias;

  Genome(){
    length = 16;
    genes = new ArrayList<Gen>();
    for (int i = 0; i < length; i++){
      genes.add(new Gen());
    }
    hidden_layer_bias = new float[7];
    output_layer_bias = new float[2];
    for (int i = 0; i < 7; i++){
      hidden_layer_bias[i] = random(-1, 1);
    }
    for (int i = 0; i < 2; i++){
      output_layer_bias[i] = random(-1, 1);
    }
  }
  
  Genome mutate() {
    // return a copy of the genome with a random mutation
    Genome mutated_genome = new Genome();
    for (int i = 0; i < length; i++){
      mutated_genome.genes.set(i, genes.get(i));
    }
    int amount_of_mutations = (int)random(1, 5);
    for (int i = 0; i < amount_of_mutations; i++){
      int index = (int)random(0, length);
      mutated_genome.genes.set(index, new Gen());
    }
    for (int i = 0; i < 7; i++){
      mutated_genome.hidden_layer_bias[i] = hidden_layer_bias[i];
    }
    return mutated_genome;
  }

  Genome crossover(Genome anotherGenome) {
    Genome crossed_genome = new Genome();
    for (int i = 0; i < length; i++){
      crossed_genome.genes.set(i, genes.get(i));
    }
    for (int i = 0; i < 7; i++){
      crossed_genome.hidden_layer_bias[i] = hidden_layer_bias[i];
    }
    int amount_of_crossovers = (int)random(1, 5);
    for (int i = 0; i < amount_of_crossovers; i++){
      int index = (int)random(0, length);
      crossed_genome.genes.set(index, anotherGenome.genes.get(index));
    }
    return crossed_genome;
  }
}
