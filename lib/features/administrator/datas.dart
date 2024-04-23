class Datas {

  Map<String, dynamic> dishesData = {
    // ANTIPASTI
    '1 - prosciutto_melone': {
      'category': 'antipasti',
      'ingredients': [
        'Prosciutto crudo',
        'Melone',
        'Rucola',
        'Olio extravergine di oliva',
        'Sale',
        'Pepe'
      ],
      'pictureUrl': 'https://firebasestorage.googleapis.com/v0/b/ristorante-c94d2.appspot.com/o/crudo.jpg?alt=media&token=e242c1df-742e-4ce9-88bf-8f8ef1e97ec9',
      'price': 15.50,
      'title': 'Prosciutto e Melone'
    },
    '1 - caprese': {
      'category': 'antipasti',
      'ingredients': [
        'Mozzarella di bufala',
        'Pomodorini',
        'Basilico fresco',
        'Olio extravergine di oliva',
        'Sale',
        'Pepe'
      ],
      'pictureUrl': 'https://firebasestorage.googleapis.com/v0/b/ristorante-c94d2.appspot.com/o/caprese.jpg?alt=media&token=08437ae9-a5f1-4b33-b706-f054f344b8c8',
      'price': 12.00,
      'title': 'Caprese'
    },
    '1 - gamberoni_aglio_olio': {
      'category': 'antipasti',
      'ingredients': [
        'Gamberoni',
        'Aglio',
        'Peperoncino',
        'Prezzemolo',
        'Vino bianco',
        'Olio extravergine di oliva'
      ],
      'pictureUrl': 'https://firebasestorage.googleapis.com/v0/b/ristorante-c94d2.appspot.com/o/cucinare-ricette-gamberi.png?alt=media&token=e7f89377-2c9d-4c0b-bed0-fd3880e9739a',
      'price': 18.00,
      'title': 'Gamberoni all\'aglio e olio'
    },
    '2 - bresaola_rucola': {
      'category': 'panini',
      'ingredients': [
        'Bresaola',
        'Rucola',
        'Scaglie di grana',
        'Olio extravergine di oliva',
        'Sale',
        'Pepe',
        'Pane ciabatta'
      ],
      'pictureUrl': 'https://firebasestorage.googleapis.com/v0/b/ristorante-c94d2.appspot.com/o/delicato-panino-con-bresaola-rucola-grana-olio-limone-sale.jpg?alt=media&token=48a55b99-79c1-4ae0-8db3-025a8554e3f6',
      'price': 10.00,
      'title': 'Panino alla bresaola con rucola'
    },
    '2 - pollo_arrosto': {
      'category': 'panini',
      'ingredients': [
        'Pollo arrosto',
        'Lattuga',
        'Pomodoro',
        'Maionese',
        'Pane integrale'
      ],
      'pictureUrl': 'https://firebasestorage.googleapis.com/v0/b/ristorante-c94d2.appspot.com/o/176281.jpg?alt=media&token=5f95ddf1-4776-431c-afca-865f66c34069',
      'price': 9.00,
      'title': 'Panino al pollo arrosto'
    },
    '2 - tonno_cipolla': {
      'category': 'panini',
      'ingredients': [
        'Tonno',
        'Cipolla rossa',
        'Maionese',
        'Olive nere',
        'Pane rustico'
      ],
      'pictureUrl': 'https://firebasestorage.googleapis.com/v0/b/ristorante-c94d2.appspot.com/o/panino-tonno.png?alt=media&token=419618de-d040-414f-b43a-79476ce8ac6e',
      'price': 8.00,
      'title': 'Panino al tonno e cipolla'
    },
    '3 - funghi_prosciutto': {
      'category': 'pizze',
      'ingredients': [
        'Funghi champignon',
        'Prosciutto cotto',
        'Mozzarella',
        'Salsa di pomodoro',
        'Olio extravergine di oliva',
        'Origano',
        'Impasto per pizza'
      ],
      'pictureUrl': 'https://firebasestorage.googleapis.com/v0/b/ristorante-c94d2.appspot.com/o/pizza3.png?alt=media&token=dfe7c3dd-d081-4793-b9be-d51816a6f4a6',
      'price': 13.00,
      'title': 'Pizza Prosciutto e Funghi'
    },
    '3 - diavola': {
      'category': 'pizze',
      'ingredients': [
        'Salsiccia',
        'Peperoni',
        'Mozzarella',
        'Salsa di pomodoro',
        'Olio extravergine di oliva',
        'Peperoncino',
        'Impasto per pizza'
      ],
      'pictureUrl': 'https://firebasestorage.googleapis.com/v0/b/ristorante-c94d2.appspot.com/o/diavola.jpg?alt=media&token=35636fb7-e80b-4919-bf30-b100fe0ea412',
      'price': 14.00,
      'title': 'Pizza Diavola'
    },
    '3 - gorgonzola_noci': {
      'category': 'pizze',
      'ingredients': [
        'Gorgonzola',
        'Noci',
        'Mozzarella',
        'Miele',
        'Rucola',
        'Olio extravergine di oliva',
        'Impasto per pizza'
      ],
      'pictureUrl': 'https://firebasestorage.googleapis.com/v0/b/ristorante-c94d2.appspot.com/o/formaggi%20pizza.jpg?alt=media&token=d964a224-b1ad-4f0b-a0db-c35efc46b77e',
      'price': 16.00,
      'title': 'Pizza Gorgonzola e Noci'
    },
    '4 - acqua': {
      'category': 'bevande',
      'ingredients': [
        'Acqua naturale',
        'Ghiaccio',
        'Fetta di limone'
      ],
      'pictureUrl': 'https://firebasestorage.googleapis.com/v0/b/ristorante-c94d2.appspot.com/o/Valverde-50cl-naturale.jpg?alt=media&token=6aa9b7b0-10cc-42fc-bc5c-f375d80adca7',
      'price': 2.00,
      'title': 'Acqua Naturale'
    },
    '4 - cola': {
      'category': 'bevande',
      'ingredients': [
        'Coca-Cola',
        'Ghiaccio',
        'Fetta di lime'
      ],
      'pictureUrl': 'https://firebasestorage.googleapis.com/v0/b/ristorante-c94d2.appspot.com/o/Coca_Cola_glass_bottle_transparent.png?alt=media&token=c8599652-ca93-4183-aa0e-2186354726f3',
      'price': 3.00,
      'title': 'Coca-Cola'
    },
    '4 - spritz': {
      'category': 'bevande',
      'ingredients': [
        'Spritz',
        'Aperol',
        'Prosecco',
        'Soda',
        'Fetta di arancia'
      ],
      'pictureUrl': 'https://firebasestorage.googleapis.com/v0/b/ristorante-c94d2.appspot.com/o/Aperol-Spritz.png?alt=media&token=edde1188-e557-4d9a-a4aa-31dc7b5d3513',
      'price': 7.00,
      'title': 'Spritz'
    },
  };
}
