﻿
Перем Команда Экспорт;

Функция СведенияОВнешнейОбработке() Экспорт
	
	/// Создаём Структуру для дальнейшей работы, через неё параметры будем перекидывать туда куда надо
	ПараметрыРегистрации = Новый Структура;
	
	// Начинаем набивать параметры в созданную структуру
	
	// ПАРАМЕТР Вид
	// Строка, вид обработки, один из возможных вариантов: "ДополнительнаяОбработка", "ДополнительныйОтчет", "ЗаполнениеОбъекта",
	// "Отчет", "ПечатнаяФорма" или "СозданиеСвязанныхОбъектов"
	// У нас заполнение табличной части – значит, заполнение объекта: "ЗаполнениеОбъекта"
	//
	ПараметрыРегистрации.Вставить("Вид", "ДополнительнаяОбработка");
	
	// ПАРАМЕТР Назначение
	// Массив строк имен объектов метаданных в формате: <ИмяКлассаОбъектаМетаданного>.[ * | <ИмяОбъектаМетаданных>].
	// Например, "Документ.СчетЗаказ" или "Справочник.*".
	
	// Делаем массив для запихивания в параметры регистрации
	//
	Назначение = Новый Массив;
	//Назначение.Добавить("Документ.РасходныйКассовыйОрдер");
	// Запихиваем массив в параметры
	//
	ПараметрыРегистрации.Вставить("Назначение", Назначение);
	
	// ПАРАМЕТР Наименование
	// Наименование обработки, которым будет заполнено наименование элемента справочника,
	// краткое описание для идентификации обработки администратором.
	//
	ПараметрыРегистрации.Вставить("Наименование", "Загрузка из iikoRMS 4.5.3");
	
	// ПАРАМЕТР Версия
	// Версия обработки в формате “<старший номер>.<младший номер>” используется при загрузке обработок в информационную базу.
	//
	ПараметрыРегистрации.Вставить("Версия", "0.001");
	
	// ПАРАМЕТР Безопасный режим
	// Принимает значение Истина или Ложь, в зависимости от того, требуется ли устанавливать или отключать безопасный режим исполнения обработок.
	// Если истина, обработка будет запущена в безопасном режиме.  Более подробно о безопасном режиме см. документацию к платформе 1С:Предприятие.
	//
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	
	// ПАРАМЕТР Информация
	// Краткая информация по обработке, описание обработки.
	//
	ПараметрыРегистрации.Вставить("Информация", "Загрузка из iikoRMS 4.5.3");
	
	// ПАРАМЕТР Таблица Команд – его надо сначала создать
	//
	ТаблицаКоманд = ПолучитьТаблицуКоманд();
	
	// После создания Таблицы Команд – заносим в неё ровно одну команду
	//
	ДобавитьКоманду(ТаблицаКоманд, "Загрузка из iikoRMS 4.5.3", Команда, "ОткрытиеФормы", Истина);
	
	// Забрасываем созданную и заполненную Таблицу Команд в параметры регистрации
	//
	ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);
	
	//
	Возврат ПараметрыРегистрации;
	
КонецФункции

Функция ПолучитьТаблицуКоманд()
	
	// Таблица Команд – это таблица значений – вот её и создаём
	//
	Команды = Новый ТаблицаЗначений;
	
	// Начинаем делать колонки для таблицы команд
	
	// КОЛОНКА Представление
	// Представление – представление команды в пользовательском интерфейсе;
	//
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	
	// КОЛОНКА Идентификатор
	// Идентификатор – идентификатор команды; любая строка, уникальная в пределах данной обработки (отчета). 
	// Для обработок с печатными формами на основе макета табличного документа должен содержать список макетов, на основе которых нужно получить печатную форму (см. описание параметра ИменаМакетов процедуры УправлениеПечатьюКлиент.ВыполнитьКомандуПечати в разделе Печать).
	//
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка"));
	
	// КОЛОНКА Использование 
	// Использование – вариант запуска команды – их всего Три – они задаются строками:
	// ● "ОткрытиеФормы" – открыть форму обработки;
	// ● "ВызовКлиентскогоМетода" – вызвать клиентскую экспортную процедуру из модуля формы обработки;
	// ● "ВызовСерверногоМетода" – вызвать серверную экспортную процедуру из модуля объекта обработки.
	//
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
	
	// КОЛОНКА Показывать Оповещение
	// ПоказыватьОповещение – Истина, если требуется показать оповещение при начале и при завершении работы обработки. Например, при запуске обработки без открытия формы.
	//
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
	
	// КОЛОНКА Модификатор
	// Модификатор – дополнительный модификатор команды. Используется для дополнительных обработок печатных форм на основе табличных макетов, для таких команд должен содержать строку ПечатьMXL (см. пример в демонстрационной конфигурации Библиотеки Стандартных Подсистем).
	//
	Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка"));
	
	// Созданную пустую таблицу возвращают назад
	Возврат Команды;
	
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")
	
	НоваяКоманда = ТаблицаКоманд.Добавить();
	НоваяКоманда.Представление = Представление;
	НоваяКоманда.Идентификатор = Идентификатор;
	НоваяКоманда.Использование = Использование;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
	НоваяКоманда.Модификатор = Модификатор;
	
КонецПроцедуры

Команда = "Команда";
