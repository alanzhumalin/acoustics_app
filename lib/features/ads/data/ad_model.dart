class AdModel {
  final String title;
  final String description;
  final String price;
  final String nameOfCustomer;
  final String phoneNumber;
  final String brand;
  final String brandImage;
  final String city;
  final DateTime createdAt;
  final String category;
  final String condition;
  final String id;

  final List<String> adImages;
  const AdModel(
      {required this.description,
      required this.nameOfCustomer,
      required this.phoneNumber,
      required this.city,
      required this.brand,
      required this.price,
      required this.brandImage,
      required this.adImages,
      required this.id,
      required this.condition,
      required this.category,
      required this.title,
      required this.createdAt});

  factory AdModel.fromMap(Map<String, dynamic> data) {
    return AdModel(
        id: data['id'],
        description: data['description'],
        adImages: (data['imageLink'] as List<dynamic>)
            .map((image) => image.toString())
            .toList(),
        nameOfCustomer: data['nameOfCustomer'],
        phoneNumber: data['phoneNumber'],
        price: data['price'],
        brandImage: data['brandImage'],
        brand: data['brand'],
        title: data['title'],
        condition: data['condition'],
        category: data['category'],
        city: data['city'],
        createdAt: data['createdAt']);
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'adImages': adImages,
      'nameOfCustomer': nameOfCustomer,
      'phoneNumber': phoneNumber,
      'brand': brand,
      'city': city,
      'brandImage': brandImage,
      'category': category,
      'price': price,
      'condition': condition,
      'title': title,
      'createdAt': createdAt
    };
  }
}

List<AdModel> ads = [
  AdModel(
      id: '221',
      description: 'Состояние новый.',
      adImages: [
        'https://www.l-acoustics.com/wp-content/uploads/2021/03/3DR_8xKara_IIM-BUMP_01.png'
      ],
      nameOfCustomer: 'Алан',
      phoneNumber: '+77789065778',
      brandImage:
          'https://bristol-pahire.co.uk/wp-content/uploads/2013/07/lacoustics-logo.png',
      price: '15000000',
      condition: 'Б/у',
      brand: 'L Acoustics',
      category: 'Колонки',
      title: 'Линейный массив l Acoustics kara2',
      createdAt: DateTime.now(),
      city: 'Актобе'),
  AdModel(
      id: '221',
      description: 'Новая акустическая гитара, отличное звучание.',
      adImages: [
        'https://www.1music.kz/upload/iblock/3f4/3f4f8b543ca065540c04516c45ffc6c4.jpeg',
        'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg',
        'https://www.1music.kz/upload/iblock/3f4/3f4f8b543ca065540c04516c45ffc6c4.jpeg'
      ],
      nameOfCustomer: 'Алексейe',
      phoneNumber: '+7 900 123 45 67',
      brandImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSnwBrZda2hOLLXvomIPX4JUp4-16ki1Eliw&s',
      price: '80000',
      condition: 'Б/у',
      brand: 'Yamaha',
      category: 'Инструмент',
      title: 'Акустическая гитара Yamaha',
      createdAt: DateTime.now(),
      city: 'Актобе'),
  AdModel(
      id: '221',
      description: 'Электрогитара Fender, в отличном состоянии.',
      adImages: ['https://m.media-amazon.com/images/I/61Z01+68f8L.jpg'],
      nameOfCustomer: 'Владимир',
      brand: 'Fender',
      brandImage:
          'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
      phoneNumber: '+7 901 234 56 78',
      category: 'Инструмент',
      condition: 'Б/у',
      price: '250000',
      title: 'Электрогитара Fender Stratocaster',
      createdAt: DateTime.now(),
      city: 'Алматы'),
  AdModel(
    id: '221',
    description: 'Бас-гитара Ibanez, почти новая, мало использовалась.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Ibanez',
    nameOfCustomer: 'Дмитрий',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    phoneNumber: '+7 902 345 67 89',
    price: '150000',
    category: 'Инструмент',
    condition: 'Б/у',
    title: 'Бас-гитара Ibanez SR300',
    city: 'Алматы',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description: 'Классическая гитара для начинающих и профессионалов.',
    adImages: [
      'https://www.guitarfromspain.com/5869-medium_default/alhambra-7c-classic-classical-guitar.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Мария',
    phoneNumber: '+7 903 456 78 90',
    category: 'Инструмент',
    brandImage:
        'https://www.alhambraguitarras.com/layout/frontend/themes/guitarrasalhambra/images/guitarrasalhambra-logo.png',
    price: '65000',
    condition: 'Новый',
    title: 'Классическая гитара Alhambra',
    city: 'Алматы',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description: 'Гитара Gibson, редкая модель, коллекционное состояние.',
    adImages: [
      'https://images.ctfassets.net/m8onsx4mm13s/4k0ldXqvN8cM2itLyIS5b3/6a732610de017c7bf726680202b7ae50/LPS500PUNH1_front.png'
    ],
    brand: 'Gibson',
    nameOfCustomer: 'Сергей',
    brandImage:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3gWbIt3lLWufFHD5ZeVdkON3bXkK5LewRag&s',
    category: 'Инструмент',
    phoneNumber: '+7 904 567 89 01',
    price: '760000',
    condition: 'Б/у',
    title: 'Gibson Les Paul Custom',
    city: 'Алматы',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Мощная портативная колонка JBL PartyBox 300 с отличным качеством звука и встроенным микрофоном. Поддерживает Bluetooth, USB и AUX. Идеальна для вечеринок и мероприятий.',
    adImages: [
      'https://kh.jbl.com/dw/image/v2/AAUJ_PRD/on/demandware.static/-/Sites-masterCatalog_Harman/default/dw8e0c7057/JBL_Party_Box_300_Hero_14836_X1.png?sw=537&sfrm=png'
    ],
    brand: 'JBL',
    brandImage:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/JBL-Logo.svg/1200px-JBL-Logo.svg.png',
    nameOfCustomer: 'Иван',
    phoneNumber: '+7 900 123 45 67',
    price: '150000',
    condition: 'Новый',
    title: 'JBL PartyBox 300',
    category: 'Колонки',
    city: 'Алматы',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Профессиональный микрофон AKG P3 S с кардиоидной диаграммой направленности. Отлично подходит для вокала и инструментов. Прочный металлический корпус.',
    adImages: ['https://images.satu.kz/112283671_mikrofon-akg-p3s.jpg'],
    brand: 'AKG',
    nameOfCustomer: 'Мария',
    phoneNumber: '+7 901 234 56 78',
    price: '25000',
    title: 'AKG P3 S',
    brandImage:
        'https://cdn.cookielaw.org/logos/68a7fd17-25ad-4562-9af3-cbe40f09076e/7eddad80-2690-405c-bdd3-9bf654c8d45f/3094a13c-2d05-46f9-9bee-095fd7262bc5/AKG-3300x2550pix_white.jpg',
    condition: 'Б/у',
    category: 'Микрофон',
    city: 'Алматы',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Портативная колонка Sony MHC-V21D с функцией караоке, световыми эффектами и поддержкой Bluetooth. Идеальна для домашних вечеринок.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 902 345 67 89',
    price: '125000',
    condition: 'Б/у',
    city: 'Алматы',
    category: 'Колонки',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    title: 'Sony MHC-V21D',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Портативная колонка AUNA Streetstar 15 с мощностью 100 Вт и временем автономной работы до 7 часов. Поддерживает Bluetooth, USB и SD-карты. Идеальна для уличных мероприятий.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Сергей',
    condition: 'Новый',
    phoneNumber: '+7 903 456 78 90',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    price: '150000',
    city: 'Алматы',
    category: 'Колонки',
    title: 'AUNA Streetstar 15',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Портативная колонка JBL PartyBox 100 с мощностью 160 Вт и световыми эффектами. В комплекте вокальный микрофон AKG P3 S. Поддерживает Bluetooth 4.2.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Ольга',
    phoneNumber: '+7 904 567 89 01',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    condition: 'Б/у',
    category: 'Колонки',
    price: '170000',
    city: 'Алматы',
    title: 'JBL PartyBox 100 + AKG P3 S',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description: 'Новая акустическая гитара, отличное звучание.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 900 123 45 67',
    condition: 'Новый',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    category: 'Инструмент',
    price: '80000',
    city: 'Алматы',
    title: 'Акустическая гитара Yamaha',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description: 'Электрогитара Fender, в отличном состоянии.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Владимир',
    condition: 'Б/у',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    phoneNumber: '+7 901 234 56 78',
    price: '250000',
    category: 'Инструмент',
    city: 'Алматы',
    title: 'Электрогитара Fender Stratocaster',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description: 'Бас-гитара Ibanez, почти новая, мало использовалась.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Дмитрий',
    phoneNumber: '+7 902 345 67 89',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    price: '150000',
    condition: 'Б/у',
    category: 'Инструмент',
    city: 'Алматы',
    title: 'Бас-гитара Ibanez SR300',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description: 'Классическая гитара для начинающих и профессионалов.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Мария',
    condition: 'Новый',
    phoneNumber: '+7 903 456 78 90',
    category: 'Инструмент',
    price: '65000',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    city: 'Алматы',
    title: 'Классическая гитара Alhambra',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description: 'Гитара Gibson, редкая модель, коллекционное состояние.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Сергей',
    phoneNumber: '+7 904 567 89 01',
    city: 'Алматы',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    condition: 'Б/у',
    category: 'Инструмент',
    price: '760000',
    title: 'Gibson Les Paul Custom',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Мощная портативная колонка JBL PartyBox 300 с отличным качеством звука и встроенным микрофоном. Поддерживает Bluetooth, USB и AUX. Идеальна для вечеринок и мероприятий.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Иван',
    phoneNumber: '+7 900 123 45 67',
    category: 'Колонки',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    city: 'Алматы',
    price: '150000',
    condition: 'Новый',
    title: 'JBL PartyBox 300',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Профессиональный микрофон AKG P3 S с кардиоидной диаграммой направленности. Отлично подходит для вокала и инструментов. Прочный металлический корпус.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Мария',
    phoneNumber: '+7 901 234 56 78',
    city: 'Алматы',
    category: 'Микрофон',
    price: '25000',
    condition: 'Новый',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    title: 'AKG P3 S',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Портативная колонка Sony MHC-V21D с функцией караоке, световыми эффектами и поддержкой Bluetooth. Идеальна для домашних вечеринок.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 902 345 67 89',
    condition: 'Новый',
    price: '125000',
    city: 'Алматы',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    category: 'Колонки',
    title: 'Sony MHC-V21D',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Портативная колонка AUNA Streetstar 15 с мощностью 100 Вт и временем автономной работы до 7 часов. Поддерживает Bluetooth, USB и SD-карты. Идеальна для уличных мероприятий.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Сергей',
    phoneNumber: '+7 903 456 78 90',
    price: '150000',
    city: 'Алматы',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    title: 'AUNA Streetstar 15',
    condition: 'Б/у',
    category: 'Инструмент',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Портативная колонка JBL PartyBox 100 с мощностью 160 Вт и световыми эффектами. В комплекте вокальный микрофон AKG P3 S. Поддерживает Bluetooth 4.2.',
    adImages: [
      'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg'
    ],
    brand: 'Fender',
    nameOfCustomer: 'Ольга',
    brandImage:
        'https://assets.spotlight.fender.com/logos/fender-red-large.jpg',
    phoneNumber: '+7 904 567 89 01',
    price: '170000',
    condition: 'Б/у',
    category: 'Колонки',
    city: 'Алматы',
    title: 'JBL PartyBox 100 + AKG P3 S',
    createdAt: DateTime.now(),
  ),
];
