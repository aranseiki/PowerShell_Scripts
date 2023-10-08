# Lê a requisição do cliente
$networkStream = $cliente.GetStream()
$reader = [System.IO.StreamReader]::new($networkStream)
$request = $reader.ReadLine()

# Verifica se a requisição é um handshake WebSocket
if ($request -match "Sec-WebSocket-Key:") {
    # Recupera a chave do cabeçalho do cliente
    $clientKey = $request -replace ".*Sec-WebSocket-Key: (.+).*", '$1'
    
    # Calcula a chave de resposta (WebSocket protocol magic string + clientKey + SHA-1 hash)
    $magicString = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"
    $combinedKey = $clientKey + $magicString
    $sha1 = [System.Security.Cryptography.SHA1]::Create()
    $hashedBytes = $sha1.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($combinedKey))
    $responseKey = [Convert]::ToBase64String($hashedBytes)

    # Monta a resposta do servidor
    $response = "HTTP/1.1 101 Switching Protocols`r`n"
    $response += "Upgrade: websocket`r`n"
    $response += "Connection: Upgrade`r`n"
    $response += "Sec-WebSocket-Accept: $responseKey`r`n`r`n"

    # Envia a resposta de volta ao cliente
    $writer = [System.IO.StreamWriter]::new($networkStream)
    $writer.Write($response)
    $writer.Flush()

    # Agora a conexão está estabelecida como WebSocket
    Write-Host "Handshake WebSocket bem-sucedido"
} else {
    # A requisição não é um handshake WebSocket válida, você pode tratar isso adequadamente
    Write-Host "Requisição inválida para WebSocket"
}
