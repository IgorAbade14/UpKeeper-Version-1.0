#!/bin/bash

# ================================================================= #
# PROJETO: UpKeeper v1.0
# DESCRIÇÃO: Automação de manutenção mensal com interface gráfica.
# OBJETIVO: Verificar se é final de semana e se a manutenção do mês
#           corrente já foi realizada.
# ================================================================= #

# --- 1. CAPTURA E DEFINIÇÃO DE VARIÁVEIS ---
# %u captura o dia (1-7), %m captura o mês (01-12)
DIA_SEMANA=$(date +%u)
MES_ATUAL=$(date +%m)
USUARIO=$(whoami)

# Definindo o local onde o script salvará o "estado" (memória)
# Usamos $HOME para que o script funcione em qualquer computador
ARQUIVO_MEMORIA="$HOME/DevOpsLab/UpKeeper/logs/ultimo_mes.txt"

# --- 2. PREPARAÇÃO DO AMBIENTE (AUTO-HEALING) ---
# Garante que as pastas necessárias existam antes da execução
mkdir -p "$(dirname "$ARQUIVO_MEMORIA")"

# Tenta ler o conteúdo do arquivo de memória.
# Se o arquivo não existir (2>/dev/null), define como "00" para permitir a comparação.
ULTIMA_ATT=$(cat "$ARQUIVO_MEMORIA" 2>/dev/null || echo "00")

# --- 3. LÓGICA DE DECISÃO ---
# Condição: Se for Sábado/Domingo (>= 6) E o mês atual for diferente da última manutenção
if [[ $DIA_SEMANA -ge 6 && $MES_ATUAL != $ULTIMA_ATT ]]; then

    # Dispara interface gráfica para interação com o usuário
    if zenity --question \
        --title="UpKeeper v1.0" \
        --text="Olá $USUARIO! Identifiquei que a manutenção mensal ainda não foi feita. Deseja iniciar?" \
        --ok-label="Sim" \
        --cancel-label="Não" \
        --icon-name="system-software-update" \
        --width=350; then

        # --- 4. EXECUÇÃO DOS COMANDOS DE SISTEMA ---
        # Abre uma nova instância de terminal para que o usuário veja o progresso do apt
        gnome-terminal -- bash -c "
            echo 'Iniciando atualização do sistema...';
            sudo apt update && sudo apt full-upgrade -y;
            
            # Verifica se os comandos acima terminaram com sucesso (Exit Code 0)
            if [ \$? -eq 0 ]; then
                # Redireciona o mês atual para o arquivo de memória (Salva o estado)
                echo $MES_ATUAL > $ARQUIVO_MEMORIA;
                echo 'Sucesso! O registro de manutenção foi atualizado.';
            else
                echo 'Houve um erro na atualização. O registro não foi alterado.';
            fi;
            
            echo 'Este terminal fechará automaticamente em 5 segundos...';
            sleep 5"
    fi
fi

