# BailanystaIOS
README.md только для IOS приложения.
Backend: ( [https://github.com/tgsanzh/BailanystaBackend](https://github.com/tgsanzh/BailanystaAppBackend) )


Bailanysta - Социальная сеть по типу Threads где можно поделиться своими мыслями или создать обсуждение.

Как установить и запустить:
1. Установить и запустить бэкенд. (README.me бэкенда).
2. Установить полный проект.
Либо же установить приложение на свой телефон .

- Описание процесса проектирования и разработки.
  
  1. Изначально надо создать темы. Это необходимо чтобы при изменении цвета, меняли только с AppTheme
  2. Далее я создал главный NavigationStack.
  3. И уже начал делать все скрины.

- Информацию об уникальных подходах или методологиях, использованных в работе.

  Как Андройд разработчик и новичок в IOS разработке, я взял адаптированный под IOS архитектуру.
  Я использовал Clean Architecture и разделил все на слои. Также я использовал принципы SOLID, KISS, и постарался использовать DRY.
  Постарался обеспечить масштабируемость и тестируемость.
  

- Обсуждение компромиссов, принятых во время разработки.

Главный компромисс это время, много чего урезал чтобы успеть.
  
- Описание известных ошибок или проблем в приложении.

  Нету пагинации, сразу все данные придут что плохая практика.
  Не переиспользовал лист постов, и не создал свой репозитории для постов.
  ViewModel не пересоздается каждый раз, из-за чего ошибка при выходе с аккаунта.

- Объясните почему выбрали этот технический стэк

  Я использовал самый актуальные технологии для iOS разработки.

<img width="302" height="656" alt="Simulator Screenshot - iPhone 16 Pro - 2026-09-06 at 13 31 57" src="https://github.com/user-attachments/assets/4441b2ce-2f06-4003-b4a9-6f8e068eaef4" />
<img width="302" height="656" alt="Simulator Screenshot - iPhone 16 Pro - 2026-09-06 at 13 32 21" src="https://github.com/user-attachments/assets/c8cbf69e-5a30-4cdb-91dc-4ea56643eb67" />
<img width="302" height="656" alt="Simulator Screenshot - iPhone 16 Pro - 2026-09-06 at 13 31 34" src="https://github.com/user-attachments/assets/d2604740-9763-4d8d-a380-08fc42f17b64" />
<img width="302" height="656" alt="Simulator Screenshot - iPhone 16 Pro - 2026-09-06 at 13 23 51" src="https://github.com/user-attachments/assets/911e886e-a08a-465b-a0a4-8d6bd5825a23" />
<img width="302" height="656" alt="Simulator Screenshot - iPhone 16 Pro - 2026-09-06 at 13 32 01" src="https://github.com/user-attachments/assets/205b7ccd-f18c-478b-8721-3778ab770bd3" />
