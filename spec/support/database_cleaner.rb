RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
 
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end
 
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end
 
  config.before(:each) do
    DatabaseCleaner.start
  end
 
  config.after(:each) do
    DatabaseCleaner.clean
  end
  
  config.after(:all) do
    # Testes configurados com before(:all) NÃO são limpos do banco automaticamente, eles
    # precisam de um bloco after(:all) limpando sua configuração antes do próximo teste.
    # Este bloco garante que sempre haverá o cleanup do banco entre dois arquivos de testes, 
    # caso alguém esqueça de limpar o teste num after(:all)
    DatabaseCleaner.clean_with(:deletion)
  end
end