﻿//ПОДГОТОВКА РЕГИСТРАЦИИ ГЛОБАЛЬНОГО ОТЧЕТА 
Функция СведенияОВнешнейОбработке() Экспорт 
	
	ПараметрыРегистрации = Новый Структура; 
	ПараметрыРегистрации.Вставить("Вид", "ДополнительныйОтчет"); //Варианты: "ДополнительнаяОбработка", "ДополнительныйОтчет", "ЗаполнениеОбъекта", "Отчет", "ПечатнаяФорма", "СозданиеСвязанныхОбъектов" 
	
	
	ПараметрыРегистрации.Вставить("Наименование", "Отчет по статусу актуализации документов СМК"); 
	ПараметрыРегистрации.Вставить("Версия", "1.0"); //"1.0" 
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Истина); //Варианты: Истина, Ложь 
	ПараметрыРегистрации.Вставить("Информация", "Отчет по статусу актуализации документов СМК"); 
	
	ТаблицаКоманд = ПолучитьТаблицуКоманд(); 
	
	ДобавитьКоманду(ТаблицаКоманд, 
	"Отчет по статусу актуализации документов СМК", 
	"Отчет по статусу актуализации документов СМК", 
	"ОткрытиеФормы", //Использование. Варианты: "ОткрытиеФормы", "ВызовКлиентскогоМетода", "ВызовСерверногоМетода" 
	Ложь,//Показывать оповещение. Варианты Истина, Ложь 
	"");//Модификатор 
	
	ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд); 
	
	Возврат ПараметрыРегистрации; 
	
КонецФункции 

Функция ПолучитьТаблицуКоманд() 
	
	Команды = Новый ТаблицаЗначений; 
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка")); 
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка")); 
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка")); 
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево")); 
	Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка")); 
	
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


Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	// + Граховский К.Н. 2018.11.13
	//зададим параметры СКД
	СхемаКомпоновкиДанных.Параметры.Папка.Значение = Справочники.ММЦ_СсылкиНаОбъекты.НайтиПоНаименованию("СМК").СсылкаНаОбъектБазы;
	СхемаКомпоновкиДанных.Параметры.Свойство.Значение = Справочники.ММЦ_СсылкиНаОбъекты.НайтиПоНаименованию("Дата следующей актуализации").СсылкаНаОбъектБазы;
	// - Граховский К.Н. 2018.11.13
	
КонецПроцедуры

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Настройки = КомпоновщикНастроек.ПолучитьНастройки();
	
	КомпановщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпановщикМакета.Выполнить(СхемаКомпоновкиДанных, Настройки, ДанныеРасшифровки);
	
	//Инициализируем процессор СКД
	ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновки, , ДанныеРасшифровки, Истина);
	
	ДокументРезультат.Очистить();
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	ПроцессорВывода.Вывести(ПроцессорКомпоновкиДанных);
	
КонецПроцедуры
