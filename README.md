# TRSI_Projeto_2024_2025
Repositório para o projeto da disciplina de Tecnologias de Scripting e Automação

## Ideia geral do projeto
### Nome do projeto: Ferramenta de Gestão e Monitorização do Sistema (FGMS)
Objetivo Geral:
Criar uma ferramenta multifuncional em Bash que permita a gestão eficiente de um sistema Windows, linux, como também MacOS, embora que seja limitado por algumas syntax, através de um menu interativo. A ferramenta facilitará a execução de tarefas administrativas comuns de forma automatizada e acessível.

### Tecnologias e Pré-requisitos
- Bash versão `GNU bash, versão 5.2.37(1)-release (x86_64-pc-msys)` ou a versão mais recente do Bash.
- Alguns dos comandos precisa da PowerShell em modo Administrativo (Opção 2 & 7 do Menu)
#### Sistemas Operacionais Compatíveis:
- Linux (funcionalidade completa).
- Windows (necessário PowerShell com privilégios administrativos para algumas funções).
- MacOS (funcionalidade limitada devido à compatibilidade da syntax).

## Autores
João Félix <br />
João Gouveia

## Referências e Bibliografia
### Aqui estão listados os anexos dos sites utilizados durante a criação deste projeto. 
Para os comandos PowerShell, recorreu-se à ajuda do ChatGPT, devido à sua complexidade e elevado grau de dificuldade.<br />  
A escolha da PowerShell justificou-se pela necessidade de privilégios administrativos e pela sua superioridade em comparação ao Bash, que, sejamos sinceros, é uma linguagem limitada e muito fraca.<br />  
Os comandos Linux não estão incluídos nesta bibliografia, pois a maioria é simples e pode ser facilmente dominada por praticamente qualquer pessoa. (A maior parte da pesquisa em Linux foi efetuada na documentação oficial *Man*, e não no google).<br />  
Os únicos comandos que exigiram mais esforço e pesquisa foram o `awk` e o `sed`, porque, convenhamos, são ferramentas que realmente requerem maior dedicação para serem dominadas.<br />  
Todos os outros comandos Linux são muito simples 😊<br />

### Comandos Windows Usados
https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/sc-query <br />
https://stackoverflow.com/questions/24503084/wmic-cpu-get-loadpercentage-always-returns-empty-value <br />
https://stackoverflow.com/questions/29249830/how-can-i-get-total-physical-memory-using-windows-cmd <br />
https://www.lifewire.com/net-user-command-2618097 <br />


### Comandos Linux Usados
https://guialinux.uniriotec.br/awk/ <br />
https://stackoverflow.com/questions/49884905/bash-complex-examples-of-sed-command <br />
https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/ <br />

### Comandos MacOS Usados
https://macpaw.com/how-to/delete-files-and-folders-on-mac <br />
https://www.kandji.io/blog/mac-logging-and-the-log-command-a-guide-for-apple-admins <br />
https://stackoverflow.com/questions/47934081/do-the-systemctl-and-service-commands-exist-only-on-linux-and-not-on-mac <br />

### Outros Comandos
https://www.shellscriptx.com/2016/11/criando-menu-textual.html <br />
https://stackoverflow.com/questions/73082720/uname-on-windows-terminal <br />
https://learn.microsoft.com/pt-br/windows/wsl/basic-commands <br />
https://www.banjocode.com/post/wsl/see-if-wsl-bash <br />
https://gist.github.com/gmolveau/d0e3efc219c5bcc6ecc13a1405ac6c73 <br />
https://github.com/microsoft/WSL/issues/844 <br />
https://tldp.org/LDP/abs/html/string-manipulation.html <br />
https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion <br />
https://www.shellhacks.com/bash-colors/ <br />