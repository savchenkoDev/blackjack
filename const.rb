require_relative 'card.rb'
MESSAGES = {
  username: 'Введите имя > ',
  distr_answer: %w[Ещё Себе],
  main_menu: ['Новая игра', 'Выход'],
  victory: 'Вы победили дилера',
  loose: 'Вы проиграли все деньги',
  user_over: 'У Вас перебор',
  dealer_over: 'У дилера перебор',
  user_turn: 'Ваш ход',
  dealer_turn: 'Ход дилера',
  dealer_take_card: 'Дилер взял карту',
  bank_calculate: 'Подсчет банка',
  equal: 'В этой разадче поровну',
  user_win: 'Вы выиграли раздачу',
  dealer_win: 'Дилер выиграл раздачу',
  next_distr: ['Следующая раздача', 'Выход']
}.freeze

BET = 10
