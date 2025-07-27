#!/bin/bash

# Получаем активное рабочее пространство
get_active_workspace() {
    # Пробуем JSON сначала
    local active_ws_json=$(hyprctl activeworkspace -j 2>/dev/null)
    if [ -n "$active_ws_json" ] && echo "$active_ws_json" | jq empty 2>/dev/null; then
        echo "$active_ws_json" | jq -r '.id // empty' 2>/dev/null
        return 0
    fi
    
    # Fallback к обычному выводу
    hyprctl activeworkspace 2>/dev/null | grep -oP 'workspace ID \K\d+' | head -1
}

# Получаем информацию о рабочих пространствах
get_workspaces_info() {
    # Пробуем JSON
    local workspaces_json=$(hyprctl workspaces -j 2>/dev/null)
    if [ -n "$workspaces_json" ] && echo "$workspaces_json" | jq empty 2>/dev/null; then
        echo "$workspaces_json" | jq -r '.[] | "\(.id):\(.windows)"' 2>/dev/null | sort -n
        return 0
    fi
    
    # Fallback к парсингу обычного вывода
    local workspaces_output=$(hyprctl workspaces 2>/dev/null)
    
    while IFS= read -r line; do
        if [[ $line =~ ^workspace[[:space:]]+ID[[:space:]]+([0-9]+)[[:space:]]*\(([0-9]+)[[:space:]]+windows\) ]]; then
            echo "${BASH_REMATCH[1]}:${BASH_REMATCH[2]}"
        fi
    done <<< "$workspaces_output" | sort -n
}

# Основная логика
active_ws=$(get_active_workspace)
output=""
active_ws_found=false

while IFS=':' read -r ws_id ws_windows; do
    [ -z "$ws_id" ] && continue
    
    # Отмечаем, что нашли активное рабочее пространство
    if [ "$ws_id" = "$active_ws" ]; then
        active_ws_found=true
    fi
    
    # НЕ пропускаем активное рабочее пространство, даже если в нем нет окон
    if [ -n "$ws_windows" ] && [ "$ws_windows" = "0" ] && [ "$ws_id" != "$active_ws" ]; then
        continue
    fi
    
    # Выделяем активное рабочее пространство
    if [ "$ws_id" = "$active_ws" ] && [ -n "$active_ws" ]; then
        output+="<span foreground=\"#FFFFFF\"><b>$ws_id</b></span> "
    else
        output+="<span foreground=\"#888888\"><b>$ws_id</b></span> "
    fi
done <<< "$(get_workspaces_info)"

# Если активное рабочее пространство не найдено в списке, добавляем его принудительно
if [ "$active_ws_found" = false ] && [ -n "$active_ws" ]; then
    output="<span foreground=\"#FFFFFF\"><b>$active_ws</b></span> $output"
fi

# Выводим результат
if [ -n "$output" ]; then
    echo "$output" | sed 's/ $//'
else
    echo "No active workspaces"
fi