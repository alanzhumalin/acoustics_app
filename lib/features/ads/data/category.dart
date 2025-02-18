import 'package:acousticsapp/features/ads/data/sub_category.dart';

class Category {
  final String category;
  final List<Subcategory> subcategories;
  final List<String> brands;

  Category({
    required this.category,
    required this.subcategories,
    required this.brands,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      category: json['category'] ?? '',
      subcategories: (json['subcategories'] as List)
          .map((item) => Subcategory.fromJson(item))
          .toList(),
      brands: List<String>.from(json['brands'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'subcategories':
          subcategories.map((subcategory) => subcategory.toJson()).toList(),
      'brands': brands,
    };
  }
}

List<Category> categories = [
  Category(
    category: 'Акустические системы',
    subcategories: [
      Subcategory(
        subcategory: 'Домашняя акустика',
        items: ['Саундбары', 'Стереосистемы', 'Домашние кинотеатры'],
      ),
      Subcategory(
        subcategory: 'Портативные колонки',
        items: ['Bluetooth-колонки', 'Умные колонки'],
      ),
      Subcategory(
        subcategory: 'Профессиональная акустика',
        items: ['Активные', 'Пассивные', 'Линейные массивы'],
      ),
      Subcategory(
        subcategory: 'Автомобильная акустика',
        items: ['Коаксиальные', 'Компонентные', 'Сабвуферы'],
      ),
      Subcategory(
        subcategory: 'Сабвуферы',
        items: ['Активные', 'Пассивные'],
      ),
    ],
    brands: [
      'JBL',
      'Yamaha',
      'Bose',
      'Harman Kardon',
      'Sony',
      'Marshall',
      'Bang & Olufsen',
      'Bowers & Wilkins',
      'KEF',
      'Klipsch',
      'Focal',
      'Pioneer',
      'Onkyo',
      'Audioengine',
      'Polk Audio',
      'Cerwin-Vega',
      'HK Audio',
      'Peavey',
      'RCF',
      'Soundking',
      'Turbosound',
      'Yamaha',
      'SVS',
      'Electro-Voice',
      'L-Acoustics',
      'dbTechnologies',
      'Dynacord',
      'Cambridge Audio',
      'Paradigm',
      'MartinLogan',
      'Definitive Technology',
      'Dynaudio',
      'Tannoy',
      'Monitor Audio',
      'Sonos',
      'Samson',
      'Atlantic Technology',
      'Bose',
      'Vifa',
      'Elac',
      'Другие',
    ],
  ),
  Category(
    category: 'Усилители',
    subcategories: [
      Subcategory(
        subcategory: 'Типы усилителей',
        items: [
          'Стереоусилители',
          'Ламповый усилитель',
          'Усилители для наушников',
          'Многоканальные усилители'
        ],
      ),
    ],
    brands: [
      'Peavey',
      'RCF',
      'Dynacord',
      'L-Acoustics',
      'Marantz',
      'Denon',
      'Pioneer',
      'Behringer',
      'Crown',
      'Electro-Voice',
      'Focusrite',
      'JBL',
      'Lab Gruppen',
      'Cambridge Audio',
      'Onkyo',
      'Rotel',
      'NAD',
      'Harman Kardon',
      'McIntosh',
      'Luxman',
      'Yamaha',
      'Accuphase',
      'Bowers & Wilkins',
      'Audio Research',
      'Parasound',
      'Bryston',
      'Ayon Audio',
      'Cary Audio',
      'Primare',
      'Rega',
      'Vitus Audio',
      'Classe',
      'Arcam',
      'Другие',
    ],
  ),
  Category(
    category: 'Процессор',
    subcategories: [
      Subcategory(
        subcategory: 'Микшерные пульты',
        items: ['Аналоговые', 'Цифровые', 'Активные'],
      ),
      Subcategory(
        subcategory: 'Аудиопроцессоры',
        items: ['Аналоговые кроссоверы', 'Цифровые процессоры', 'Эквалайзеры'],
      ),
    ],
    brands: [
      'Behringer',
      'Soundcraft',
      'Allen & Heath',
      'Mackie',
      'PreSonus',
      'Tascam',
      'Roland',
      'Yamaha',
      'Avid',
      'Midas',
      'Neve',
      'API',
      'SSL',
      'Waves',
      'Lexicon',
      'BSS Audio',
      'Dynacord',
      'Empirical Labs',
      'Eventide',
      'Focusrite',
      'Sennheiser',
      'RME',
      'Aphex',
      'Warm Audio',
      'Другие',
    ],
  ),
  Category(
    category: 'Микрофоны',
    subcategories: [
      Subcategory(
        subcategory: 'Микрофоны',
        items: [
          'Студийные',
          'Вокальные',
          'Инструментальные',
          'Конденсаторные',
          'Динамические',
          'Петличные'
        ],
      ),
      Subcategory(
        subcategory: 'Радиосистемы',
        items: [
          'Вокальные',
          'Инструментальные',
          'Головные',
          'Петличные',
          'Передатчики',
          'Приемники'
        ],
      ),
    ],
    brands: [
      'Sennheiser',
      'RØDE',
      'Audio-Technica',
      'AKG',
      'Neumann',
      'Beyerdynamic',
      'sE Electronics',
      'Takstar',
      'Electro-Voice',
      'Blue Microphones',
      'Samson',
      'MXL',
      'Tascam',
      'Pioneer',
      'Sony',
      'Zoom',
      'Shure',
      'AKG',
      'DPA Microphones',
      'Sanken',
      'Bose',
      'Audio Pro',
      'Aston Microphones',
      'Другие',
    ],
  ),
  Category(
    category: 'Инструменты',
    subcategories: [
      Subcategory(
        subcategory: 'Гитары',
        items: [
          'Классические',
          'Акустические',
          'Укулеле',
          'Электроакустические',
          'Электрогитара',
          'Бас-гитара'
        ],
      ),
      Subcategory(
        subcategory: 'Клавишные',
        items: ['MIDI-клавиатура', 'Синтезатор', 'Цифровые пианино'],
      ),
      Subcategory(
        subcategory: 'Ударные',
        items: ['Электронные барабаны', 'Акустические барабаны'],
      ),
      Subcategory(
        subcategory: 'Гитарное усиление',
        items: ['Комбоусилители', 'Футсвичи', 'Предусилители'],
      ),
    ],
    brands: [
      'Aria Guitar',
      'Enya',
      'Epiphone',
      'Kepma',
      'Peavey',
      'Fender',
      'Gibson',
      'Ibanez',
      'Yamaha',
      'Roland',
      'Korg',
      'Epiphone',
      'Gretsch',
      'PRS',
      'Jackson',
      'Schecter',
      'ESP',
      'Orange',
      'Marshall',
      'Mesa/Boogie',
      'Laney',
      'Line 6',
      'BOSS',
      'Electro-Harmonix',
      'Fender',
      'Vox',
      'Bugera',
      'Blackstar',
      'Squier',
      'Takamine',
      'Другие',
    ],
  ),
  Category(
    category: 'Оркестровые инструменты',
    subcategories: [
      Subcategory(
        subcategory: 'Типы инструментов',
        items: ['Аккордеоны и баяны', 'Губные гармошки', 'Духовые инструменты'],
      ),
    ],
    brands: [
      'Cascha',
      'Hohner',
      'Yamaha',
      'Roland',
      'Suzuki',
      'Scherz',
      'Weltmeister',
      'Scandalli',
      'Cavagnolo',
      'Mauro',
      'HoHner',
      'Другие',
    ],
  ),
  Category(
    category: 'Гитарные аксессуары',
    subcategories: [
      Subcategory(
        subcategory: 'Аксессуары',
        items: [
          'Процессоры и педали эффектов',
          'Тюнеры и метрономы',
          'Кейсы и чехлы для гитар',
          'Стойки и кронштейны',
          'Струны',
          'Гитарные аксессуары'
        ],
      ),
    ],
    brands: [
      'Aria Guitar',
      'Behringer',
      'Cascha',
      "D'Addario",
      'Enya',
      'Emie Ball',
      'Fender',
      'Line 6',
      'Nomad',
      'Peavey',
      'Proel',
      'Hercules',
      'Rockdale',
      'Soundking',
      'Cherub',
      'RockStel',
      'Boss',
      "D'Addario",
      'Ernie Ball',
      'Fender',
      'Jim Dunlop',
      'Planet Waves',
      'Mooer',
      'TC Electronic',
      'Electro-Harmonix',
      'Vox',
      'Line 6',
      'Ibanez',
      'MXR',
      'Pedaltrain',
      'Keeley',
      'Другие',
    ],
  ),
  Category(
    category: 'Комплектующие для клавишных',
    subcategories: [
      Subcategory(
        subcategory: 'Аксессуары',
        items: ['Банкетки для пианино', 'Педали', 'Стойки', 'Кейсы и чехлы'],
      ),
    ],
    brands: [
      'Alesis',
      'Artesia',
      'Gewa',
      'Hercules',
      'M-Audio',
      'Nektar Tech',
      'Nomad',
      'Novation',
      'Nux',
      'Proel',
      'Rockdale',
      'Roland',
      'Soundking',
      'Yamaha',
      'Bespeco',
      'Cherub',
      'RockStel',
      'Gravity',
      'Casio',
      'Yamaha',
      'Korg',
      'Roland',
      'Nord',
      'Kurzweil',
      'Alesis',
      'M-Audio',
      'Behringer',
      'Другие',
    ],
  ),
  Category(
    category: 'DJ-оборудование',
    subcategories: [
      Subcategory(
        subcategory: 'Оборудование',
        items: ['DJ-контроллеры', 'Вертушки', 'DJ-микшеры'],
      ),
    ],
    brands: [
      'Pioneer DJ',
      'Numark',
      'Denon DJ',
      'Technics',
      'Rane',
      'Native Instruments',
      'Traktor',
      'Serato',
      'Allen & Heath',
      'Behringer',
      'Gemini',
      'Другие',
    ],
  ),
  Category(
    category: 'Кабели и аксессуары',
    subcategories: [
      Subcategory(
        subcategory: 'Аксессуары',
        items: [
          'Аудиокабели (XLR, Jack, RCA)',
          'Стойки и подвесы',
          'Чехлы и кейсы',
          'Прочее'
        ],
      ),
    ],
    brands: [
      'Allen & Heath',
      'Audac',
      'Behringer',
      'dbTechnologies',
      'Dynacord',
      'Electro-Voice',
      'HK Audio',
      'JBL',
      'L-Acoustics',
      'Nomad',
      'Mackie',
      'Proel',
      'RCF',
      'Soundking',
      'Turbosound',
      'Yamaha',
      'Neutrik',
      'Mogami',
      'Hosa',
      'Belden',
      'Canare',
      'Lindell Audio',
      'Furutech',
      'Wireworld',
      'Gotham',
      'Другие',
    ],
  ),
];
