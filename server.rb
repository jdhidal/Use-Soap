require 'savon'
require 'webrick'

# Clase que define el comportamiento de los servicios SOAP
class Calculator
  def add(num1, num2)
    num1 + num2
  end
end

# Configuración del servidor SOAP
server = WEBrick::HTTPServer.new(Port: 3000)

# Configuración para manejar las solicitudes SOAP
server.mount_proc '/' do |req, res|
    puts "Solicitud recibida: #{req.body}"
    if req.request_method == 'POST' && req.path == '/'
      # Extraemos los números de la solicitud SOAP
      soap_request = req.body
      match = soap_request.match(/<web:num1>(\d+)<\/web:num1>.*<web:num2>(\d+)<\/web:num2>/m)
      if match
        num1, num2 = match.captures.map(&:to_i)
        result = Calculator.new.add(num1, num2)
  
        # Respuesta SOAP con el resultado
        res.content_type = 'text/xml'
        res.body = <<-XML
          <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                            xmlns:web="http://www.example.com/webservice">
            <soapenv:Header/>
            <soapenv:Body>
              <web:addResponse>
                <web:result>#{result}</web:result>
              </web:addResponse>
            </soapenv:Body>
          </soapenv:Envelope>
        XML
      else
        res.status = 400
        res.body = "Invalid request"
      end
    else
      res.status = 404
      res.body = "Not Found"
    end
  end
  
# Iniciar el servidor
server.start
