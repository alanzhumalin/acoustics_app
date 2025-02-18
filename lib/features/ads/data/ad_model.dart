import 'package:acousticsapp/features/ads/data/categories_selection.dart';

class AdModel {
  final String title;
  final String description;
  final String price;
  final String nameOfCustomer;
  final String phoneNumber;
  final String city;
  final DateTime createdAt;
  final String condition;
  final String id;
  final List<String> latLng;
  final List<String> adImages;
  final CategorySelection categorySelection;

  AdModel({
    required this.title,
    required this.description,
    required this.price,
    required this.nameOfCustomer,
    required this.phoneNumber,
    required this.city,
    required this.createdAt,
    required this.condition,
    required this.id,
    required this.latLng,
    required this.adImages,
    required this.categorySelection,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      nameOfCustomer: json['nameOfCustomer'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      city: json['city'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      condition: json['condition'] ?? '',
      id: json['id'] ?? '',
      latLng: List<String>.from(json['latLng'] ?? []),
      adImages: List<String>.from(json['adImages'] ?? []),
      categorySelection:
          CategorySelection.fromJson(json['categorySelection'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'nameOfCustomer': nameOfCustomer,
      'phoneNumber': phoneNumber,
      'city': city,
      'createdAt': createdAt.toIso8601String(),
      'condition': condition,
      'id': id,
      'latLng': latLng,
      'adImages': adImages,
      'categorySelection': categorySelection.toJson(),
    };
  }
}

List<AdModel> ads = [
  AdModel(
    id: '001',
    title: 'Линейный массив L Acoustics Kara2',
    description: 'Профессиональная акустика, отличное состояние.',
    price: '15000000',
    nameOfCustomer: 'Алан',
    phoneNumber: '+77789065778',
    city: 'Актобе',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['50.28024', '57.20856'],
    adImages: [
      'https://www.l-acoustics.com/wp-content/uploads/2021/03/3DR_8xKara_IIM-BUMP_01.png'
    ],
    categorySelection: CategorySelection(
      category: 'Акустические системы',
      subcategory: 'Профессиональная акустика',
      item: 'Линейные массивы',
      brand: 'L Acoustics',
      brandImage:
          'https://bristol-pahire.co.uk/wp-content/uploads/2013/07/lacoustics-logo.png',
    ),
  ),
  // 2. Акустические системы - Портативные колонки
  AdModel(
    id: '002',
    title: 'JBL PartyBox 310',
    description: 'Портативная колонка с отличным басом и световыми эффектами.',
    price: '180000',
    nameOfCustomer: 'Игорь',
    phoneNumber: '+77011234567',
    city: 'Алматы',
    createdAt: DateTime.now(),
    condition: 'Новый',
    latLng: ['43.2220', '76.8512'],
    adImages: [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4KHa-E07tvEQ4gOoS6eo9H97eXZKiQXxVmQ&s'
    ],
    categorySelection: CategorySelection(
      category: 'Акустические системы',
      subcategory: 'Портативные колонки',
      item: 'Bluetooth-колонки',
      brand: 'JBL',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMln8adYPVuVldzIt4rcnbkyh2aHP0lY3W4g&s',
    ),
  ),
  // 3. Усилители - Стереоусилители
  AdModel(
    id: '003',
    title: 'Marantz PM6007',
    description: 'Стереоусилитель с высокой мощностью.',
    price: '250000',
    nameOfCustomer: 'Анна',
    phoneNumber: '+77022334455',
    city: 'Астана',
    createdAt: DateTime.now(),
    condition: 'Новый',
    latLng: ['51.1694', '71.4491'],
    adImages: [
      'https://185504.selcdn.ru/static/hifi4you.reshop.kz/catalog/7943/8777971045fb5fe56497ec_medium.jpg'
    ],
    categorySelection: CategorySelection(
      category: 'Усилители',
      subcategory: 'Типы усилителей',
      item: 'Стереоусилители',
      brand: 'Marantz',
      brandImage:
          'https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/0017/9898/brand.gif?itok=Gx0jYYeO',
    ),
  ),
  // 4. Процессинг звука - Микшерные пульты
  AdModel(
    id: '004',
    title: 'Behringer X32 Digital Mixer',
    description: 'Профессиональный цифровой микшерный пульт.',
    price: '1200000',
    nameOfCustomer: 'Владимир',
    phoneNumber: '+77779998888',
    city: 'Караганда',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['49.8068', '73.1094'],
    adImages: [
      'https://www.gopandy.com/wp-content/uploads/2019/10/Behringer-x32-Digital-Mixer-1-1.jpg'
    ],
    categorySelection: CategorySelection(
      category: 'Процессинг звука',
      subcategory: 'Микшерные пульты',
      item: 'Цифровые',
      brand: 'Behringer',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMX4Cd3OMRbbUQKp-m52n2v2BCkcFH81lv2Q&s',
    ),
  ),
  // 5. Микрофоны и радиосистемы - Вокальные микрофоны
  AdModel(
    id: '005',
    title: 'Shure SM58',
    description: 'Классический вокальный микрофон для профессионалов.',
    price: '35000',
    nameOfCustomer: 'Дмитрий',
    phoneNumber: '+77770001122',
    city: 'Шымкент',
    createdAt: DateTime.now(),
    condition: 'Новый',
    latLng: ['42.3175', '69.5958'],
    adImages: ['https://images.satu.kz/173066842_mikrofon-shure-sm58-lce.jpg'],
    categorySelection: CategorySelection(
      category: 'Микрофоны и радиосистемы',
      subcategory: 'Микрофоны',
      item: 'Вокальные',
      brand: 'Shure',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgsyrutszS8r4bOItQnVmQU-MvkFj0hsWuGw&s',
    ),
  ),
  // 6. Музыкальные инструменты - Электрогитара
  AdModel(
    id: '006',
    title: 'Fender Stratocaster',
    description: 'Культовая электрогитара от Fender.',
    price: '450000',
    nameOfCustomer: 'Александр',
    phoneNumber: '+77775556677',
    city: 'Алматы',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['43.2554', '76.9121'],
    adImages: [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeqAMBuqUTfnkWfP4LqvgHUnjx3LA7GfiMTw&s'
    ],
    categorySelection: CategorySelection(
      category: 'Музыкальные инструменты',
      subcategory: 'Гитары',
      item: 'Электрогитара',
      brand: 'Fender',
      brandImage:
          'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    ),
  ),
  // 7. Оркестровые и этнические инструменты
  AdModel(
    id: '007',
    title: 'Hohner Marine Band',
    description: 'Классическая губная гармошка.',
    price: '15000',
    nameOfCustomer: 'Павел',
    phoneNumber: '+77773334444',
    city: 'Усть-Каменогорск',
    createdAt: DateTime.now(),
    condition: 'Новый',
    latLng: ['49.9726', '82.6119'],
    adImages: ['https://m.media-amazon.com/images/I/71qAOMalOIL.jpg'],
    categorySelection: CategorySelection(
      category: 'Оркестровые и этнические инструменты',
      subcategory: 'Типы инструментов',
      item: 'Губные гармошки',
      brand: 'Hohner',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqLQfkAExDsXVmGaGm8uK9-LVOncNjCKHo_w&s',
    ),
  ),
  // 8. Гитарные аксессуары - Процессоры эффектов
  AdModel(
    id: '008',
    title: 'Boss GT-1000',
    description: 'Педаль эффектов для электрогитары.',
    price: '300000',
    nameOfCustomer: 'Виктор',
    phoneNumber: '+77778889900',
    city: 'Павлодар',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['52.2871', '76.9675'],
    adImages: [
      'https://static.roland.com/assets/images/products/main/gt-1000_main.jpg'
    ],
    categorySelection: CategorySelection(
      category: 'Гитарные аксессуары и комплектующие',
      subcategory: 'Аксессуары',
      item: 'Процессоры и педали эффектов',
      brand: 'Boss',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWvf9arrAIat7YxOY2RqLd7wAdlaUVn1N7zw&s',
    ),
  ),
  // 9. Аксессуары для клавишных - Стойки
  AdModel(
    id: '009',
    title: 'Hercules KS120B',
    description: 'Складная стойка для клавишных.',
    price: '25000',
    nameOfCustomer: 'Максим',
    phoneNumber: '+77005553322',
    city: 'Костанай',
    createdAt: DateTime.now(),
    condition: 'Новый',
    latLng: ['53.214', '63.6246'],
    adImages: [
      'https://herculesstands.com/files/file_pool/1/0o024102952761810651/ks120b_3.png'
    ],
    categorySelection: CategorySelection(
      category: 'Аксессуары и комплектующие для клавишных',
      subcategory: 'Аксессуары',
      item: 'Стойки',
      brand: 'Hercules',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5lo2VZfFiKAU-gvAfI6fMQXQ7QkE9TMje-A&s',
    ),
  ),
  // 10. DJ-оборудование - DJ-контроллеры
  AdModel(
    id: '010',
    title: 'Pioneer DJ DDJ-1000',
    description: 'Профессиональный DJ-контроллер с 4 каналами.',
    price: '750000',
    nameOfCustomer: 'Андрей',
    phoneNumber: '+77006665555',
    city: 'Актау',
    createdAt: DateTime.now(),
    condition: 'Новый',
    latLng: ['43.6588', '51.1975'],
    adImages: [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpOuNQH9AbD1v89UT23bfw_LPCDZuADYcZkw&s'
    ],
    categorySelection: CategorySelection(
      category: 'DJ-оборудование',
      subcategory: 'Оборудование',
      item: 'DJ-контроллеры',
      brand: 'Pioneer DJ',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb1h5VDsuMqSaBhEs1Z_ptm-T0S68rSINV2Q&s',
    ),
  ),

  AdModel(
    id: '221',
    title: 'Линейный массив l Acoustics kara2',
    description: 'Состояние новый.',
    price: '15000000',
    nameOfCustomer: 'Алан',
    phoneNumber: '+77789065778',
    city: 'Актобе',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['50.28024', '57.20856'],
    adImages: [
      'https://www.l-acoustics.com/wp-content/uploads/2021/03/3DR_8xKara_IIM-BUMP_01.png'
    ],
    categorySelection: CategorySelection(
      category: 'Акустические системы',
      subcategory: 'Профессиональная акустика',
      item: 'Линейные массивы',
      brand: 'L Acoustics',
      brandImage:
          'https://bristol-pahire.co.uk/wp-content/uploads/2013/07/lacoustics-logo.png',
    ),
  ),
  AdModel(
    id: '222',
    title: 'Акустическая гитара Yamaha',
    description: 'Новая акустическая гитара, отличное звучание.',
    price: '80000',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 900 123 45 67',
    city: 'Актобе',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['50.28024', '57.20856'],
    adImages: [
      'https://www.1music.kz/upload/iblock/3f4/3f4f8b543ca065540c04516c45ffc6c4.jpeg',
    ],
    categorySelection: CategorySelection(
      category: 'Музыкальные инструменты',
      subcategory: 'Гитары',
      item: 'Акустические',
      brand: 'Yamaha',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSnwBrZda2hOLLXvomIPX4JUp4-16ki1Eliw&s',
    ),
  ),
  AdModel(
    id: '222',
    title: 'Акустическая гитара Yamaha',
    description: 'Новая акустическая гитара, отличное звучание.',
    price: '80000',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 900 123 45 67',
    city: 'Актобе',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['50.28024', '57.20856'],
    adImages: [
      'https://www.1music.kz/upload/iblock/3f4/3f4f8b543ca065540c04516c45ffc6c4.jpeg',
    ],
    categorySelection: CategorySelection(
      category: 'Музыкальные инструменты',
      subcategory: 'Гитары',
      item: 'Акустические',
      brand: 'Yamaha',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSnwBrZda2hOLLXvomIPX4JUp4-16ki1Eliw&s',
    ),
  ),
  AdModel(
    id: '222',
    title: 'Акустическая гитара Yamaha',
    description: 'Новая акустическая гитара, отличное звучание.',
    price: '80000',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 900 123 45 67',
    city: 'Актобе',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['50.28024', '57.20856'],
    adImages: [
      'https://www.1music.kz/upload/iblock/3f4/3f4f8b543ca065540c04516c45ffc6c4.jpeg',
    ],
    categorySelection: CategorySelection(
      category: 'Музыкальные инструменты',
      subcategory: 'Гитары',
      item: 'Акустические',
      brand: 'Yamaha',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSnwBrZda2hOLLXvomIPX4JUp4-16ki1Eliw&s',
    ),
  ),
  AdModel(
    id: '222',
    title: 'Акустическая гитара Yamaha',
    description: 'Новая акустическая гитара, отличное звучание.',
    price: '80000',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 900 123 45 67',
    city: 'Актобе',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['50.28024', '57.20856'],
    adImages: [
      'https://www.1music.kz/upload/iblock/3f4/3f4f8b543ca065540c04516c45ffc6c4.jpeg',
    ],
    categorySelection: CategorySelection(
      category: 'Музыкальные инструменты',
      subcategory: 'Гитары',
      item: 'Акустические',
      brand: 'Yamaha',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSnwBrZda2hOLLXvomIPX4JUp4-16ki1Eliw&s',
    ),
  ),
  AdModel(
    id: '222',
    title: 'Акустическая гитара Yamaha',
    description: 'Новая акустическая гитара, отличное звучание.',
    price: '80000',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 900 123 45 67',
    city: 'Актобе',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['50.28024', '57.20856'],
    adImages: [
      'https://www.1music.kz/upload/iblock/3f4/3f4f8b543ca065540c04516c45ffc6c4.jpeg',
    ],
    categorySelection: CategorySelection(
      category: 'Музыкальные инструменты',
      subcategory: 'Гитары',
      item: 'Акустические',
      brand: 'Yamaha',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSnwBrZda2hOLLXvomIPX4JUp4-16ki1Eliw&s',
    ),
  ),
  AdModel(
    id: '222',
    title: 'Акустическая гитара Yamaha',
    description: 'Новая акустическая гитара, отличное звучание.',
    price: '80000',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 900 123 45 67',
    city: 'Актобе',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['50.28024', '57.20856'],
    adImages: [
      'https://www.1music.kz/upload/iblock/3f4/3f4f8b543ca065540c04516c45ffc6c4.jpeg',
    ],
    categorySelection: CategorySelection(
      category: 'Музыкальные инструменты',
      subcategory: 'Гитары',
      item: 'Акустические',
      brand: 'Yamaha',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSnwBrZda2hOLLXvomIPX4JUp4-16ki1Eliw&s',
    ),
  ),
  AdModel(
    id: '222',
    title: 'Акустическая гитара Yamaha',
    description: 'Новая акустическая гитара, отличное звучание.',
    price: '80000',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 900 123 45 67',
    city: 'Актобе',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['50.28024', '57.20856'],
    adImages: [
      'https://www.1music.kz/upload/iblock/3f4/3f4f8b543ca065540c04516c45ffc6c4.jpeg',
    ],
    categorySelection: CategorySelection(
      category: 'Музыкальные инструменты',
      subcategory: 'Гитары',
      item: 'Акустические',
      brand: 'Yamaha',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSnwBrZda2hOLLXvomIPX4JUp4-16ki1Eliw&s',
    ),
  ),
  AdModel(
    id: '222',
    title: 'Акустическая гитара Yamaha',
    description: 'Новая акустическая гитара, отличное звучание.',
    price: '80000',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 900 123 45 67',
    city: 'Актобе',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['50.28024', '57.20856'],
    adImages: [
      'https://www.1music.kz/upload/iblock/3f4/3f4f8b543ca065540c04516c45ffc6c4.jpeg',
    ],
    categorySelection: CategorySelection(
      category: 'Музыкальные инструменты',
      subcategory: 'Гитары',
      item: 'Акустические',
      brand: 'Yamaha',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSnwBrZda2hOLLXvomIPX4JUp4-16ki1Eliw&s',
    ),
  ),
  AdModel(
    id: '223',
    title: 'Электрогитара Fender Stratocaster',
    description: 'Электрогитара Fender, в отличном состоянии.',
    price: '250000',
    nameOfCustomer: 'Владимир',
    phoneNumber: '+7 901 234 56 78',
    city: 'Алматы',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['43.2452', '76.9345'],
    adImages: [
      'https://m.media-amazon.com/images/I/61Z01+68f8L.jpg',
    ],
    categorySelection: CategorySelection(
      category: 'Музыкальные инструменты',
      subcategory: 'Гитары',
      item: 'Электрогитары',
      brand: 'Fender',
      brandImage:
          'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    ),
  ),
  AdModel(
    id: '224',
    title: 'JBL PartyBox 300',
    description:
        'Мощная портативная колонка JBL PartyBox 300 с отличным качеством звука.',
    price: '150000',
    nameOfCustomer: 'Иван',
    phoneNumber: '+7 900 123 45 67',
    city: 'Алматы',
    createdAt: DateTime.now(),
    condition: 'Новый',
    latLng: ['43.2452', '76.9345'],
    adImages: [
      'https://kh.jbl.com/dw/image/v2/AAUJ_PRD/on/demandware.static/-/Sites-masterCatalog_Harman/default/dw8e0c7057/JBL_Party_Box_300_Hero_14836_X1.png?sw=537&sfrm=png'
    ],
    categorySelection: CategorySelection(
      category: 'Акустические системы',
      subcategory: 'Портативные колонки',
      item: 'Bluetooth-колонки',
      brand: 'JBL',
      brandImage:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/JBL-Logo.svg/1200px-JBL-Logo.svg.png',
    ),
  ),
  AdModel(
    id: '225',
    title: 'AKG P3 S',
    description:
        'Профессиональный микрофон AKG P3 S с кардиоидной диаграммой направленности.',
    price: '25000',
    nameOfCustomer: 'Мария',
    phoneNumber: '+7 901 234 56 78',
    city: 'Алматы',
    createdAt: DateTime.now(),
    condition: 'Б/у',
    latLng: ['43.2452', '76.9345'],
    adImages: [
      'https://images.satu.kz/112283671_mikrofon-akg-p3s.jpg',
    ],
    categorySelection: CategorySelection(
      category: 'Микрофоны и радиосистемы',
      subcategory: 'Микрофоны',
      item: 'Вокальные',
      brand: 'AKG',
      brandImage:
          'https://cdn.cookielaw.org/logos/68a7fd17-25ad-4562-9af3-cbe40f09076e/7eddad80-2690-405c-bdd3-9bf654c8d45f/3094a13c-2d05-46f9-9bee-095fd7262bc5/AKG-3300x2550pix_white.jpg',
    ),
  ),
];
