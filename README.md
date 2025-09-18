# ULA em SystemVerilog

Este projeto implementa uma Unidade Lógica e Aritmética (ULA) em SystemVerilog, incluindo um testbench e um menu interativo para facilitar os testes.

## 📁 Estrutura do Projeto

- `ula.sv`: Implementação da ULA.
- `tb_ula.sv`: Casos de testes para verificação da ULA.
- `m`: Script de menu interativo. Ao executar `do m`, um menu é exibido para facilitar a execução dos testes.

## 🔧 Como Baixar e Executar o Projeto

## 1. Clonar o Repositório do Projeto
Usando o Git, você pode clonar o repositório do seu projeto para obter uma cópia local.

Terminal
```
git clone https://github.com/AlexsandroJ/ModelSim
cd ModelSim
```

## Como Usar

1. **Abra o ModelsSim**  

2. **Va em `change directory` na aba `file` do ModelsSim** 

![diretorio](/src/img/diretorio.png)


3. **Selecione a pasta ModelSim que foi baixada**  

4. **Execute o menu interativo**  
No terminal no ModelSim digite:
```
do m
```
O menu será exibido, permitindo escolher compilar ou rodar os testes na ULA.

![ModelsSim](/src/img/menu.png)

## Requisitos

- [ModelSim](https://www.intel.com.br/content/www/br/pt/software-kit/750666/modelsim-intel-fpgas-standard-edition-software-version-20-1-1.html) ou outro simulador compatível com SystemVerilog.
