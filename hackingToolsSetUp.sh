#!/bin/bash

# ----------------------------------
# Colors
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

print_color(){

	text=$1
	color_name=$2
        if [ $color_name == "RED" ];then
                echo -e "${RED}[*]${NOCOLOR}${text}"
        fi
        if [ $color_name == "GREEN" ];then
                echo -e "${GREEN}[*]${NOCOLOR}${text}"
        fi
        if [ $color_name == "WHITE" ];then
                echo -e "${WHITE}[*]${NOCOLOR}${text}"
        fi
        if [ $color_name == "BLUE" ];then
                echo -e "${BLUE}[*]${NOCOLOR}${text}"
        fi
        if [ $color_name == "PURPLE" ];then
                echo -e "${GREEN}[*]${NOCOLOR}${text}"
        fi
}

create_directory_tree(){
	if [ -d "hackingTools" ];then
		print_color "hackingTools directory found. Maybe there is nothing to do here." "BLUE"
	fi
		mkdir hackingTools 2> /dev/null; cd hackingTools 2> /dev/null
		mkdir web wifi privesc windows anon 2> /dev/null
		mkdir privesc/linux privesc/windows 2> /dev/null
}

banner(){
	echo "****************************************************"
	echo -e "*** ${WHITE}W1S3M4N ${BLUE}HACKING TOOLS${NOCOLOR} Downloader & Installer ***"
        echo "****************************************************"

}


## INIT
clear
banner
create_directory_tree

install=$1

###### WEB TOOLS ######
cd web
print_color "[Web] Checking for web tools..." "BLUE"

## TestSSL.sh

print_color "[Web] Checking for ${PURPLE}testssl${NOCOLOR}..." "BLUE"

if [ -d "testssl.sh" ];then

	print_color "[Web] Testssl found. Trying to update it..." "BLUE"
	cd testssl.sh
	git pull origin master &> /dev/null
else

	print_color "[Web] Testssl not found. Donwloading it..." "BLUE"
	git clone https://github.com/drwetter/testssl.sh.git &> /dev/null
	print_color "[Web] Testssl downloaded." "BLUE"
	cd "testssl.sh"
        if [ "$install" != "-n" ];then
                print_color "[Web] Installing testssl..." "BLUE"
                directory=$(pwd)
	        echo "alias testssl=${directory}/testssl.sh/testssl.sh" >> ~/.bashrc
        fi
fi
print_color "[Web] Done!" "GREEN"
cd ..

## Dirsearch

print_color "[Web] Checking for ${PURPLE}Dirsearch${NOCOLOR}..." "BLUE"

if [ -d "dirsearch" ];then

        print_color "[Web] Dirsearch found. Trying to update it..." "BLUE"
        cd dirsearch
        git pull origin master &> /dev/null
else

        print_color "[Web] Dirsearch not found. Donwloading it..." "BLUE"
        git clone https://github.com/maurosoria/dirsearch.git &> /dev/null
        print_color "[Web] Dirsearch downloaded. Now installing..." "BLUE"
        cd dirsearch
        if [ "$install" != "-n" ];then
                directory=$(pwd)
                echo "alias dirsearch=python3.7 ${directory}/dirsearch/dirsearch.py" >> ~/.bashrc
        fi
fi
print_color "[Web] Done!" "GREEN"
cd ..

## Gobuster

print_color "[Web] Checking for ${PURPLE}Gobuster${NOCOLOR}..." "BLUE"

if [ -f "gobuster" ];then

        print_color "[web] Gobuster found. Nothing to do." "GREEN"

else
	print_color "[Web] Gobuster not found. Donwloading it..." "BLUE"
	arch=$(uname -m)

	if [ "${arch}" == "i836" ];then
		wget https://github.com/OJ/gobuster/releases/download/v3.0.1/gobuster-linux-386.7z &> /dev/null
		7z e gobuster-linux-386.7z &> /dev/null
		rm -rf gobuster-linux-386.7z
	else
		wget https://github.com/OJ/gobuster/releases/download/v3.0.1/gobuster-linux-amd64.7z &> /dev/null
                7z e gobuster-linux-amd64.7z &> /dev/null
		rm -rf gobuster-linux-amd64.7z
	fi

        print_color "[Web] Gobuster downloaded." "BLUE"
        
        if [ "$install" != "-n" ];then
                print_color "[Web] Now installing..." "BLUE"
                cp gobuster /usr/bin/
        	chmod +x /usr/bin/gobuster
        fi
fi
print_color "[Web] Done!" "GREEN"
## CMSeek

print_color "[Web] Checking for ${PURPLE}CMSeek${NOCOLOR}..." "BLUE"

if [ -d "CMSeeK" ];then

        print_color "[Web] CMSeek found. Trying to update it..." "BLUE"
        cd CMSeeK
        git pull origin master &> /dev/null
        cd ..
else

        print_color "[Web] CMSeeK not found. Donwloading it..." "BLUE"
        git clone https://github.com/Tuhinshubhra/CMSeeK.git &> /dev/null
        print_color "[Web] CMSeek downloaded. Now installing..." "BLUE"
        if [ "$install" != "-n" ];then
                cd CMSeeK
                pip3 install -r requirements.txt &> /dev/null
                directory=$(pwd)
                echo "alias cmseek=python3.7 ${directory}/cmseek.py" >> ~/.bashrc
                cd ..
        fi

fi
print_color "[Web] Done!" "GREEN"


## Clickjacking PoC

print_color "[Web] Checking for ${PURPLE}clickjacking.html${NOCOLOR}..." "BLUE"

if [ -f "clickjacking.html" ];then

        print_color "[Web] Clickjacking PoC found. Nothing to do." "GREEN"

else
	print_color "[Web] Writing clickjacking payload on 'clickjacking.html...'" "BLUE"
	sleep 0.5
	print_color  "[Web] PAYLOAD:" "BLUE"
	sleep 1
	echo -e '<html>\n   <head>\n     <title>Clickjack test page</title>\n   </head>\n   <body>\n     <p>Website is vulnerable to clickjacking!</p>\n     <iframe src="web" width="500" height="500"></iframe>\n   </body>\n</html>'
	echo -e '<html>\n   <head>\n     <title>Clickjack test page</title>\n   </head>\n   <body>\n     <p>Website is vulnerable to clickjacking!</p>\n     <iframe src="web" width="500" height="500"></iframe>\n   </body>\n</html>' > clickjacking.html
fi
print_color "[Web] Done!" "GREEN"
cd ..
print_color "[Web] Tools checked!" "GREEN"


###### WIFI ######
cd wifi
## Airgeddon

print_color "[WiFi] Checking for ${PURPLE}Airgeddon${NOCOLOR}..." "BLUE"

if [ -d "airgeddon" ];then

        print_color "[WiFi] Airgeddon found. Trying to update it..." "GREEN"
        cd airgeddon
        git pull origin master &> /dev/null
        cd ..
else

        print_color "[WiFi] Airgeddon not found. Donwloading them..." "BLUE"
        git clone https://github.com/v1s1t0r1sh3r3/airgeddon.git &> /dev/null
        print_color "[WiFi] Airgeddon downloaded." "BLUE"
        cd airgeddon
        if [ "$install" != "-n" ];then
                print_color "[WiFi] Installing Airgeddon..." "BLUE"
                directory=$(pwd)
                echo "alias airgeddon=${directory}/airgeddon.sh" >> ~/.bashrc
        fi
        cd ..
fi
print_color "[WiFi] Done!" "GREEN"

## Fluxion

print_color "[WiFi] Checking for ${PURPLE}Fluxion${NOCOLOR}..." "BLUE"

if [ -d "fluxion" ];then

        print_color "[WiFi] Fluxion found. Trying to update it..." "GREEN"
        cd fluxion
        git pull origin master &> /dev/null
        cd ..
else

        print_color "[WiFi] Fluxion not found. Donwloading them..." "BLUE"
        git clone https://github.com/wi-fi-analyzer/fluxion.git &> /dev/null
        print_color "[WiFi] Fluxion downloaded." "BLUE"
        cd fluxion
        if [ "$install" != "-n" ];then
                print_color "[WiFi] Installing Fluxion..." "BLUE"
                directory=$(pwd)
                echo "alias fluxion=${directory}/fluxion.sh" >> ~/.bashrc
        fi
        cd ..
fi
print_color "[WiFi] Done!" "GREEN"
cd ..

###### PRIVESC ######
cd privesc
print_color "[PrivEsc] Checking for privilege escalation tools..." "BLUE"

## General
### BeRoot
print_color "[PrivEsc] Checking for ${PURPLE}BeRoot${NOCOLOR}..." "BLUE"

if [ -d "linux/BeRoot" ];then

        print_color "[PrivEsc] BeRoot found. Nothing to do." "GREEN"
else

        print_color "[PrivEsc] BeRoot not found. Donwloading it..." "BLUE"
        git clone https://github.com/AlessandroZ/BeRoot.git &> /dev/null
        print_color "[PrivEsc] BeRoot downloaded. Configuring..." "BLUE"
        mkdir linux/BeRoot windows/BeRoot
        mv BeRoot/Linux/* linux/BeRoot
        mv BeRoot/Windows/* windows/BeRoot
        rm -rf BeRoot
fi
print_color "[PrivEsc] Done!" "GREEN"

## Linux
print_color "[PrivEsc-Linux] Checking Linux PrivEsc tools..." "BLUE"
cd linux

### CheckExploits.py
print_color "[PrivEsc-Linux] Checking for ${PURPLE}CheckExploits.py${NOCOLOR}..." "BLUE"

if [ -f "check-exploits.py" ];then

        print_color "[PrivEsc-Linux] CheckExploits found. Nothing to do." "GREEN"
else

        print_color "[PrivEsc-Linux] BeRoot not found. Donwloading it..." "BLUE"
        curl -O -k https://raw.githubusercontent.com/so87/OSCP-PwK/master/check-exploits.py &> /dev/null
fi
print_color "[PrivEsc-Linux] Done!" "GREEN"

## linux-exploit-suggester

print_color "[PrivEsc-Linux] Checking for ${PURPLE}Linux-Exploit-Suggester${NOCOLOR}..." "BLUE"

if [ -f "linux-exploit-suggester.sh" ];then

        print_color "[PrivEsc-Linux] Linux Exploit Suggester found. Nothing to do." "BLUE"
else

        print_color "[PrivEsc-Linux] Linux Exploit Suggester not found. Donwloading it..." "BLUE"
        git clone https://github.com/mzet-/linux-exploit-suggester.git &> /dev/null
        mv linux-exploit-suggester/linux-exploit-suggester.sh .
        rm -rf linux-exploit-suggester
        print_color "[PrivEsc-Linux] Linux Exploit SUggester downloaded." "BLUE"
fi
print_color "[PrivEsc-Linux] Done!" "GREEN"

## Exploit Suggester Perl
print_color "[PrivEsc-Linux] Checking for ${PURPLE}Linux-Exploit-Suggester (Perl port)${NOCOLOR}..." "BLUE"

if [ -f "Linux_Exploit_Suggester.pl" ];then

        print_color "[PrivEsc-Linux] Linux Exploit Suggester (Perl) found. Nothing to do." "BLUE"
else

        print_color "[PrivEsc-Linux] Linux Exploit Suggester (Perl) not found. Donwloading it..." "BLUE"
        git clone https://github.com/InteliSecureLabs/Linux_Exploit_Suggester.git &> /dev/null
        mv Linux_Exploit_Suggester/Linux_Exploit_Suggester.pl .
        rm -rf Linux_Exploit_Suggester
        print_color "[PrivEsc-Linux] Linux Exploit SUggester (Perl) downloaded." "BLUE"
fi
print_color "[PrivEsc-Linux] Done!" "GREEN"


## LinEnum
print_color "[PrivEsc-Linux] Checking for ${PURPLE}LinEnum${NOCOLOR}..." "BLUE"

if [ -f "LinEnum.sh" ];then

        print_color "[PrivEsc-Linux] LinEnum found. Nothing to do." "BLUE"
else

        print_color "[PrivEsc-Linux] LinEnum not found. Donwloading it..." "BLUE"
        git clone https://github.com/rebootuser/LinEnum.git &> /dev/null
        mv LinEnum/LinEnum.sh .
        rm -rf LinEnum
        print_color "[PrivEsc-Linux]  downloaded." "BLUE"
fi
print_color "[PrivEsc-Linux] Done!" "GREEN"


## LinuxPrivChecker
print_color "[PrivEsc-Linux] Checking for ${PURPLE}LinuxPrivChecker${NOCOLOR}..." "BLUE"

if [ -f "linuxprivchecker.py" ];then

        print_color "[PrivEsc-Linux] LinuxPrivChecker found. Nothing to do." "BLUE"
else

        print_color "[PrivEsc-Linux] LinuxPrivChecker not found. Donwloading it..." "BLUE"
        git clone https://github.com/sleventyeleven/linuxprivchecker.git &> /dev/null
        mv linuxprivchecker/linuxprivchecker.py .
        print_color "[PrivEsc-Linux] LinEnum downloaded." "BLUE"
fi
print_color "[PrivEsc-Linux] Done!" "GREEN"

## Unix-privEsc-Check
print_color "[PrivEsc-Linux] Checking for ${PURPLE}unix-privesc-check${NOCOLOR}..." "BLUE"

if [ -f "unix-privesc-check.sh" ] && [ -d "unix-privesc-check" ];then

        print_color "[PrivEsc-Linux] Unix-privesc-check found. Nothing to do." "BLUE"
else

        print_color "[PrivEsc-Linux] Unix-privesc-check not found correctly. Donwloading it (2 versions of it)..." "BLUE"
        rm -rf unix-privesc-check*
        curl -O -k https://raw.githubusercontent.com/pentestmonkey/unix-privesc-check/1_x/unix-privesc-check &> /dev/null
        mv unix-privesc-check unix-privesc-check.sh
        git clone https://github.com/pentestmonkey/unix-privesc-check.git &> /dev/null
        print_color "[PrivEsc-Linux] Unix-privesc-check downloaded." "BLUE"
fi
print_color "[PrivEsc-Linux] Done!" "GREEN"
print_color "[PrivEsc-Linux] tools checked!" "GREEN"

## Windows
print_color "[PrivEsc-Windows] Checking Windows PrivEsc tools..." "BLUE"
cd ..
cd  windows

## JuicyPotato
print_color "[PrivEsc-Windows] Checking for ${PURPLE}JuicyPotato${NOCOLOR}..." "BLUE"

if [ -f "JuicyPotato.exe" ];then

        print_color "[PrivEsc-Windows] JuicyPotato found. Nothing to do." "BLUE"
else

        print_color "[PrivEsc-Windows] JoicyPotato not found. Donwloading it..." "BLUE"
        curl -O -k https://github.com/ohpe/juicy-potato/releases/download/v0.1/JuicyPotato.exe &> /dev/null
        print_color "[PrivEsc-Windows] JuicyPotato downloaded." "BLUE"
fi
print_color "[PrivEsc-Windows] Done!" "GREEN"

## BloodHound
print_color "[PrivEsc-Windows] Checking for ${PURPLE}BloodHound${NOCOLOR}..." "BLUE"

if [ -d "BloodHound" ];then

        print_color "[PrivEsc-Windows] BloodHound found. Trying to update it..." "BLUE"
        cd BloodHound
        git pull origin master &> /dev/null
        cd ..
else

        print_color "[PrivEsc-Windows] BloodHound not found. Donwloading it..." "BLUE"
        git clone https://github.com/BloodHoundAD/BloodHound.git &> /dev/null
        print_color "[PrivEsc-Windows] BloodHound downloaded." "BLUE"
fi
print_color "[PrivEsc-Windows] Done!" "GREEN"

## Mimikatz
print_color "[PrivEsc-Windows] Checking for ${PURPLE}Mimikatz${NOCOLOR}..." "BLUE"

if [ -d "mimikatz" ];then

        print_color "[PrivEsc-Windows] Mimikatz found. Nothing to do.." "BLUE"
else
        print_color "[PrivEsc-Windows] Mimikatz not found. Donwloading it..." "BLUE"
        mkdir mimikatz
        curl -O -k https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20200208/mimikatz_trunk.7z &> /dev/null
        7z e mimikatz_trunk.7z -omimikatz &> /dev/null
        rm -rf mimikatz_trunk.7z
        print_color "[PrivEsc-Windows] Mimikatz downloaded." "BLUE"
fi
print_color "[PrivEsc-Windows] Done!" "GREEN"

## JAWS
print_color "[PrivEsc-Windows] Checking for ${PURPLE}JAWS${NOCOLOR}..." "BLUE"

if [ -f "jaws-enum.ps1" ];then

        print_color "[PrivEsc-Windows] JAWS found. Nothing to do." "BLUE"
else
        print_color "[PrivEsc-Windows] BloodHound not found. Donwloading it..." "BLUE"
        curl -O https://raw.githubusercontent.com/411Hall/JAWS/master/jaws-enum.ps1 &> /dev/null
        print_color "[PrivEsc-Windows] JAWS downloaded." "BLUE"
fi
print_color "[PrivEsc-Windows] Done!" "GREEN"

## PowerSploit
print_color "[PrivEsc-Windows] Checking for ${PURPLE}PowerSploit${NOCOLOR}..." "BLUE"

if [ -d "PowerSploit" ];then

        print_color "[PrivEsc-Windows] PowerSploit found. Trying to update it..." "BLUE"
        cd PowerSploit
        git pull origin master &> /dev/null
        cd ..
else

        print_color "[PrivEsc-Windows] PowerSploit not found. Donwloading it..." "BLUE"
        git clone https://github.com/PowerShellMafia/PowerSploit.git &> /dev/null
        print_color "[PrivEsc-Windows] PowerSploit downloaded." "BLUE"
fi
print_color "[PrivEsc-Windows] Done!" "GREEN"

## Tater/HotPotatoPs1
print_color "[PrivEsc-Windows] Checking for ${PURPLE}Tater${NOCOLOR}..." "BLUE"

if [ -f "Tater.ps1" ];then

        print_color "[PrivEsc-Windows] Tater found. Nothing to do." "BLUE"
else
        print_color "[PrivEsc-Windows] Tater not found. Donwloading it..." "BLUE"
        git clone https://github.com/Kevin-Robertson/Tater.git &> /dev/null
        mv Tater/Tater.ps1 .
        rm -rf Tater
fi
print_color "[PrivEsc-Windows] Tater downloaded." "BLUE"
print_color "[PrivEsc-Windows] Done!" "GREEN"

## Windows-exploit-sugester
print_color "[PrivEsc-Windows] Checking for ${PURPLE}Windows-exploit-sugester${NOCOLOR}..." "BLUE"

if [ -f "windows-exploit-suggester.py" ];then

        print_color "[PrivEsc-Windows] Windows-exploit-sugester found. Trying to update it..." "BLUE"
        rm -rf windows-exploit-suggester.py
else
        print_color "[PrivEsc-Windows] Windows-exploit-sugester not found. Donwloading it..." "BLUE"
fi
git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester.git &> /dev/null
mv Windows-Exploit-Suggester/windows-exploit-suggester.py .
rm -rf Windows-Exploit-Suggester
print_color "[PrivEsc-Windows] Windows-exploit-sugester downloaded." "BLUE"
print_color "[PrivEsc-Windows] Done!" "GREEN"

## Windows-Privesc-Check
print_color "[PrivEsc-Windows] Checking for ${PURPLE}Windows-Privesc-Check${NOCOLOR}..." "BLUE"

if [ -d "windows-privesc-check" ];then

        print_color "[PrivEsc-Windows] Windows-Privesc-Check found. Trying to update it..." "BLUE"
        cd windows-privesc-check
        git pull origin master &> /dev/null
        cd ..
else

        print_color "[PrivEsc-Windows] Windows-Privesc-Check not found. Donwloading it..." "BLUE"
        git clone https://github.com/pentestmonkey/windows-privesc-check.git &> /dev/null
        print_color "[PrivEsc-Windows] Windows-Privesc-Check downloaded." "BLUE"
fi
print_color "[PrivEsc-Windows] Done!" "GREEN"

## WinPrivCheck
print_color "[PrivEsc-Windows] Checking for ${PURPLE}WinPrivCheck${NOCOLOR}..." "BLUE"

if [ -f "WinPrivCheck.bat" ];then

        print_color "[PrivEsc-Windows] WinPrivCheck found. Nothing to do." "BLUE"
else
        print_color "[PrivEsc-Windows] WinPrivCheck not found. Donwloading it..." "BLUE"
        curl -O -k https://raw.githubusercontent.com/codingo/OSCP-2/master/Windows/WinPrivCheck.bat &> /dev/null
        print_color "[PrivEsc-Windows] WinPrivCheck downloaded." "BLUE"
fi
print_color "[PrivEsc-Windows] Done!" "GREEN"
cd ..

###### GENERAL TOOLS ######
cd ..
print_color "[Misc] Checking for miscellaneous tools..." "BLUE"

## AutoRecon
print_color "[Misc] Checking for ${PURPLE}AutoRecon${NOCOLOR}..." "BLUE"

if [ -d "AutoRecon" ];then

        print_color "[Misc] AutoRecon found. Nothing to do." "GREEN"
        cd AutoRecon
        git pull origin master &> /dev/null
        cd ..
else

        print_color "[Misc] AutoRecon not found. Donwloading it..." "BLUE"
        git clone https://github.com/Tib3rius/AutoRecon.git &> /dev/null
        print_color "[Misc] AutoRecon downloaded." "BLUE"
        cd AutoRecon
        if [ "$install" != "-n" ];then
                print_color "[Misc] Installing AutoRecon..." "BLUE"
                pip3 install -r requirements.txt &> /dev/null
                directory=$(pwd)
                echo "alias autorecon=python3.7 ${directory}/autorecon.py" >> ~/.bashrc
        fi
        cd ..
fi
print_color "[Misc] Done!" "GREEN"

## SecList
print_color "[Misc] Checking for ${PURPLE}SecLists${NOCOLOR}..." "BLUE"

if [ -d "SecLists" ];then

        print_color "[Misc] SecLists found. Trying to update it..." "GREEN"
        cd SecLists
        git pull origin master &> /dev/null
        cd ..
else
        print_color "[Misc] SecLists not found. Donwloading them..." "BLUE"
        git clone https://github.com/danielmiessler/SecLists.git &> /dev/null
        print_color "[Misc] SecLists downloaded." "BLUE"
fi
print_color "[Misc] Done!" "GREEN"
echo -e "${GREEN}[*]${NOCOLOR}Script executed. ${RED}Happy hacking! ;)${NOCOLOR}"