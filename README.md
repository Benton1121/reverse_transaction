# README

## HOW TO CHECK

Basically, all functions covered with rspec.
To run tests use `budle exec rspec`

## Task

Подготовить тестовый проектик на Ruby on Rails
Хоть в каком то виде, нас интересует ваш подход

Предположим есть Заказы
Заказы принадлежат юзерам
У заказов статусы, что то типо создано, успешный, отменен
У юзеров есть счета (с балансом)

При переводе созданного заказа в успех проводим транзакцию по счету, баланс правим

При отмене уже успешного заказа сторнируем транзакцию, баланс правим.

## TODO list

- [x] Implement desired functional
- [X] Test coverage for it
- [ ] Add more guards and checks
