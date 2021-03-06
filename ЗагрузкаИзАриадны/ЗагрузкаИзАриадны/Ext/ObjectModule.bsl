﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает сведения о внешней обработке.
//
// Возвращаемое значение:
//   Структура - Подробнее см. ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке().
//
Функция СведенияОВнешнейОбработке() Экспорт
	
	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке("2.2.2.1");
	ПараметрыРегистрации.Информация = НСтр("ru = 'Загрузка данных из МИС Ариадна.'");
	ПараметрыРегистрации.Вид = ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка();
	ПараметрыРегистрации.Версия = "1.0.0.1";
	ПараметрыРегистрации.БезопасныйРежим = Ложь;
	
	Команда = ПараметрыРегистрации.Команды.Добавить();
	Команда.Представление = НСтр("ru = 'Загрузка данных из МИС Ариадна'");
	Команда.Идентификатор = "ФормаЗагрузки";
	Команда.Использование = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	Команда.ПоказыватьОповещение = Истина;
	
	//Разрешение = РаботаВБезопасномРежиме.РазрешениеНаСозданиеCOMКласса("Excel.Application", "00024500-0000-0000-C000-000000000046");
	//ПараметрыРегистрации.Разрешения.Добавить(Разрешение);
	//
	//Разрешение = РаботаВБезопасномРежиме.РазрешениеНаСозданиеCOMКласса("ADODB.Connection", "00000514-0000-0010-8000-00AA006D2EA4");
	//ПараметрыРегистрации.Разрешения.Добавить(Разрешение);
	
	Возврат ПараметрыРегистрации;
	
КонецФункции

#КонецОбласти

#КонецЕсли