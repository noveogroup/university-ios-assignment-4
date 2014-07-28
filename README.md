iOS. Лабораторная работа 4
==========================

Написать программу сериализующую Objective-C объекты в человеко-читаемый формат. Для демонстрации возможностей программы разработать несколько наборов тестовых данных, которые необходимо составить так, чтобы можно было продемонстрировать 3 ошибки разного рода (например, "переданный объект не является словарем", "переданный словарь содержит объект недопустимого типа", "один из ключей является объектом недопустимого типа").

Список требований, предъявляемых к программе.
---------------------------------------------

1. Cериализатор на входе должен принимать только объекты класса NSDictionary (тип входного параметра - id), а на выход должен отдавать объект класса NSString. В случае, если во время сериализации произошла ошибка, то на выход должен быть отправлен nil. Вместе с этим у пользователя класса должна иметься возможность получить сведения о случившейся ошибке (пользоваться которой он будет по желанию). Передачу сведений об ошибке реализовать _стандартным способом_ (по средствам т.н. out-параметра).
2. Сериализуемые словари могут включать в себя объекты всех указанных выше типов (классов), а ключами в них могут быть только строки и / или числа.
3. Сериализуемые коллекции (множества и массивы) могут включать в себя объекты всех указанных выше типов (классов).
4. Уровень вложенности структуры данных не ограничен.
5. Сведения об ошибке должны включать в себя как код ошибки (выраженный ввиде одного из элементов перечисления), так и детальное описание (например, указать класс объекта, который привел к возникновению проблемы).

Поддерживаемые типы (классы) объектов
-------------------------------------

  * NSDictionary,
  * NSArray,
  * NSSet,
  * NSNumber,
  * NSNull,
  * CGRect (обернутый в NSValue).

Комментарии к реализации
========================

Сериализатор протестирован с помощью юнит-тестов (встроенных в XCode). Чтобы в консоли что-то вывелось - запускайте через Product -> Test