#!/usr/bin/bash

#Главное меню
  function main_menu {
    clear
    figlet Dragon
    echo ""
    echo "Выберите программу для запуска: "
    echo "1) Узнать информацию ip "
    echo "2) Узнать информацию Сovid-19 "
    echo "3) Обновить скрипт "
    echo "4) Kali linux "
    echo "5) Termux "
    echo "6) Выход"


    echo -n " Введите ответ: "
    read option
    echo ""

    #опции
    case $option in
      1 ) ip ;;
      2 ) covid_19 ;;
      3 ) update ;;
      4 ) kali ;;
      5 ) termux ;;
      6 ) clear && exit ;;
    esac
  }

#Функция вычисления ip адреса
  function ip {
    clear
    figlet ip
    echo ""
    echo "Выберите опцию: "
    echo "1) Узнать информацию по другому ip "
    echo "2) Узнать информацию по вашему ip "
    echo "3) Вернуться в главное меню"

    echo -n "Уточните информацию: "
    read option
    echo ""

    #Выбор опций для ip
    case $option in
      1 ) other_ip ;;
      2 ) Our_ip ;;
      3 ) main_menu ;;
    esac
  }


  function other_ip {
    clear
    echo ""
    echo ""
    echo -n " Введите ip: "
    read ip
    curl http://api.db-ip.com/v2/free/$ip
    echo ""
    read -rsn1 -p" Нажмите любую кнопку для продолжения "
    ip
  }


  function Our_ip {
    clear
    curl http://api.db-ip.com/v2/free/self/ipAddress
    echo ""
    read -rsn1 -p" Нажмите любую кнопку для продолжения "
    ip
  }


  function covid_19 {
    clear
    echo -n " Введите страну(на английском): "
    read country
    curl -L covid19.trackercli.com/$country
    echo ""
    read -rsn1 -p" Нажмите любую кнопку для продолжения "
    main_menu
  }

  function update {
    git pull
    bash myscript.sh
  }

  function kali {
    clear
    echo ""
    echo " 1)Установить пакет "
    echo " 2)Настройка репозиториев "
    echo " 3)Выйти в главное меню "

    echo -n " Выберите опцию: "
    read option
    case $option in
      1 ) kali_package ;;
      2 ) kali_repository ;;
      3 ) main_menu ;;
    esac
  }

  function kali_package {
    clear
     echo ""
     echo " Установка пакетов при помощи скрипта "
     echo " Разделение пакетов при помощи && "
     echo " Например: Deluge && Zabbix && Gkrellm"
     echo -n " Введите пакет для установки: "
     read package
     sudo apt install $package
     echo ""
     read -rsn1 -p" Нажмите любую кнопку для продолжения "
     kali
  }

  function kali_repository {
    clear
    echo ""
    echo "1) Версия системы "
    echo "2) Проверка файлов репозиториев "
    echo ""
    echo "3) Добавить репозиторий Kali "
    echo "4) Настройка ключей Kali "
    echo ""
    echo "5) Главное меню "
    echo ""

    echo -n "Выберите опцию: "
    read option
    case $option in
      1 ) clear && echo "" && uname -a && echo "" && read -rsn1 -p" Нажмите любую кнопку для продолжения " && kali_repository ;;
      2 ) clear && echo "" && sudo cat /etc/apt/sources.list && echo "" && read -rsn1 -p" Нажмите любую кнопку для продолжения " && kali_repository ;;
      3 ) kali_repository_install ;;
      4 ) keys_kali ;;
      5 ) main_menu ;;
        esac
  }

  function kali_repository_install {
    clear
    echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" | sudo tee /etc/apt/sources.list
    echo ""
    read -rsn1 -p" Нажмите любую кнопку для продолжения "
    kali_repository
  }

  function keys_kali {
    clear
    wget --no-check-certificate http://http.kali.org/kali/pool/main/k/kali-archive-keyring/kali-archive-keyring_2022.1_all.deb
    sudo dpkg -i kali-archive-keyring_2022.1_all.deb
    rm kali-archive-keyring_2022.1_all.deb
    sudo apt update
    echo ""
    read -rsn1 -p" Нажмите любую кнопку для продолжения "
    kali_repository
  }

function termux {
  clear
  figlet Termux
  echo ""
  echo "1) Установка пакетов "
  echo "2) Настройка пакетов "
  echo "3) Главное меню "

  echo -n "Введите ответ: "
  read option
  case $option in
    1 ) install_termux ;;
    2 ) configure_termux ;;
    3 ) main_menu ;;
  esac
}

function install_termux {
  clear
  echo "1) Установить Баннер "
  echo "2) Установить nethunter"

  echo -n "Введите ответ: "
  read option
  case $option in
    1 ) install_banner ;;
    2 ) install_nethunter ;;
  esac
}

function install_banner {
  clear
  apt update -y
  apt install figlet -y
  apt install python2 -y
  pip2 install lolcat
  read -rsn1 -p" Нажмите любую кнопку для продолжения "
  termux
}

function install_nethunter {
  apt-get update -y
  pkg install wget -y
  pkg install python -y
  pkg install python2 -y
  pkg install openssh -y
  pkg install wget openssl-tool proot -y && hash -r && wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Kali/kali.sh && bash kali.sh
}

function configure_termux {
  clear
  echo "1) Настройка баннера "
  echo "2) Назад"

  echo -n " Введите ответ: "
  read option
  case $option in
    1 ) banner_configure ;;
    2 ) termux ;;
  esac
}

function banner_configure {
  clear
  figlet banner
  echo "  "
  echo ""
  read -p "  [~] Баннер:" banner
  read -p "  [~] Пользователь:" user
  echo ""
  rm -rf ~/../usr/etc/motd
  echo "clear && figlet '$banner' | lolcat" >> ~/../usr/etc/bash.bashrc
  echo "PS1='[ $user : \w ]'" >> ~/../usr/etc/bash.bashrc
  echo "Перезапустите Termux"
  echo ""
  read -rsn1 -p" Нажмите любую кнопку для продолжения "
  exit
  exit
}

main_menu
