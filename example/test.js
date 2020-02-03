const dart_sdk = require('dart_sdk')

const myLas = new Las(`example1.las`);

async function read() {
    try {
       var data =  await myLas.wellParams()
       console.log(data)

    } catch (error) {
        console.log(error);
    }
}

read();