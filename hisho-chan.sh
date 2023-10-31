#!/usr/bin/env bash

# ----------------------------------
#-COLORZ-
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

#~WELCOME MESSAGE~
cat << "EOF"
               .       .x+=:.                                                                                    
  .uef^"      @88>    z`    ^%    .uef^"                                     .uef^"                              
:d88E         %8P        .   <k :d88E              u.                      :d88E                      u.    u.   
`888E          .       .@8Ned8" `888E        ...ue888b                 .   `888E             u      x@88k u@88c. 
 888E .z8k   .@88u   .@^%8888"   888E .z8k   888R Y888r           .udR88N   888E .z8k     us888u.  ^"8888""8888" 
 888E~?888L ''888E` x88:  `)8b.  888E~?888L  888R I888>          <888'888k  888E~?888L .@88 "8888"   8888  888R  
 888E  888E   888E  8888N=*8888  888E  888E  888R I888>          9888 'Y"   888E  888E 9888  9888    8888  888R  
 888E  888E   888E   %8"    R88  888E  888E  888R I888>          9888       888E  888E 9888  9888    8888  888R  
 888E  888E   888E    @8Wou 9%   888E  888E u8888cJ888  88888888 9888       888E  888E 9888  9888    8888  888R  
 888E  888E   888&  .888888P`    888E  888E  "*888*P"   88888888 ?8888u../  888E  888E 9888  9888   "*88*" 8888" 
m888N= 888>   R888" `   ^"F     m888N= 888>    'Y"                "8888P'  m888N= 888> "888*""888"    ""   'Y"   
 `Y"   888     ""                `Y"   888                          "P'     `Y"   888   ^Y"   ^Y'                
      J88"                            J88"                                       J88"                            
      @%                              @%                                         @%                              
    :"                              :"                                         :"                                                                                                                                                                     
                                                        [yuyu]
                                                      [893crew~]
EOF

#~CHECK IF YOU ARE CONNECTED TO THE WORLD~
echo " "
wget -q --spider http://google.com

if
  [ $? -eq 0 ]
then
  printf "${GREEN}Ok, you are online, lets begin.${NOCOLOR}"
else
  printf "${RED}Seem like you are offline, where is nothing i can do without internet connection.${NOCOLOR}"
  exit
fi

#~USER AGREEDMENT~
echo " "
read -p 'This script will install, set and deploy boroda. To continue press y/n (to not): ' agree

if
  [ "$agree" == "y" ]; then
  echo 'Lets begin then.'
elif
  [ "$agree" == "n" ]; then
  echo 'Bye then.'
  exit
else
  echo 'Ha-ha, you soo funny...'
exit
fi

#~FUNCTION FOR EXISTENSE~
exists()
{
  command -v "$1" >/dev/null 2>&1
}


#~INSTALLIG BORODA N CHECKING FOR GIT~
echo " "
read -p 'Checking for git, if it installed. If not, i will install it for you - y/n: ' lzt

if
  [ "$lzt" == "n" ]
then
  echo 'Fuck you then.'
  exit
fi

if
  exists git && [ "$lzt" == "y" ]; then
  printf "${GREEN}Git found!${NOCOLOR}"
else
  ! exists git
  printf "${RED}Git not found.${NOLOCOR} Installing."
  apt install git -y 2>/dev/null &
pid=$! # Process Id of the previous running command

spin='-\|/'

i=0
while kill -0 $pid 2>/dev/null
do
  i=$(( (i+1) %4 ))
  printf "\r${spin:$i:1}" " "
  sleep .1
done

  printf "${GREEN}Successful!${NOCOLOR}"
  echo " "
  echo 'Now you have git.'
fi

echo " "
read -p 'Git was found/install, so im ready to install boroda, are you ready - y/n: ' git

if
  [ "$git" == "y" ]
then
  git clone https://github.com/yuyux9/boroda.git 2>/dev/null &
pid=$! # Process Id of the previous running command

spin='-\|/'

i=0
while kill -0 $pid 2>/dev/null
do
  i=$(( (i+1) %4 ))
  printf "\r${spin:$i:1}" " "
  sleep .1
done

printf "${GREEN}Successful!${NOCOLOR}"
echo " "

  cd boroda
  touch ".env"
elif
  [ "$git" == "n" ]
then
  echo 'What do you want from me then, kutabare.'
  exit
else
  echo 'fuck you.'
  exit
fi

#~SETTING UP BORODA~
echo " "
read -p 'Tell me full url of your scoreboard: ' link
read -p 'What team name do you have: ' uname
read -p 'What board type do you have, forcad/hackerdom: ' typo
read -p 'Now tell me your round time: ' rtime
read -p 'Hm, give me yout tg bot url for webhook like usage: ' tgurl
read -p 'In the end i need you to tell me your tg bot token: ' btoken
read -p 'Ok, we are ready to make your config file, cawabanga - y/n: ' cawabanga

if
  [ "$cawabanga" == "y" ]
then
  echo "SCOREBOARD=$link
TEAM=$uname
TYPE=$typo
ROUND_TIME=$rtime
EXTEND_ROUND=5
MONGO_USER=borodaparser
MONGO_PASS=borodaparser
BOT_URL=$tgurl
BOT_TOKEN=$btoken" > '.env'

  printf "${GREEN}Uuh, well, thats it, done.${NOCOLOR}"
elif
  [ "$cawabanga" == "n" ]
then
  echo 'There is need to be y, but you pick n, fuck you, uwu.'
else
  echo 'fuck you.'
  exit
fi

#~DEPLOYING PACMATE~
echo " "
read -p 'Checking for docker, if it installed. If not, i will install it for you - y/n: ' docker

if
  [ "$docker" == "n" ]
then
  echo 'Fuck you then.'
  exit
fi

echo " "

if
  exists docker && [ "$docker" == "y" ]; then
  printf "${GREEN}Docker found!${NOCOLOR}"
  echo " "
else
  ! exists
  printf "${RED}Docker not found.${NOCOLOR} Installing."
  echo " "
    apt install docker -y 2>/dev/null &
pid=$! # Process Id of the previous running command

spin='-\|/'

i=0
while kill -0 $pid 2>/dev/null
do
  i=$(( (i+1) %4 ))
  printf "\r${spin:$i:1}" " "
  sleep .1
done

printf "${GREEN}Successful!${NOCOLOR}"
echo " "

echo " "
echo 'Now you have docker.'
fi

read -p 'Checking for docker-compose, if it installed. If not, i will install it for you - y/n: ' lztt

if
  [ "$lztt" == "n" ]
then
  echo 'Fuck you then.'
  exit
fi

echo " "

if
  exists docker-compose && [ "$lztt" == "y" ]; then
  printf "${GREEN}Docker-compose found!${NOCOLOR}"
else
  ! exists
  printf "${RED}Docker-compose not found.${NOCOLOR} Installing."
  echo " "
  apt install docker-compose -y 2>/dev/null &
pid=$! # Process Id of the previous running command

spin='-\|/'

i=0
while kill -0 $pid 2>/dev/null
do
  i=$(( (i+1) %4 ))
  printf "\r${spin:$i:1}" " "
  sleep .1
done

printf "${GREEN}Successful!${NOCOLOR}"
echo " "

  echo " "
  echo 'Now you have docker-compose.'
fi


echo " "
read -p 'Finally. Now we can deploy your boroda and start analyzing scoreboard! Make some noise - y/n: ' noise

if
  [ "$noise" == "y" ]
then
  sudo docker-compose up --build -d
  echo " "
  echo 'Boroda now running in background, to stop it, type: docker-compose down.'
  echo It should be on localhost:65005
elif
  [ "$noise" == "n" ]
then
  echo 'As you want, cap.'
fi

echo " "
echo "

⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠴⢚⡭⠖⠒⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠐⠦⠥⣒⣢⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣠⠋⣴⣏⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠿⣗⡤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢠⢇⣾⣿⣿⣿⣶⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠳⢭⣒⠤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⢏⣾⣿⣿⣿⣿⣿⣿⣿⣷⣦⣀⡀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠶⣝⡆⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣞⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣷⣶⣶⣦⣤⣤⡾⠿⠿⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢰⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠳⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⡞⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⡞⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠁⠰⠶⣭⡉⠛⠓⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢦⡀⠀⠀⠀⠀⠀⢠⠇⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢸⠃⣿⣿⣿⢿⣿⣿⣿⣿⣿⡿⢫⠀⢠⢶⠭⢭⣦⠙⡮⠀⢹⠀⢀⣀⡤⠤⠔⠒⠶⢶⣖⣒⠒⠢⢿⣂⠀⠀⠀⠀⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⡎⣰⣿⣿⡿⢸⣿⣿⣿⣿⠟⢰⠃⣄⢸⡸⣄⡠⢿⡴⣃⡴⠚⢚⣩⠤⢤⣶⣶⣾⣿⡿⣫⡿⣿⡶⠖⠻⠦⢤⣀⢀⡏⠀⠀⣀⣀⡤⠀
⠀⠀⠀⢰⢫⣿⣿⣿⣇⣨⣿⣿⣿⠏⠀⣾⠠⠼⠦⠭⢄⡸⠞⠉⠁⠐⠉⢀⣴⣾⣿⣿⣿⣿⢟⣵⡿⠁⠈⢳⡈⣓⠦⣈⠓⢽⡳⢤⡐⢛⠁⠀⠀⠀⠀⠀
⠀⠀⢀⣏⣾⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠹⣄⡀⣠⠖⣫⣴⣧⣤⣤⣤⣾⣿⣿⣿⣿⣿⢟⣵⣿⣫⡐⢣⡄⠀⡳⡀⠙⠮⡳⣄⠘⠲⣽⡿⣄⠀⠀⠀⠀⠀
⠀⠀⡼⣾⣿⣿⣿⣿⠙⣟⢿⡏⠀⠀⠀⠀⢀⡝⣡⣾⣿⣿⣿⣿⠿⠋⠩⣿⣿⡿⣟⣵⡿⠋⠁⠐⢷⠀⣷⠀⠹⣷⣄⠀⠈⠻⡷⡄⠚⢳⣌⠳⡀⠀⠀⠀
⠀⢸⡇⣿⣿⣿⣿⣿⡇⢿⣶⠇⠀⠀⢀⡴⢣⣾⣿⣿⣿⡿⠋⠀⠀⢀⡴⢟⣭⣾⡿⣿⣇⢠⠀⠓⢠⡇⢸⣇⠀⢳⡟⠳⡀⠀⠘⣿⡄⠈⢻⣧⢹⠀⠀⠀
⠀⢸⡷⣿⣿⣿⣿⣿⣿⣼⣿⠀⠀⢀⡞⣴⣯⣿⣷⣿⣿⡿⠟⣶⣦⣼⣾⣿⣿⣿⠁⣯⠉⠉⠩⠽⠛⡇⣾⣿⡄⠘⣿⠃⢻⡄⠀⢸⡇⠀⠀⢱⡿⠀⠀⠀
⠀⠀⠙⣿⣿⣿⣿⣿⣿⣷⣻⡄⣰⠏⡾⢛⣛⣫⣭⣽⣶⡟⠉⣣⡆⢿⡛⠋⣼⡏⣼⡏⠀⠀⠀⠂⣼⡿⠋⢸⡇⠀⡟⠇⣼⣿⡀⠈⠀⠀⠀⢀⣷⣄⣀⣀
⠀⠀⠀⠈⠻⣿⣻⣿⣿⣿⣷⣳⡇⠀⠟⢿⠉⠉⠉⡍⣽⠀⠈⢉⣯⣿⢧⡀⣿⣏⠉⠀⠀⠀⢀⣀⠤⠶⢾⣾⠇⢰⠁⢸⡿⣿⠇⢀⠀⠀⣤⣾⣿⠿⠿⠋
⠀⠀⠀⠀⡄⠈⠛⠿⣿⣿⣿⣷⡽⣾⠀⢸⠀⠀⠀⣷⢹⡐⣄⣈⣀⣉⡴⠛⠛⠉⠓⢀⡠⠖⢋⣡⣤⣤⣤⡟⢠⠏⢀⡟⣸⡿⢀⠄⠀⣼⣿⣿⣿⡄⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⣻⠃⡐⢺⣇⠀⠀⢿⣿⣦⠤⠤⠞⠋⠀⠀⠀⢀⡴⢋⣠⣾⣿⣿⣿⣿⠿⡵⠋⣀⣾⡷⢋⣄⣼⣯⣤⣿⣿⠇⢻⣿⠀⠀
⠀⠀⠀⠀⠀⠸⣄⠀⠀⠀⣀⠞⠁⡴⠁⠀⢻⣆⠀⠸⣿⣟⢧⡀⠀⠀⣀⠀⣰⡏⢰⣿⣿⣿⣿⣿⣿⠋⣳⢿⣿⣵⣫⣴⢫⣿⣿⣿⣿⣿⡟⠀⣸⡏⠀⠀
⠀⠀⠀⠀⠀⠀⠙⠿⠭⠍⣤⠀⣸⠃⠀⠀⢠⠙⢷⢄⡘⢿⣦⣀⠀⠀⠇⠈⠛⠿⣶⣿⣿⡿⠋⢉⢴⠾⠃⢠⣾⣿⣿⣿⣸⣿⣿⣿⣿⡟⠀⠴⠋⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⡞⠁⣴⠇⠀⠀⠀⣼⡀⠈⢧⠙⢳⣤⡽⠿⣷⣦⠀⡀⠀⠀⠈⠉⠉⠙⠋⠁⠀⢠⣿⠃⢸⣿⣿⣿⡟⢸⣿⡟⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠸⡅⣰⣻⣤⠀⠀⢀⣧⣇⠀⢫⣆⠀⣇⣿⣿⣿⣿⣿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⣸⡿⣿⣿⡆⠈⣿⠃⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢻⡇⣇⠀⠀⢸⢻⣿⡄⠀⠻⣧⠸⠟⠛⠛⢻⣿⣟⠛⠉⠀⡯⣭⣉⠛⠛⣿⣿⡖⠋⠁⢀⣿⣿⠻⠦⠌⠃⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⡿⣼⡀⠀⢸⣸⣿⣽⢦⡴⠃⢀⣠⣤⡀⠀⠑⡝⢷⣄⡸⠧⢔⣀⡻⢠⣏⠈⡇⠰⠮⣛⢿⠙⠓⠤⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠟⢳⣿⡱⣄⣈⣿⡿⠟⣉⣤⣶⣿⣿⣿⣿⣦⡀⡇⠀⠈⢷⣴⣒⣉⠇⣸⣿⣲⣧⠰⡈⠿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⣴⠀⠀⠻⠆⠈⠻⢧⡹⣹⢏⣥⣾⣿⣿⣿⣿⣿⣿⣿⣿⣹⡇⠀⠀⠀⠹⣿⡛⢠⣿⣟⣛⣿⡄⢡⠴⢻⣷⣄⡀⢀⣀⣠⣤⣤⡤⡀⠀⠀
⠀⠀⠀⢀⣼⣿⡇⠀⠀⠀⠀⠀⠀⢠⢾⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⢻⣿⠿⣿⣶⣿⣿⣇⠀⠾⠛⠛⠧⠻⠯⠞⣋⣥⠽⠆⠉⠙⠀
⠀⠀⢨⣿⡿⠟⠁⠀⠀⠀⠀⣀⡼⣡⣿⣿⣿⣿⣿⣟⣠⣿⣿⣿⣿⣿⣿⣿⡿⠄⠀⠀⠀⢱⠹⣧⣭⢻⡿⣻⡟⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀
⠀⢠⣾⠟⠀⠀⠀⠀⠀⢠⣿⣽⡿⠟⣩⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠈⣦⣼⣇⣿⣷⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⡼⠁⠀⠀⠀⠀⠀⣠⡾⠋⠁⢠⣾⡿⡿⠻⠾⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠰⠛⣿⡤⠠⡈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣼⠃⠀⠀⠀⣠⠔⠋⠁⠀⠀⠐⠋⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⡿⣿⡿⠇⣀⣤⡖⠂⠀⠀⠀⡽⠙⠒⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣤⣄⣤⠞⠉⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⡴⠋⠉⠙⠛⠁⣠⣿⣶⣿⡟⠉⠁⠀⠀⠀⣾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                                                                "
echo " "
echo 'Thanks for using me, take care and good luck ^v^'
echo 'by yuyu from 893crew'