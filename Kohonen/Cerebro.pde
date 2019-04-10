class Cerebro
{

  Neuronio celulasNervosas[];

  //  Neurônio que responde melhor a um 
  //  estimo num determinado tempo discreto
  int 
    neuronioVencedor
  , neuronioPerdedor;

  // Parâmetros do treinamento
  float 
    sigma
  , eta
  , alpha
  , beta
  , dt;
  
  int 
    epocas
  , t;
  
  Cerebro(int m, int n, int numSinapses)
  {
  
    neuronioVencedor = 0;
    neuronioPerdedor = 0;

    sigma = 100;
    eta = 0.5;
    epocas = 200;
    dt = 0.000001;
    beta = 1;
    alpha = 0.01;
    t = 0;
        
    // Inicializa os neurônios
    float dX = (float) width/(m + 1);
    float dY = (float) height/(n + 1);
    
    celulasNervosas = new Neuronio[m * n];
    
    for(int i = 0; i < m; i++)
    for(int j = 0; j < n; j++)
      celulasNervosas[n * i + j] = 
        new Neuronio(
              numSinapses
            , new PVector(dX + i * dX, dY + j * dY)
        );    
  }
  
  void estimulaRede(float x[])
  {
    
    // Procura o neurônio que responde melhor ao estímulo
    neuronioVencedor = 0;
    for(int i = 0; i < celulasNervosas.length; i++)
    {
      
      celulasNervosas[i].estimulaNeuronio(x);
      if(celulasNervosas[i].ativacao < celulasNervosas[neuronioVencedor].ativacao)
        neuronioVencedor = i;

      else if(celulasNervosas[i].ativacao > celulasNervosas[neuronioPerdedor].ativacao)
        neuronioPerdedor = i;
        
    }
  }
  
  boolean redeTreinada()
  {
  
    if(t > epocas)
      return true;
    else
      return false;
    
  }
  
  void treinaRede(float x[])
  {
    
    t += 1;
    
    sigma = sigma * exp(-t * dt * alpha);
    eta = eta * exp(-t * dt * beta);
 
    float 
      d = 0
    , h = 0;

    estimulaRede(x);

    for(int i = 0; i < celulasNervosas.length; i++)
    {
      
      d = celulasNervosas[i].distanciaTopologica(celulasNervosas[neuronioVencedor]);
      h = exp(-(d * d)/(2 * sigma * sigma));
      
      celulasNervosas[i].corrigeSinapses(x, eta, h);

    }
  }
  
  void desenhaRede()
  {
    
    noStroke();
    for(int i = 0; i < celulasNervosas.length; i++)
      celulasNervosas[i].desenhaNeuronio(
          celulasNervosas[neuronioPerdedor].disparo
        , celulasNervosas[neuronioVencedor].disparo  
      );
      
  }
}