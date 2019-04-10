class Neuronio
{

  // Conexão sináptica
  float w[];
  
  // Ativacão do neurônio
  float ativacao;

  // Saida do neurônio
  float disparo;
  
  // Posição do neurônio
  PVector posicao;

  Neuronio(int numSinapses, PVector p)
  {

    //  Inicializa os valores aleatórios 
    //  dos pesos com distribuição normal 
    w = new float[numSinapses];
    for(int i = 0; i < w.length; i++)
      w[i] = randomGaussian();
    
    ativacao = 0;
    disparo = 0;
    posicao = p;
    
  }
  
  void estimulaNeuronio(float x[])
  {
    
     
    // Este procedimento recebe um vetor 
    // característico de entrada que 
    // estimula o neurônio
    ativacao = 0;
    for(int i = 0; i < w.length; i++)
      ativacao += (x[i] - w[i]) * (x[i] - w[i]);      

    if(ativacao < 0.00)
      disparo = 1000000;
    else
      disparo = 1/ativacao;

  }
  
  float distanciaTopologica(Neuronio n)
  {

    return n.posicao.dist(posicao);
  
  }
  
  void corrigeSinapses(float x[], float eta, float h)
  {
    
    //  Aplica a regra de correção das sinapses
    for(int i = 0; i < w.length; i++)
      w[i] += eta * h * (x[i] - w[i]);      

  }
  
  void desenhaNeuronio(float min, float max)
  {

    //  Desenha um círculo que representa 
    //  o neurônio
    fill(lerpColor(COR_2, COR_5, map(disparo, min, max, 0, 1)));
    ellipse(posicao.x, posicao.y, 20, 20);
  
  }
}