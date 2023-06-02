float[] matrix_vector_multiplication(float[][] matrix, float[] vector) {
  float[] result = new float[matrix.length];
  for (int i = 0; i < matrix.length; i++) {
    float sum = 0;
    for (int j = 0; j < matrix[0].length; j++) {
      sum += matrix[i][j] * vector[j];
    }
    result[i] = sum;
  }
  return result;
}

float[][] zeroes_matrix(int rows, int cols) {
  float[][] matrix = new float[rows][cols];
  for (int i = 0; i < rows; i++) {
    matrix[i] = new float[cols];
    for (int j = 0; j < cols; j++) {
      matrix[i][j] = 0;
    }
  }
  return matrix;
}

float[] random_vector(int size) {
  float[] vector = new float[size];
  for (int i = 0; i < size; i++) {
    vector[i] = random(-1, 1);
  }
  return vector;
}
