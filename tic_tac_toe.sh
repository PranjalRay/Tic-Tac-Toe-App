#!/bin/bash

board=(" " " " " " " " " " " " " " " " " ")
current_player="X"
print_board() {
  echo ""
  echo " ${board[0]} | ${board[1]} | ${board[2]} "
  echo "---+---+---"
  echo " ${board[3]} | ${board[4]} | ${board[5]} "
  echo "---+---+---"
  echo " ${board[6]} | ${board[7]} | ${board[8]} "
  echo ""
}

check_win(){
  local p=$1
  local combos=(
    "0 1 2" "3 4 5" "6 7 8"
    "0 3 6" "1 4 7" "2 5 8"
    "0 4 8" "2 4 6"
  )
  for combo in "${combos[@]}"; do
    read -r i j k <<< "$combo"
    if [["${board[$i]}"=="$p" && "${board[$j]}"=="$p" && "${board[$k]}"=="$p" ]]; then
      return 0
    fi
  done
  return 1
}

check_draw() {
  for cell in "${board[@]}"; do
    if [["$cell"==" "]]; then
      return 1
    fi
  done
  return 0
}

while true; do
  print_board
  echo "Player $current_player's turn (1-9): "
  read -r move
  if ![["$move"=~^[1-9]$]]; then
    echo "Invalid input. Choose a number from 1 to 9."
    continue
  fi
  index=$((move-1))
  if[["${board[$index]}"!=" "]]; then
    echo "Cell already taken. Choose another."
    continue
  fi
  board[$index]=$current_player
  if check_win "$current_player"; then
    print_board
    echo "Player $current_player wins!"
    break
  elif check_draw; then
    print_board
    echo "It's a draw!"
    break
  fi
  current_player=$([["$current_player"=="X"]] && echo "O" || echo "X")
done
