

# menu.do - Menu interativo para ModelSim

proc mostrar_menu {} {
    puts "\n===================================="
    puts "     MENU INTERATIVO MODELSIM"
    puts "===================================="
    puts "1 Compilar apenas"
    puts "2 Executar testes rapidos"
    puts "3 Sair"
    puts "===================================="
    puts -nonewline "Escolha uma opcao 1-3: "
    flush stdout
}

proc ler_opcao {} {
    set opcao [gets stdin]
    return $opcao
}

proc compilar {} {
    puts "\n> Compilando arquivos..."
    vlib work
    vlog -sv ula.sv tb_ula.sv
    puts "> Compilacao concluida!"
}

proc testes_rapidos {} {
    puts "\n> Executando testes rapidos..."
    vsim -c tb_ula
    run -all
}

# Loop principal
while {1} {
    mostrar_menu
    set escolha [ler_opcao]

    switch -exact -- $escolha {
        "1" { compilar }
        "2" { compilar; testes_rapidos }
        "3" {
            puts "\n> Saindo... Ate logo!"
            break
        }
        default {
            puts "\n> Opcao invalida: '$escolha'. Tente novamente."
        }
    }

    if {$escolha == "3"} break
}