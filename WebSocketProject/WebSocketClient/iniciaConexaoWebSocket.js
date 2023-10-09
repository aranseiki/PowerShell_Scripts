const socket = new WebSocket("wss://localhost:51957");

socket.addEventListener("open", (event) => {
    console.log("Conexão aberta com sucesso.");
});

socket.addEventListener("message", (event) => {
    console.log("Mensagem recebida do servidor:", event.data);
});

socket.addEventListener("close", (event) => {
    console.log("Conexão fechada.");
});

socket.addEventListener("error", (event) => {
    console.error("Erro na conexão:", event);
});
