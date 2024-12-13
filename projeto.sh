#!/bin/bash

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
    echo "Diga qual o disco que quer ler"
    read disco

df -h | grep "^$disk"
}

check_services() {
    echo "Digite o nome do serviço (por exemplo mysql)"
	read servico
	sc.exe query $servico
}

monitor_cpu_memory() {
cpuLoad=$(wmic cpu get loadpercentage /format:value | grep -oP '\d+')
freeMemoryKB=$(wmic OS get freephysicalmemory /format:value | sed 's/FreePhysicalMemory=//' | tr -d '[:space:]')
if [[ -n "$freeMemoryKB" && "$freeMemoryKB" =~ ^[0-9]+$ ]]; then
    freeMemoryMB=$((freeMemoryKB / 1024)) 
    freeMemoryGB=$((freeMemoryMB / 1024)) 
    remainderMB=$((freeMemoryKB % 1024))
    freeMemoryGB=$(printf "%.2f" "$((freeMemoryGB))$decimalGB")
else
    freeMemoryGB="0.00"
fi
echo "CPU Load: $cpuLoad%"
echo "Free Memory: $freeMemoryGB GB"
}

update_system() {
    echo "Atenção! este comando só funciona em sistemas Ubuntu, caso entenda clique no Enter."
	read enter
	apt update | apt upgrade -y
}

manage_users() {
    net user
}

backup_files() {
echo "Por favor insira o nome do ficheiro para backup (Exemplo: ficheiro.txt) (Precisa de estar na mesma diretoria que o bash):"
read ficheiro

if [[ ! -f "$ficheiro" ]]; then
    echo "O ficheiro '$ficheiro' não existe."
    exit 1
fi

data=$(date +"%d%b%Y")

backup_nome="${ficheiro%.*}_$data_backup.${ficheiro##*.}"

cp "$ficheiro" "$backup_nome"

echo "Backup criado com sucesso: $backup_nome"
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
        1) 
            backup_files
            ask_continue
            ;;
        2) 
            clear_temp_files
            ask_continue
            ;;
        3) 
            monitor_disk_usage
            ask_continue
            ;;
        4) 
            check_services
            ask_continue
            ;;
        5) 
            update_system
            ask_continue
            ;;
        6) 
            monitor_cpu_memory
            ask_continue
            ;;
        7) 
            check_security_logs
            ask_continue
            ;;
        8) 
            manage_users
            ask_continue
            ;;
        9) 
            check_processes
            ask_continue
            ;;
        10) 
            exit_program 
            ;;
        *) 
            echo "Opção inválida!"
            ask_continue
            ;;
    esac
done
