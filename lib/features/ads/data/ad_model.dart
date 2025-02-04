class AdModel {
  final String title;
  final String description;
  final String imageLink;
  final String price;
  final String nameOfCustomer;
  final String phoneNumber;
  final String city;
  final DateTime createdAt;
  final String category;
  final String condition;
  final String id;
  const AdModel(
      {required this.description,
      required this.imageLink,
      required this.nameOfCustomer,
      required this.phoneNumber,
      required this.city,
      required this.price,
      required this.id,
      required this.condition,
      required this.category,
      required this.title,
      required this.createdAt});

  factory AdModel.fromMap(Map<String, dynamic> data) {
    return AdModel(
        id: data['id'],
        description: data['description'],
        imageLink: data['imageLink'],
        nameOfCustomer: data['nameOfCustomer'],
        phoneNumber: data['phoneNumber'],
        price: data['price'],
        title: data['title'],
        condition: data['condition'],
        category: data['category'],
        city: data['city'],
        createdAt: data['createdAt']);
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'imageLink': imageLink,
      'nameOfCustomer': nameOfCustomer,
      'phoneNumber': phoneNumber,
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
      description: 'Новая акустическая гитара, отличное звучание.',
      imageLink:
          'https://www.1music.kz/upload/iblock/3f4/3f4f8b543ca065540c04516c45ffc6c4.jpeg',
      nameOfCustomer: 'Алексей',
      phoneNumber: '+7 900 123 45 67',
      price: '80000',
      condition: 'Б/у',
      category: 'Инструмент',
      title: 'Акустическая гитара Yamaha',
      createdAt: DateTime.now(),
      city: 'Актобе'),
  AdModel(
      id: '221',
      description: 'Электрогитара Fender, в отличном состоянии.',
      imageLink: 'https://m.media-amazon.com/images/I/61Z01+68f8L.jpg',
      nameOfCustomer: 'Владимир',
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
    imageLink:
        'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg',
    nameOfCustomer: 'Дмитрий',
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
    imageLink:
        'https://basket-13.wbbasket.ru/vol1934/part193402/193402473/images/big/1.webp',
    nameOfCustomer: 'Мария',
    phoneNumber: '+7 903 456 78 90',
    category: 'Инструмент',
    price: '65000',
    condition: 'Новый',
    title: 'Классическая гитара Alhambra',
    city: 'Алматы',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description: 'Гитара Gibson, редкая модель, коллекционное состояние.',
    imageLink:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkTe03UTXM1WVd050u8iRKyjNc_CmVcdTUxQ&s',
    nameOfCustomer: 'Сергей',
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
    imageLink:
        'https://kh.jbl.com/dw/image/v2/AAUJ_PRD/on/demandware.static/-/Sites-masterCatalog_Harman/default/dw8e0c7057/JBL_Party_Box_300_Hero_14836_X1.png?sw=537&sfrm=png',
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
    imageLink:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3Kh7oJeMYLbou2ctBh22f1dMUwarc3sI5SQ&s',
    nameOfCustomer: 'Мария',
    phoneNumber: '+7 901 234 56 78',
    price: '25000',
    title: 'AKG P3 S',
    condition: 'Б/у',
    category: 'Микрофон',
    city: 'Алматы',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Портативная колонка Sony MHC-V21D с функцией караоке, световыми эффектами и поддержкой Bluetooth. Идеальна для домашних вечеринок.',
    imageLink:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb6-2LVfv06lN02UCBhE9BZxMQeeDh-XC7Mw&s',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 902 345 67 89',
    price: '125000',
    condition: 'Б/у',
    city: 'Алматы',
    category: 'Колонки',
    title: 'Sony MHC-V21D',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Портативная колонка AUNA Streetstar 15 с мощностью 100 Вт и временем автономной работы до 7 часов. Поддерживает Bluetooth, USB и SD-карты. Идеальна для уличных мероприятий.',
    imageLink:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGmdQwzS9bUngzuTbs2Abm_u-6yN5UVUcYhA&s',
    nameOfCustomer: 'Сергей',
    condition: 'Новый',
    phoneNumber: '+7 903 456 78 90',
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
    imageLink: 'https://m.media-amazon.com/images/I/71JVQKYAEFL.jpg',
    nameOfCustomer: 'Ольга',
    phoneNumber: '+7 904 567 89 01',
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
    imageLink:
        'https://www.1music.kz/upload/iblock/3f4/3f4f8b543ca065540c04516c45ffc6c4.jpeg',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 900 123 45 67',
    condition: 'Новый',
    category: 'Инструмент',
    price: '80000',
    city: 'Алматы',
    title: 'Акустическая гитара Yamaha',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description: 'Электрогитара Fender, в отличном состоянии.',
    imageLink: 'https://m.media-amazon.com/images/I/61Z01+68f8L.jpg',
    nameOfCustomer: 'Владимир',
    condition: 'Б/у',
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
    imageLink:
        'https://sc1.musik-produktiv.com/pic-010157005l/ibanez-soundgear-sr300edx-czm.jpg',
    nameOfCustomer: 'Дмитрий',
    phoneNumber: '+7 902 345 67 89',
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
    imageLink:
        'https://basket-13.wbbasket.ru/vol1934/part193402/193402473/images/big/1.webp',
    nameOfCustomer: 'Мария',
    condition: 'Новый',
    phoneNumber: '+7 903 456 78 90',
    category: 'Инструмент',
    price: '65000',
    city: 'Алматы',
    title: 'Классическая гитара Alhambra',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description: 'Гитара Gibson, редкая модель, коллекционное состояние.',
    imageLink:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkTe03UTXM1WVd050u8iRKyjNc_CmVcdTUxQ&s',
    nameOfCustomer: 'Сергей',
    phoneNumber: '+7 904 567 89 01',
    city: 'Алматы',
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
    imageLink:
        'https://kh.jbl.com/dw/image/v2/AAUJ_PRD/on/demandware.static/-/Sites-masterCatalog_Harman/default/dw8e0c7057/JBL_Party_Box_300_Hero_14836_X1.png?sw=537&sfrm=png',
    nameOfCustomer: 'Иван',
    phoneNumber: '+7 900 123 45 67',
    category: 'Колонки',
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
    imageLink:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3Kh7oJeMYLbou2ctBh22f1dMUwarc3sI5SQ&s',
    nameOfCustomer: 'Мария',
    phoneNumber: '+7 901 234 56 78',
    city: 'Алматы',
    category: 'Микрофон',
    price: '25000',
    condition: 'Новый',
    title: 'AKG P3 S',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Портативная колонка Sony MHC-V21D с функцией караоке, световыми эффектами и поддержкой Bluetooth. Идеальна для домашних вечеринок.',
    imageLink:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb6-2LVfv06lN02UCBhE9BZxMQeeDh-XC7Mw&s',
    nameOfCustomer: 'Алексей',
    phoneNumber: '+7 902 345 67 89',
    condition: 'Новый',
    price: '125000',
    city: 'Алматы',
    category: 'Колонки',
    title: 'Sony MHC-V21D',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Портативная колонка AUNA Streetstar 15 с мощностью 100 Вт и временем автономной работы до 7 часов. Поддерживает Bluetooth, USB и SD-карты. Идеальна для уличных мероприятий.',
    imageLink:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGmdQwzS9bUngzuTbs2Abm_u-6yN5UVUcYhA&s',
    nameOfCustomer: 'Сергей',
    phoneNumber: '+7 903 456 78 90',
    price: '150000',
    city: 'Алматы',
    title: 'AUNA Streetstar 15',
    condition: 'Б/у',
    category: 'Инструмент',
    createdAt: DateTime.now(),
  ),
  AdModel(
    id: '221',
    description:
        'Портативная колонка JBL PartyBox 100 с мощностью 160 Вт и световыми эффектами. В комплекте вокальный микрофон AKG P3 S. Поддерживает Bluetooth 4.2.',
    imageLink: 'https://m.media-amazon.com/images/I/71JVQKYAEFL.jpg',
    nameOfCustomer: 'Ольга',
    phoneNumber: '+7 904 567 89 01',
    price: '170000',
    condition: 'Б/у',
    category: 'Колонки',
    city: 'Алматы',
    title: 'JBL PartyBox 100 + AKG P3 S',
    createdAt: DateTime.now(),
  ),
];
