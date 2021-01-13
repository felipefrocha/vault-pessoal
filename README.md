# Vault pessoal
---
## Criando o vault
Utilize o [Makefile](Makefile) para configurar e inicializar o seu Vaull pessoal
Nesse momento não será suportado outros OS, apenas o Mac

## Docker como serviço
O [Makefile](Makefile) irá criar um serviço local para o seu usuário permitindo que 
quando o computador reinicie, o Vault ja esteja disponivel

## Instalaçao do client
Utilize a documentação oficial da Hashicorp para instalar o client no mac e utilizar o vault, 
caso não queira crio um alias no .bashrc ou .zshrc com o seguinte comando
````bash
alias vault="docker exec -it vault vault"
````

## Contribua
Faça um fork, adicione o que achar interessante e abra um PR
Será muito bem vindo!!!