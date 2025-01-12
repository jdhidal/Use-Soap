# SOAP Server with Ruby and WEBrick

This project implements a basic SOAP server in Ruby using the WEBrick library to handle HTTP requests. It includes a service called Calculator that performs addition operations.

## Objective
The main objective is to demonstrate how to create and handle SOAP services in Ruby, including:

- Processing SOAP requests.
- Extracting data from the request body.
- Responding with a SOAP-formatted result.

## Why Ruby?
Ruby is a dynamic and easy-to-use language, ideal for creating simple servers and handling custom logic. While there are libraries such as `savon` to make handling SOAP services easier, this project demonstrates how to manually process SOAP requests and responses for complete control over formatting and logic.

## What does the code do?
1. **Define a `Calculator` class**:
- Contains an `add` method that adds two numbers.

2. **Start an HTTP server with WEBrick**:
- Listen on port `3000`.
- Process POST requests at the root (`/`).

3. **Process SOAP requests**:
- Extract numbers from the `<web:num1>` and `<web:num2>` elements of the SOAP request body.
- Calculate the sum result.
- Return a SOAP response with the result.

4. **Error handling**:
- Return an HTTP 400 status code if the request is invalid.
- Return an HTTP 404 status code for undefined paths.

## Project setup and startup

### Prerequisites
- [Ruby](https://www.ruby-lang.org/) installed on your machine.
- A text editor or IDE.

### Steps to get started
1. **Clone the repository**:
```bash
git clone https://github.com/jdhidal/Use-Soap.git
cd use-Soap
```

2. **Run the server**:
```bash
ruby file_name.rb
```
By default, the server will listen on port `3000`.

3. **Test the service**:
You can use tools like Postman, curl, or PowerShell to send SOAP requests.

### Test example with PowerShell
Use the following PowerShell script to send a SOAP request to the server:

``powershell
# Define the server URL
$url = "http://localhost:3000/"

# Define the SOAP request body (XML)
$soapEnvelope = @"
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:web="http://www.example.com/webservice">
 <soapenv:Header/>
 <soapenv:Body>
 <web:add>
 <web:num1>5</web:num1>
 <web:num2>3</web:num2>
 </web:add>
</soapenv:Body>
</soapenv:Envelope>
"@

# Set the request headers
$headers = @{
"Content-Type" = "text/xml"
}

# Send the POST request with the SOAP body
$response = Invoke-WebRequest -Uri $url -Method Post -Headers $headers -Body $soapEnvelope

# Display the response
$response.Content
```

### Expected response
If the server is working correctly, you should receive a response like the following:

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:web="http://www.example.com/webservice">
<soapenv:Header/>
<soapenv:Body>
<web:addResponse>
<web:result>8</web:result>
</web:addResponse>
</soapenv:Body>
</soapenv:Envelope>
```

## Project structure
- **Main file**: Contains the WEBrick server and the logic to handle SOAP requests.
- **`Calculator` class**: Defines the `add` method that performs the addition operation.

## Additional notes
- The server is a basic implementation to demonstrate SOAP concepts.
- You can extend the code to handle other mathematical operations or add authentication.

## License
This project is licensed under the MIT License. Feel free to modify it and adapt it to your needs.

