﻿
&НаКлиенте
Процедура Печать(Команда)
		
	Если ПроверитьЗаполнение() Тогда
		
		КоллекцияПечатныхФорм = ПолучитьКоллекциюПечатныхФормНаСервере();
		
		Если ТипЗнч(КоллекцияПечатныхФорм) = Тип("Массив") Тогда
			КлючУникальности = Строка(Новый УникальныйИдентификатор);
			ПараметрыОткрытия = Новый Структура("ИмяМенеджераПечати, ИменаМакетов, ПараметрКоманды, ПараметрыПечати");
			ПараметрыОткрытия.ПараметрКоманды = Новый Массив;
			ПараметрыОткрытия.ПараметрыПечати = Новый Структура;
			ПараметрыОткрытия.Вставить("КоллекцияПечатныхФорм", КоллекцияПечатныхФорм);
			ПараметрыОткрытия.Вставить("ОбъектыПечати",			Новый СписокЗначений);

			ОткрытьФорму("ОбщаяФорма.ПечатьДокументов", ПараметрыОткрытия, ЭтаФорма.ВладелецФормы, КлючУникальности);
			ЭтаФорма.Закрыть();
		Иначе
			ПоказатьПредупреждение(, "Ошибка при формировании печатной формы", 30, "Ошибка");
		КонецЕсли;
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Функция ПолучитьКоллекциюПечатныхФормНаСервере()
	
	Результат = Новый Массив;
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	
	КоллекцияПечатныхФорм = УправлениеПечатью.ПодготовитьКоллекциюПечатныхФорм(ОбработкаОбъект.Метаданные().Имя);
	
	ПараметрыОткрытия = Новый Структура("ИмяМенеджераПечати, ИменаМакетов, ПараметрКоманды, ПараметрыПечати");
	ПараметрыОткрытия.ПараметрКоманды = Новый Массив;
	ПараметрыОткрытия.ПараметрыПечати = Новый Структура;
	ПараметрыОткрытия.Вставить("КоллекцияПечатныхФорм", КоллекцияПечатныхФорм);
	ПараметрыОткрытия.Вставить("ОбъектыПечати",			Новый СписокЗначений);
	
	ОбработкаОбъект.Печать(ОбъектыНазначения.ВыгрузитьЗначения(), КоллекцияПечатныхФорм, ОбъектыНазначения, ПараметрыОткрытия);
	
	Результат = ОбщегоНазначения.ТаблицаЗначенийВМассив(КоллекцияПечатныхФорм);
	
	Возврат Результат;
	
КонецФункции
