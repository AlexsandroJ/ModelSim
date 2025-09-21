

# menu.do - Menu interativo para ModelSim

proc mostrar_menu {} {
    puts "\n===================================="
    puts "     MENU INTERATIVO MODELSIM"
    puts "===================================="
    puts "1 Compilar tudo"
    puts "2 Executar testes da ULA"
    puts "3 Executar testes do Decodificador de Instrucoes"
    puts "0 Sair"
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
    vlog -sv ula.sv tb_ula.sv instruction_decoder.sv tb_instruction_decoder.sv
    puts "> Compilacao concluida!"
}

proc testes_ula {} {
    puts "\n> Executando testes da ULA..."
    vsim -c tb_ula
    run -all
}

proc testes_instruction_decoder {} {
    puts "\n> Executando testes do Decodificador de Instrucoes..."
    vsim -c tb_instruction_decoder
    run -all
}


# Loop principal
while {1} {
    mostrar_menu
    set escolha [ler_opcao]

    switch -exact -- $escolha {
        "1" { compilar }
        "2" { compilar; testes_ula }
        "3" { compilar; testes_instruction_decoder }    
        "0" {
            puts "\n> Saindo... Ate logo!"
            break
        }
        default {
            puts "\n> Opcao invalida: '$escolha'. Tente novamente."
        }
    }

    if {$escolha == "0"} break
}