# Verifica se o script está sendo executado como administrador
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

# Verifica se a política de execução permite a execução de scripts
$execPolicy = Get-ExecutionPolicy
if ($execPolicy -ne "RemoteSigned" -and $execPolicy -ne "Unrestricted") {
    Write-Host "Ajustando a política de execução para permitir a execução deste script..."
    try {
        Set-ExecutionPolicy RemoteSigned -Scope Process -Force
    } catch {
        Write-Host "Não foi possível ajustar a política de execução. Execute este script manualmente como administrador após ajustar a política de execução."
        pause
        exit
    }
}

# Definição das funções

function vocetemcerteza {
    $vocetemcerteza = Read-Host "Você deseja sair? (s/n)"  
    if ($vocetemcerteza -eq "s") {
        Exit
    } elseif ($vocetemcerteza -eq "n") {
        mainmenu
    } else {
        Write-Host -ForegroundColor Red "Opção inválida."
        vocetemcerteza  
    }
}

# function WallPaper {
#     $wallpapervalue = Read-Host -Prompt "Coloque o Caminho do Papel de Parede "
#     Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name "WallPaper" -Value $wallpapervalue 
#     pause
# }

function deltemp{
    $tempfolders = @(“C:\Windows\Temp\*”, “C:\Windows\Prefetch\*”, “C:\Documents and Settings\*\Local Settings\temp\*”, “C:\Users\*\Appdata\Local\Temp\*”)

    
    Remove-Item $tempfolders -force -recurse -ErrorAction SilentlyContinue 
    Write-Host " Maquina limpa com sucesso "
    Pause
}

# function TV{
#     new-item -Path 'C:\TV' -ItemType Directory -ErrorAction SilentlyContinue 
#     Invoke-WebRequest -Uri “https://898.tv/ftconsult” -OutFile “C:\TV\Tv_Host.exe”

#     Start-Process "C:\TV\Tv_Host.exe" -ArgumentList "/S" -Wait
#     Remove-Item -path "C:\TV" -recurse


#     Write-Output "TeamViewer instalado com sucesso."
#     Pause
# }


# function contaRH {
#     # Detectar o idioma do sistema operacional
#     $language = (Get-WinSystemLocale).Name

#     net user "FT Consult" ft@redhouse2000! /add;
#     net user "Red House" redhouse@2020 /add;
#     # Definir os comandos de acordo com o idioma
#     if ($language -like "pt-BR*") {
#         # Comandos em português
#         $addAdminCommand = "net localgroup Administradores 'FT Consult' /add"
#         $removeUserCommand = "net localgroup Usuários 'FT Consult' /delete"
#     } else {
#         # Comandos em inglês
#         $addAdminCommand = "net localgroup Administrators 'FT Consult' /add"
#         $removeUserCommand = "net localgroup Users 'FT Consult' /delete"
#     }

# # Executar os comandos
# Invoke-Expression $addAdminCommand
# Invoke-Expression $removeUserCommand


# Write-Output "========================================================================================================================"
# Write-Output "                                                     Usuários criado com sucesso"
# Write-Output "========================================================================================================================"

Pause
}

function rodardism{
    sfc /scannow;
    $dismaceitar = Read-Host "Deseja rodar o DISM? (s/n)";
    


    if($dismaceitar -eq "s"){
        $pergunta2 = Read-Host "Para verificar se há corrupção na imagem do Windows(CheckHealth)--> DIGITE [c]
                                Para realizar uma verificação mais completa para detectar corrupção na imagem(ScanHealth)--> DIGITE [s]
                                Para reparar a imagem do Windows usando arquivos de origem especificados(RestoreHealth)--> DIGITE [r]
                                
                                Digite uma das opções: ";

        if($pergunta2 -eq "c"){
            dism /Online /Cleanup-Image /CheckHealth
        }elseif($pergunta -eq "s"){dism /Online /Cleanup-Image /ScanHealth}
        elseif($pergunta2 -eq "r"){dism /Online /Cleanup-Image /RestoreHealth}
        else{Write-Host -ForegroundColor Red "Opção inválida."$pergunta2}
        Write-Output "Comando concluído com sucesso---Voltando ao menu principal"
        Start-Sleep 2
    }elseif($dismaceitar -eq "n"){
        goto mainmenu
    }else{
         Write-Host -ForegroundColor Red "Opção inválida."
         $dismaceitar
    }

}

function menuempresas {
    Clear-Host
    Write-Output "" 
    Write-Output ""
    Write-Output ""
    Write-Output "                                        Selecione o usuário que deseja criar"
    Write-Output "                                   Lembrando que será criado usuário admin e padrão " 
    Write-Output "" 
    Write-Output "1. Red House"
    Write-Output "Em breve mais usuários"
    Write-Output""
    Write-Output""
    Write-Output "0. Menu principal"
    Write-Output""
    Write-Output""
    $respostas2 = Read-Host "Escolha uma das Opções"

    switch($respostas2){
    0 {clear-host; mainmenu}    
    1 {clear-host; contaRH; Pause}
    }

}

function appAdolixPDf{

    Invoke-WebRequest -Uri “https://www.adolix.com/download/AdolixSplitMergePDFSetup.exe?utm_source=site” -OutFile “C:\AdolixSplitMergePDFSetup.exe”

    Start-Process "C:\AdolixSplitMergePDFSetup.exe" -ArgumentList "/S" -Wait

    Remove-Item -path "C:\AdolixSplitMergePDFSetup.exe" -recurse


    Write-Output "Adolix Free PDF instalado com sucesso."
    Pause

}

function appCompareIT{
    Invoke-WebRequest -Uri “https://www.grigsoft.com/wincmp-setup.exe” -OutFile “C:\compareit.exe”

    Start-Process "C:\compareit.exe" -ArgumentList "/S" -Wait

    Remove-Item -path "C:\compareit.exe" -recurse

    Write-Output "CompareIT instalado com sucesso."
    Pause
}

function appItau{
    Invoke-WebRequest -Uri “https://guardiao.itau.com.br/UpdateServer/aplicativoitau.msi” -OutFile “C:\aplicativoitau.msi”

    Start-Process msiexec.exe -ArgumentList "/i C:\aplicativoitau.msi /quiet" -Wait


    Remove-Item -path "C:\aplicativoitau.msi" -recurse

    Write-Output "Itaú instalado com sucesso."
    Pause
}

function appBradesco {
    Invoke-WebRequest -Uri “    https://banco.bradesco/assets/pessoajuridica/aplicativos/navegador-exclusivo/windows/Instalador_NEB_4.1.0.exe
” -OutFile “C:\bradesco.exe”

    Start-Process "C:\bradesco.exe" -ArgumentList "/S" -Wait

    Remove-Item -path "C:\bradesco.exe" -recurse

    Write-Output "Bradesco instalado com sucesso."
    Pause
}

function useradminFT{
    # Define a nova senha como uma string segura
    $senha = ConvertTo-SecureString -AsPlainText "ft@redhouse2000!" -Force

    # Obter nome do usuário atual
    $UserName = (Get-WmiObject -Class Win32_Process -Filter "name = 'explorer.exe'").GetOwner().User

    # Verificar e alterar nome de usuário e senha
    if ($UserName -eq "FT Consult") {
        Rename-LocalUser -Name "FT Consult" -NewName "FTConsult"
        Set-LocalUser -Name "FTConsult" -Password $senha
    } elseif ($UserName -eq "FTConsult") {
        Set-LocalUser -Name "FTConsult" -Password $senha
    } else {
        Rename-LocalUser -Name $UserName -NewName "FTConsult"
        Set-LocalUser -Name "FTConsult" -Password $senha
    }

    Write-Output "O nome de usuário foi alterado para FTConsult e a senha foi definida. Lembrando que para a alteração fazer efeito você deve sair e entrar novamente do perfil"

    Pause

}


function installfull{

    Write-Host "Atualizando Windows..."
    Get-WindowsUpdate -Install;

    Write-Host "Atualizando atualizações opcionais..."
    Get-WindowsOptionalFeature -Online | Where-Object {$_.State -eq "Disabled"} | Enable-WindowsOptionalFeature -Online;

    Write-Host "Atualizando aplicativos da Microsoft Store..."
    (Get-AppxPackage -AllUsers).InstallLocation | Get-ChildItem -Path *.appx | ForEach-Object { Add-AppxPackage -Path $_.FullName -DisableDevelopmentMode -ForceApplicationShutdown };


    Write-Host "Atualizando Instalador de Aplicativos da Microsoft..."
    winget upgrade --all;

    pause
}

# function menucomlpletoRedHouse {
#     useradminFT;
#     Net user 'Red House' redhouse@2020 /add;
#     winget install --id=Google.Chrome -e; winget install --id=Mozilla.Firefox -e; winget install --	id=Adobe.Acrobat.Reader.64-bit -e; winget install --id=Microsoft.Teams -e;





#     Pause
# }
function menulux{
    Clear-Host
    Write-Output "" 
    Write-Output ""
    Write-Output ""
    Write-Output "                                           Escolha o departamento para download dos apps" 
    Write-Output ""
    Write-Output "1. Middle"
    Write-Output "Contém os seguintes apps--->[Google Chrome|Notepad++|Visual Studio Code|Winrar|Zoom|Python|Adobe reader|OpenVPN|Anaconda3|Go To|SQL Server|Microsoft To Do|Compare IT|Office{em breve}]"
    Write-Output ""
    Write-Output "2. Gestão"
    Write-Output "Contém os seguintes apps--->[Google Chrome|Firefox|Visual Studio Code|Winrar|Python|Power BI|Microsoft To Do|Teams|OpenVPN|Q-dir{em breve}|Adolix PDF Free|Adobe Reader|GoTo|Office|Anaconda|SQL Server]"
    Write-Output ""
    Write-Output "3. Financeiro/ADM"
    Write-Output "Contém os seguintes apps--->[Gogle Chrome|Bradesco|Itaú|Adobe Reader|OpenVPN|Office{em breve}|GoTo|SQL Server]"
    Write-Output ""
    Write-Output "4. Comercial"
    Write-Output "Contém os seguintes apps--->[Google Chrome|Winrar|GoTo|SQL Server|Office{em breve}|OpenVPN]"
    Write-Output ""
    Write-Output ""
    Write-Output "0. Menu principal"
    Write-Output ""
    Write-Output ""
    
    $resposta3 = Read-Host "Escolha uma das Opções"


    switch($resposta3){
        1{Clear-Host; winget install --id=Python.Python.3.0 -e; winget install --id=Google.Chrome -e;winget install --id=Zoom.Zoom -e; winget install --id=Notepad++.Notepad++ -e; winget install --id=RARLab.WinRAR -e;winget install --id=Microsoft.VisualStudioCode -e;winget install --id=Adobe.Acrobat.Reader.64-bit -e;winget install --id=OpenVPNTechnologies.OpenVPN -e;winget install --id=Anaconda.Anaconda3 -e;winget install --id=GoTo.GoTo -e; winget install --id=Microsoft.SQLServerManagementStudio -e;winget install --id Microsoft.Todos;appCompareIT}

        2{Clear-Host;winget install --id=Python.Python.3.0 -e;winget install --id=Google.Chrome -e;winget install --id=Microsoft.VisualStudioCode -e;winget install --id=RARLab.WinRAR -e;winget install --id=Mozilla.Firefox -e;winget install --id Microsoft.Todos;winget install --id=OpenVPNTechnologies.OpenVPN -e;winget install --id=Microsoft.Teams  -e;winget install --id=GoTo.GoTo -e;winget install --id=Adobe.Acrobat.Reader.64-bit -e;winget install --id=Microsoft.PowerBI  -e;winget install --id=Anaconda.Anaconda3 -e;winget install --id=Microsoft.SQLServerManagementStudio -e;appAdolixPDf}

        3{Clear-Host;winget install --id=Google.Chrome -e;winget install --id=Adobe.Acrobat.Reader.64-bit -e;winget install --id=OpenVPNTechnologies.OpenVPN -e;winget install --id=GoTo.GoTo -e;winget install --id=Microsoft.SQLServerManagementStudio -e;appItau; appBradesco}

        4{Clear-Host;winget install --id=Google.Chrome -e;winget install --id=RARLab.WinRAR -e;winget install --id=GoTo.GoTo -e;winget install --id=Microsoft.SQLServerManagementStudio -e;winget install --id=OpenVPNTechnologies.OpenVPN -e;}

        0{Clear-Host; mainmenu}
    }

}

function wallpaperzmes{
    $perguntawall = Read-Host 'Você enviou a imagem para o disco local C com o nome de wallpaper.png? (s/n)'
    if ($perguntawall -eq 's'){
        $lockScreenImagePath = "C:\wallpaper.png"
        Set-ItemProperty -Path 'HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\PersonalizationCSP' -Name 'LockScreenImagePath' -Value $lockScreenImagePath

        Write-Output"===================================================================================================================="
        Write-Output "                           Imagem alterada com sucesso! Caso não apareça, reinicie o computador"
        Write-Output"===================================================================================================================="

        Pause
    }elseif($perguntawall -eq 'n'){

        Write-Output ""
        Write-Output "Então arraste a imagem para o disco local C"

        Write-Output ""
        Pause
        menuzmes

        
    }else{
        Write-Output "Opção inválida"
        Pause
    }
    
}

function menuzmes{
    Clear-Host
    Write-Output"===================================================================================================================="
    Write-Output "                                              Menu Zmes"
    Write-Output"===================================================================================================================="

    Write-Output "1. Baixar apps zmes"
    Write-Output "2. Alterar Plano de fundo"
    Write-Output "0. Menu principal"
    Write-Output ""    
    $resposta4 = Read-host 'Escolha uma opção'
    


    switch($resposta4){
        0{clear-host; mainmenu}
        1{clear-host; winget install --id=Google.Chrome -e; winget install --id=Mozilla.Firefox -e; winget install --	id=Adobe.Acrobat.Reader.64-bit -e; winget install --id=Microsoft.Teams -e; TV;winget install --id=SlackTechnologies.Slack  -e }
        2{clear-host; wallpaperzmes}
        
    
    }
}

function mainmenu {
    Clear-Host
    Write-Output "" 
    Write-Output ""
    Write-Output ""
    Write-Output "                                        Todos os direitos reservados © Igor Lima - 2024" 
    Write-Output "                                           Escolha uma das opções abaixo" 
    Write-Output "" 
    Write-Output "1. Pacote de arquivos 1"
    Write-Output " Contém os seguintes apps--->[Adobe reader|Firefox|Google Chrome|Teams|TV{em breve}]"
    Write-Output ""
    Write-Output "2. Criar usuários" 
    Write-Output ""
    Write-Output "3. Pacote de arquivos 2"
    Write-Output " Contém os seguintes apps--->[Adobe reader|Firefox|Google Chrome|Teams|Dell command|Java|Winrar|TV{em breve}|Office{em breve}]"
    Write-Output ""
    Write-Output "4. Atualizar todos os apps"
    Write-Output ""
    Write-Output "5. Lux Energia instaladores"
    Write-Output ""
    Write-Output "6. Limpar arquivos temporários"
    Write-Output ""
    Write-Output "7. Instalar TeamViewer{em breve}"
    Write-Output ""
    Write-Output "8. Roda Sfc Scan + DISM"
    Write-Output ""
    Write-Output "9. Antivírus do Windows"
    Write-Output ""
    Write-Output "10. Zmes"
    Write-Output " Contém os seguintes apps--->[Adobe reader|Firefox|Google Chrome|Teams|TV|Slack]"
    Write-Output ""
    Write-Output "11. FMC"
    Write-Output " Neste pacote contém os seguintes apps: [Adobe reader|Firefox|Google Chrome|Teams|TV|AnyDesk|Office]"
    Write-Output ""
    Write-Output ""
    Write-Output "" 
    Write-Output "0. Para Fechar Instalador Autônomo" 
    Write-Output ""
    Write-Output ""
    $resposta = Read-Host "Escolha uma das Opções"



    switch ($resposta) {
    1 { Clear-Host; winget install --id=Google.Chrome -e; winget install --id=Mozilla.Firefox -e; winget install --	id=Adobe.Acrobat.Reader.64-bit -e; winget install --id=Microsoft.Teams -e;}
	2{clear-host; menuempresas}
    3 { Clear-Host; winget install --id=Oracle.JavaRuntimeEnvironment  -e; winget install --id=dell.CommandUpdate  -	e; winget install --id=Microsoft.Teams  -e; winget install --id=Mozilla.Firefox -e;winget install --id=Google.Chrome -e;id=Adobe.Acrobat.Reader.64-bit -e;winget install --id=RARLab.WinRAR  -e}
    4 { Clear-Host; winget upgrade --all}
    5 { Clear-Host; menulux}
    6 { Clear-Host; deltemp}
    # 7 {Clear-Host; TV}
    8{Clear-Host; rodardism}
    9 { Clear-Host; mrt }
    10{clear-host; menuzmes}
    11{clear-host; winget install --id=AnyDeskSoftwareGmbH.AnyDesk  -e;winget install --id=Google.Chrome -e; winget install --id=Mozilla.Firefox -e; winget install --	id=Adobe.Acrobat.Reader.64-bit -e; winget install --id=Microsoft.Teams -e;}
    12{clear-host; installfull}

        0 { vocetemcerteza }
        default {
            Write-Output ""
            Write-Host -ForegroundColor Magenta ""
            Start-Sleep 1
            Clear-Host
            mainmenu
        }
    }

    # Retornar ao menu principal após a execução de uma ação
    mainmenu
}

# Iniciar o menu principal
mainmenu