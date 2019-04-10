class Dados
{

  Table tabela;
  String nome;
  
  Dados(String nome)
  {
    
    tabela = loadTable(nome);
  
  }
  
  float[] receberDado()
  {
    
    int m = tabela.getRowCount();
    int n = tabela.getColumnCount();
    
    int escolha = int(random(1, m));
    float x[] = new float[n - 1];

    for(int i = 1; i < n; i++)
      x[i - 1] = tabela.getFloat(escolha, i);
  
    nome = tabela.getString(escolha, 0);

    return x;

  }
  float[] receberDado(int escolha)
  {
    
    int m = tabela.getRowCount();
    int n = tabela.getColumnCount();
    
    float x[] = new float[n - 1];

    for(int i = 1; i < n; i++)
      x[i - 1] = tabela.getFloat(escolha, i);
  
    nome = tabela.getString(escolha, 0);
  
    return x;
  
  }
}