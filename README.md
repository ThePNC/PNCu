# pncu

## Features

- List cards

- Open card view with Store image, Name and render of Barcode

- Create card, with store, name and scan Barcode with phone camera

- Edit and Delete cards

## Card management

Cards are stored in shared preferences https://flutter.dev/docs/cookbook/persistence/key-value

Following the structure: key 'barcode': value string list [<store>, <name>]

This data gets mapped, onLoad, to an Object with the proper keys matching the values
