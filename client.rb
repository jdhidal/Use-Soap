require 'savon'

# Crear un cliente SOAP que apunte a nuestro servicio SOAP en http://localhost:8000/sum
client = Savon.client(wsdl: 'http://localhost:8000/sum?wsdl')

# Realizar la llamada al método add_numbers
response = client.call(:add_numbers, message: { a: 5, b: 10 })

# Mostrar el resultado de la suma
puts "El resultado de la suma es: #{response.body[:add_numbers]}"
