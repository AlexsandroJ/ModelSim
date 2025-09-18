
// tb_ula.sv - Testbench com estilo "Jest" em portugu�s

module tb_ula;

    logic [7:0] A_tb, B_tb, Result_tb;
    logic [1:0] OP_tb;

    // Inst�ncia da ULA
    ula uut (
        .A(A_tb),
        .B(B_tb),
        .OP(OP_tb),
        .Result(Result_tb)
    );

    // Fun��o auxiliar para converter vetor de bits em string (para exibi��o)
    function string slv_to_string(logic [7:0] val);
        slv_to_string = $sformatf("%8b", val);
    endfunction

    // Contadores de teste
    int passed_count = 0;
    int failed_count = 0;

    // Tarefa para executar e verificar um teste
    task run_test(
        string test_name,
        logic [7:0] a_val,
        logic [7:0] b_val,
        logic [1:0] op_val,
        logic [7:0] expected_val
    );
        A_tb = a_val;
        B_tb = b_val;
        OP_tb = op_val;
        #10ns; // Aguarda estabilizar (simulacao de clock cycle)

        if (Result_tb === expected_val) begin
            passed_count++;
            $display("  OK %s", test_name);
        end else begin
            failed_count++;
            $display("  Err:  %s", test_name);
            $display("      Esperado: %8b, Obtido: %8b", expected_val, Result_tb);
            $display("      Esperado: %0d, Obtido: %0d", expected_val, Result_tb);
        end
    endtask

    initial begin
        $display("========================================");
        $display("Suite de Testes da ULA");
        $display("========================================");

        // Teste 1: Soma
        run_test(" somar dois numeros (10 + 5 = 15)",
                 8'd10, 8'd5, 2'b00, 8'd14);

        // Teste 2: Subtracao
        run_test(" subtrair dois numeros (10 - 5 = 5)",
                 8'd10, 8'd5, 2'b01, 8'd5);

        // Teste 3: AND
        run_test(" realizar operacao AND bit a bit (11001100 & 10101010)",
                 8'b11001100, 8'b10101010, 2'b10, 8'b10001000);

        // Teste 4: OR
        run_test(" realizar operacao OR bit a bit (11001100 | 10101010)",
                 8'b11001100, 8'b10101010, 2'b11, 8'b11101110);

        // Resumo final
        $display("========================================");
        $display("Testes: %0d aprovados, %0d falharam", passed_count, failed_count);

        if (failed_count == 0) begin
            $display("Todos os testes foram aprovados com sucesso!");
        end else begin
            $display("Alguns testes falharam. Verifique os erros acima.");
            $fatal(1, "Falha na suite de testes.");
        end

        $finish;
    end

endmodule
