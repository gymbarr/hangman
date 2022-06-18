# Интегральный тест игры hangman_v3

# Подключаем класс Game, который будем тестировать
# Подключаем билиотеку ввода-вывода
require 'game'
require 'stringio'

describe Game do

  # Перед каждым тестом создаем экземпляр класса Game и передаем в него загадываемое слово
  before :each do
    @game = Game.new "счастье"
  end

  # Созданный объект game должен быть типом Game
  describe "#new" do
      it "takes one parameter and returns a Game object" do
          @game.should be_an_instance_of Game
      end
  end

  # Тест на победный сценарий
  it 'should win' do
    # Передаем в цикле буквы слова счастье, повторные буквы удаляем методом uniq
    ['с', 'ч', 'а', 'с', 'т', 'ь', 'е'].uniq.each do |letter|
      # Эта строка вместо ввода данных от пользователя подставляет буквы из цикла
      allow($stdin).to receive(:gets).and_return(letter)
      # Вызываем метод запроса от пользователя буквы, который дальше запустит проверку буквы на наличие в загадываемом слове
      @game.ask_next_letter
    end

    # После перебора всех букв переменная статуса игры должна стать равной 1
    expect(@game.status).to eq 1
    # Так как мы подставили все правильные букву в цикл, то счетчик ошибок будет равен 0
    expect(@game.errors).to eq 0
  end

  # Тест на проигрышный сценарий
  it 'should loose' do
    # Передаем в цикле неправильные буквы
    ['а', 'б', 'в', 'г', 'д', 'е', 'ж', 'з', 'и', 'к'].uniq.each do |letter|
      allow($stdin).to receive(:gets).and_return(letter)
      @game.ask_next_letter
    end

    # Статус игры должен стать равным -1
    expect(@game.status).to eq -1
    # Счетчик ошибок равным 7
    expect(@game.errors).to eq 7
  end
end
