final color COR_1 = #004358;
final color COR_2 = #137BFF;
final color COR_3 = #bedb39;
final color COR_4 = #ffe11a;
final color COR_5 = #FF1313;

Cerebro c;
Dados d;

void setup()
{
  
  size(700, 700);
  background(COR_1);
  frameRate(200);
  noStroke();
  
  c = new Cerebro(20, 20, 17);
  d = new Dados("data/animais.csv");
  
  textFont(loadFont("data/Courier10PitchBT-Bold-20.vlw"));
  textAlign(CENTER);
  
}

void draw()
{
  
  background(COR_1);
  
  if(!c.redeTreinada())
    c.treinaRede(d.receberDado());
  else
    text("Rede treinada", -300, -200);

  c.desenhaRede();
  fill(255);
  text(d.nome, c.celulasNervosas[c.neuronioVencedor].posicao.x, c.celulasNervosas[c.neuronioVencedor].posicao.y);
    
}

void keyPressed()
{
  
  if(key == 'a') // Pombo
    c.estimulaRede(d.receberDado(1));
  else if(key == 'b')
    c.estimulaRede(d.receberDado(2));
  else if(key == 'c')
    c.estimulaRede(d.receberDado(3));
  else if(key == 'd')
    c.estimulaRede(d.receberDado(4));
  else if(key == 'e')
    c.estimulaRede(d.receberDado(5));
  else if(key == 'f')
    c.estimulaRede(d.receberDado(6));
  else if(key == 'g')
    c.estimulaRede(d.receberDado(7));
  else if(key == 'h')
    c.estimulaRede(d.receberDado(8));
  else if(key == 'i')
    c.estimulaRede(d.receberDado(9));
  else if(key == 'j')
    c.estimulaRede(d.receberDado(10));
  else if(key == 'k')
    c.estimulaRede(d.receberDado(11));
  else if(key == 'l')
    c.estimulaRede(d.receberDado(12));
  else if(key == 'm')
    c.estimulaRede(d.receberDado(13));
  else if(key == 'n')
    c.estimulaRede(d.receberDado(16));
  else if(key == 'o')
    c.estimulaRede(d.receberDado(15));
  else if(key == 'p')
    c.estimulaRede(d.receberDado(14));
  
}