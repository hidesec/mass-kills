#!/bin/sh
#Author hidesec(Raihan H. Q.)
RCol='\e[0m'    # Text Reset

# Regular           Bold                Underline           High Intensity      BoldHigh Intens     Background          High Intensity Backgrounds
Bla='\e[0;30m';     BBla='\e[1;30m';    UBla='\e[4;30m';    IBla='\e[0;90m';    BIBla='\e[1;90m';   On_Bla='\e[40m';    On_IBla='\e[0;100m';
Red='\e[0;31m';     BRed='\e[1;31m';    URed='\e[4;31m';    IRed='\e[0;91m';    BIRed='\e[1;91m';   On_Red='\e[41m';    On_IRed='\e[0;101m';
Gre='\e[0;32m';     BGre='\e[1;32m';    UGre='\e[4;32m';    IGre='\e[0;92m';    BIGre='\e[1;92m';   On_Gre='\e[42m';    On_IGre='\e[0;102m';
Yel='\e[0;33m';     BYel='\e[1;33m';    UYel='\e[4;33m';    IYel='\e[0;93m';    BIYel='\e[1;93m';   On_Yel='\e[43m';    On_IYel='\e[0;103m';
Blu='\e[0;34m';     BBlu='\e[1;34m';    UBlu='\e[4;34m';    IBlu='\e[0;94m';    BIBlu='\e[1;94m';   On_Blu='\e[44m';    On_IBlu='\e[0;104m';
Pur='\e[0;35m';     BPur='\e[1;35m';    UPur='\e[4;35m';    IPur='\e[0;95m';    BIPur='\e[1;95m';   On_Pur='\e[45m';    On_IPur='\e[0;105m';
Cya='\e[0;36m';     BCya='\e[1;36m';    UCya='\e[4;36m';    ICya='\e[0;96m';    BICya='\e[1;96m';   On_Cya='\e[46m';    On_ICya='\e[0;106m';
Whi='\e[0;37m';     BWhi='\e[1;37m';    UWhi='\e[4;37m';    IWhi='\e[0;97m';    BIWhi='\e[1;97m';   On_Whi='\e[47m';    On_IWhi='\e[0;107m';
    targets=""
    port="443"

while :
do
    read -p "$(echo "${Blu}MassKills/mass-sslv3-poodle${RCol}>") " f

     setTarget()
    {
        export targets=$1
    }
    showOption(){
        echo ""
        echo "  ${BYel}please fill in this table:"
        echo "    ${Whi}|==============================================|"
        echo "    ${Whi}|    ${BGre}Name    ${Whi}|    ${BGre}Value    ${Whi}|       ${BGre}Desc        ${Whi}|"
        echo "    ${Whi}|==============================================|"
        echo "    ${Whi}| ${BGre}Target     ${Whi}|   ${Red}$targets          ${Whi}| ${BRed}ex: targets.txt   ${Whi}|"
        echo "    ${Whi}| ${BGre}Port       ${Whi}|   ${Red}$port       ${Whi}| ${BRed}default: 443      ${Whi}|"
        echo "    ${Whi}|==============================================|"
        echo ""

    }

    running(){
        if [ ! -f $targets ]; then
            echo "File not found!"
        elif [ -f $targets ]; then
            echo "Running..."
            # scanning
            while read -r line
            do
                nmap -sV --version-light --script ssl-poodle -p 443  $line > output.txt
                vuln="`grep "VULNERABLE" output.txt | head -1 | sed 's/|   //' | sed 's/.$//'`"
                if [ $vuln ]; then
                    echo "${Whi}$line${Rcol} -> ${Gre}VULNERABLE!${Rcol}"
                else
                    echo "${Whi}$line${Rcol} -> ${Red}NOT VULNERABLE!${Rcol}"
                fi
                rm -rf output.txt
            done < $targets
        fi



    }

    case $f in
        # 1)
        #     ./any/mass-ssl-poodle.sh		    
		# ;;
        help | -h | -help)
            echo ""
            echo "      ${BGre}-h                   ${Gre}Help"
            echo "      ${BGre}show options         ${Gre}Show Setting Mass"
            echo "      ${BGre}set <name> <value>   ${Gre}Set Value Options"
            echo "      ${BGre}clear                ${Gre}Clear Console"
            echo "      ${BGre}exit                 ${Gre}Exit Program"
            echo ""
        ;;
         "set target")
         read -p "set target : " ra
                setTarget $ra
                echo "${BGre}Target set!"
        ;;
        "show options")
                showOption
        ;;
        run)
            running
        ;;
        clear)
            clear >$(tty)
        ;;
        exit)
            exit 0
        ;;
        *)
            echo "${BRed}unknown!"
        ;;
    esac
done
