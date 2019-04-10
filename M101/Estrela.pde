class Estrela {

  private PVector posicao;
  private color cor;
  private float raio;
  
  Estrela(PVector posicao, color cor, float raio) {
    this.posicao = posicao;
    this.cor = cor;
    this.raio = raio;
  }
  
  void desenharEstrela() {
    strokeWeight(raio);
    stroke(red(cor)*1.3, green(cor)*1.3, blue(cor)*1.3, 200);
    point(posicao.x, posicao.y, posicao.z);
  } 
}