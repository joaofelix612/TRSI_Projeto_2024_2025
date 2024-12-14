#!/bin/bash

if uname -r >/dev/null 2>&1; then
    if grep -q Microsoft /proc/version 2>/dev/null; then
        echo -e "\033[1;34m Isto é um sistema Windows a correr um ambiente Linux (WSL).\033[0m"
    elif [ -n "$WINDIR" ] || [ -n "$OS" ] && [ "$OS" == "Windows_NT" ]; then
        echo -e "\033[1;33m Isto é um sistema baseado em Windows a correr Bash.\033[0m"
    else
        echo -e "\033[1;32m Isto é um sistema baseado em Linux.\033[0m"
    fi
else
    echo -e "\033[1;31m Não sabemos qual é o sistema operativo usado.\033[0m"
fi

show_menu() {
    echo "Escolha uma opção:"
    echo "1) Backup de ficheiros"
    echo "2) Limpeza de ficheiros temporários"
    echo "3) Monitorizar uso de disco"
    echo "4) Verificar estado dos serviços"
    echo "5) Atualizar pacotes do sistema"
    echo "6) Monitorizar uso de CPU e memória"
    echo "7) Verificar registos de segurança"
    echo "8) Gerir utilizadores"
    echo "9) Verificar estado dos processos"
    echo "10) Sair"
}

check_processes() {
    echo "A verificar os processos em execução..."
    ps aux
}

monitor_disk_usage() {
    echo "Diga qual o disco que quer ler:"
    read disco
    df -h | grep "^$disco"
}

check_services() {
    echo "Digite o nome do serviço (Por exemplo BTAGService):"
    read servico
    if [[ $(uname) == "Linux" ]]; then
        systemctl status $servico
    elif [[ $(uname) == "Darwin" ]]; then
        echo "MacOS não tem o systemctl. Utilize outro método."
    else
        sc.exe query $servico
    fi
}

monitor_cpu_memory() {
    if [[ $(uname) == "Linux" ]]; then
        cpuLoad=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
        freeMemory=$(free -m | awk '/Mem:/ {print $4}')
        echo "CPU Load: $cpuLoad%"
        echo "Free Memory: $freeMemory MB"
    else
        cpuLoad=$(wmic cpu get loadpercentage /format:value | grep -oP '\d+')
        freeMemoryKB=$(wmic OS get freephysicalmemory /format:value | sed 's/FreePhysicalMemory=//' | tr -d '[:space:]')
        freeMemoryMB=$((freeMemoryKB / 1024))
        freeMemoryGB=$((freeMemoryMB / 1024))
        echo "CPU Load: $cpuLoad%"
        echo "Free Memory: $freeMemoryGB GB"
    fi
}

update_system() {
    if [[ $(uname) == "Linux" ]]; then
        echo "Atenção! este comando só funciona em sistemas como Ubuntu."
        read -p "Pressione Enter para continuar ou CTRL+C para cancelar..."
        sudo apt update && sudo apt upgrade -y
    else
        echo "Em sistemas Windows, não há comando de atualização de pacotes."
    fi
}

manage_users() {
    if [[ $(uname) == "Linux" ]]; then
        sudo getent passwd
    else
        net user
    fi
}

backup_files() {
    echo "Por favor insira o nome do ficheiro para backup (Exemplo: ficheiro.txt):"
    read ficheiro

    if [[ ! -f "$ficheiro" ]]; then
        echo "O ficheiro '$ficheiro' não existe."
        exit 1
    fi

    data=$(date +"%d%b%Y")
    backup_nome="${ficheiro%.*}_$data.${ficheiro##*.}"

    cp "$ficheiro" "$backup_nome"
    echo "Backup criado com sucesso: $backup_nome"
}

clear_temp_files() {
    if [[ $(uname) == "Linux" ]]; then
        echo "A limpar arquivos temporários em Linux..."
        sudo rm -rf /tmp/*
    elif [[ $(uname) == "Darwin" ]]; then
        echo "A limpar arquivos temporários em macOS..."
        rm -rf /private/var/folders/*/*
    else
        echo "A limpar arquivos temporários em Windows..."
       powershell -Command "Start-Process cmd.exe -ArgumentList '/c del %TEMP%\*.* /f /s /q' -Verb RunAs"
    fi
}

check_security_log() {
    if [[ $(uname) == "Linux" ]]; then
        echo "A verificar os logs de segurança em Linux..."
        sudo cat /var/log/auth.log | tail -n 20 
    elif [[ $(uname) == "Darwin" ]]; then
        echo "A verificar os logs de segurança em macOS (pode ocorrer erros)..."
        sudo log show --last 1d  
    else

    echo "A verificar os logs de segurança em Windows..."

       powershell -Command "
        Start-Process powershell -Verb runAs -ArgumentList {
            \$outputFile = [System.IO.Path]::Combine(\$env:USERPROFILE, 'Documents', 'SecurityLogs.txt')
            if (-not (Test-Path -Path 'HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\\EnableLUA')) {
                \$logs = Get-WinEvent -LogName Security | Select-Object -First 20 | Format-List TimeCreated, Message
                # Salva os logs no arquivo
                \$logs | Out-File -FilePath \$outputFile -Force
            }
        }"
    fi
    echo "Ficheiro guardado na pasta de documentos"
}


exit_program() {
    echo "A sair do script..."
    exit 0 
}

ask_continue() {
    read -p "Deseja continuar? (s/n): " choice
    if [[ $choice == "n" || $choice == "N" ]]; then
        exit_program
    fi
}

while true; do
    show_menu
    read -p "Digite o número da opção: " option
    case $option in
        1) backup_files; ask_continue ;;
        2) clear_temp_files; ask_continue ;;
        3) monitor_disk_usage; ask_continue ;;
        4) check_services; ask_continue ;;
        5) update_system; ask_continue ;;
        6) monitor_cpu_memory; ask_continue ;;
        7) check_security_log; ask_continue ;;
        8) manage_users; ask_continue ;;
        9) check_processes; ask_continue ;;
        10) exit_program ;;
        *) echo "Opção inválida!"; ask_continue ;;
    esac
done
