# Algumas anotações sobre os manifestos

É possível colocar script shell completo, é só colocar qual é o "terminal" que vai executar usando o `` command:`` e colocando um pipe no ``arg:``.
Exemplo do pod-teste.yaml:
``` yaml 
command:
  - /bin/sh
  - -c
args:
  - |
    while true; do
      echo "Executando..." >> /girodir/logs.txt
      sleep 5
	done
```
**Se atente a identação do '|' no script!**
#
## Os containers não se comunicam pelo nome do container
Mesmo na mesma rede, não consegui me conectar com nginx usando o nome do container "webserver", como é possível no docker.
Eu coloquei a conexão como "localhost", e aí sim funcionou.

Exemplo no arquivo pod-completo.yaml:
```yaml
- image: nginx
    name: webserver


  - image: alpine
    name: alpine

    command:
      - /bin/sh
      - -c
    args:
      - |
        apk add --no-cache curl
        while true; do
          echo -e "\n\n===  Executando curl  ===" >> /girologs/logs.txt
          curl http://localhost:80 >> /girologs/logs.txt
          sleep 5
        done
        
```
#  #VAAII!!!
