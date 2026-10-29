
`timescale 1ns / 1ps

module tb_alu_4bit;

    reg  [3:0] A;
    reg  [3:0] B;
    reg  [3:0] sel;

    wire [3:0] Result;
    wire carry;
    wire zero;
    wire negative;
    wire overflow;

    reg [3:0] expected;

    integer i, j, k;
    integer passed, failed;
    integer flag_passed, flag_failed;

    reg expected_carry;
    reg expected_zero;
    reg expected_negative;
    reg expected_overflow;

    alu_4bit dut (
        .A(A),
        .B(B),
        .sel(sel),
        .Result(Result),
        .carry(carry),
        .zero(zero),
        .negative(negative),
        .overflow(overflow)
    );

    initial begin
        A = 4'b0000;
        B = 4'b0000;
        sel = 4'b0000;
        expected = 4'b0000;

        i = 0;
        j = 0;
        k = 0;

        expected_carry = 1'b0;
        expected_zero = 1'b1;
        expected_negative = 1'b0;
        expected_overflow = 1'b0;

        passed = 0;
        failed = 0;
        flag_passed = 0;
        flag_failed = 0;

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin

                A = i;
                B = j;
                
                sel = 4'b0000;
                expected = i + j;
                #1;
                if (Result !== expected) begin
                    $display("FAIL ADD A=%h B=%h got=%h expected=%h", A, B, Result, expected);
                    failed = failed + 1;
                end else passed = passed + 1;
                
                sel = 4'b0001;
                expected = i - j;
                #1;
                if (Result !== expected) begin
                    $display("FAIL SUB A=%h B=%h got=%h expected=%h", A, B, Result, expected);
                    failed = failed + 1;
                end else passed = passed + 1;

                sel = 4'b0010;
                expected = A & B;
                #1;
                if (Result !== expected) begin
                    $display("FAIL AND A=%h B=%h got=%h expected=%h", A, B, Result, expected);
                    failed = failed + 1;
                end else passed = passed + 1;

                sel = 4'b0011;
                expected = A | B;
                #1;
                if (Result !== expected) begin
                    $display("FAIL OR A=%h B=%h got=%h expected=%h", A, B, Result, expected);
                    failed = failed + 1;
                end else passed = passed + 1;

                sel = 4'b0100;
                expected = A ^ B;
                #1;
                if (Result !== expected) begin
                    $display("FAIL XOR A=%h B=%h got=%h expected=%h", A, B, Result, expected);
                    failed = failed + 1;
                end else passed = passed + 1;

                sel = 4'b0101;
                expected = ($signed(A) < $signed(B)) ? 4'b0001 : 4'b0000;
                #1;
                if (Result !== expected) begin
                    $display("FAIL SLT A=%b B=%b got=%b expected=%b", A, B, Result, expected);
                    failed = failed + 1;
                end else passed = passed + 1;
                
                sel = 4'b0110;
                expected = (A < B) ? 4'b0001 : 4'b0000;
                #1;
                if (Result !== expected) begin
                    $display("FAIL SLTU A=%b B=%b got=%b expected=%b", A, B, Result, expected);
                    failed = failed + 1;
                end else passed = passed + 1;

                sel = 4'b0111;
                expected = ~A;
                #1;
                if (Result !== expected) begin
                    $display("FAIL NOT_A A=%b Result=%b Expected=%b", A, Result, expected);
                    failed = failed + 1;
                end else passed = passed + 1;

                sel = 4'b1000;
                expected = A << 1;
                #1;
                if (Result !== expected) begin
                    $display("FAIL SLL A=%b Result=%b Expected=%b", A, Result, expected);
                    failed = failed + 1;
                end else passed = passed + 1;

                sel = 4'b1001;
                expected = A >> 1;
                #1;
                if (Result !== expected) begin
                    $display("FAIL SRL A=%b Result=%b Expected=%b", A, Result, expected);
                    failed = failed + 1;
                end else passed = passed + 1;

                sel = 4'b1010;
                expected = A;
                #1;
                if (Result !== expected) begin
                    $display("FAIL PASS_A A=%b Result=%b Expected=%b", A, Result, expected);
                    failed = failed + 1;
                end else passed = passed + 1;

            end
        end

        A = 4'h5;
        B = 4'h3;
        sel = 4'b1111;
        #1;

        if (Result !== 4'b0000) begin
            $display("FAIL INVALID RESULT: got=%b expected=0000", Result);
            failed = failed + 1;
        end else begin
            passed = passed + 1;
        end
        
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin

                A = i;
                B = j;

                sel = 4'b0000;
                expected = i + j;
                expected_carry = ((i + j) > 15);
                expected_zero = (expected == 4'b0000);
                expected_negative = expected[3];
                expected_overflow = (~(A[3] ^ B[3])) & (A[3] ^ expected[3]);

                #1;

                if ((carry !== expected_carry) ||
                    (zero !== expected_zero) ||
                    (negative !== expected_negative) ||
                    (overflow !== expected_overflow)) begin

                    flag_failed = flag_failed + 1;

                    $display("ADD FLAG FAIL: A=%b B=%b RESULT=%b C=%b Z=%b N=%b V=%b",
                        A, B, Result, carry, zero, negative, overflow);
                end else begin
                    flag_passed = flag_passed + 1;
                end

                sel = 4'b0001;
                expected = i - j;
                expected_carry = (i >= j);
                expected_zero = (expected == 4'b0000);
                expected_negative = expected[3];
                expected_overflow = (A[3] ^ B[3]) & (A[3] ^ expected[3]);

                #1;

                if ((carry !== expected_carry) ||
                    (zero !== expected_zero) ||
                    (negative !== expected_negative) ||
                    (overflow !== expected_overflow)) begin

                    flag_failed = flag_failed + 1;

                    $display("SUB FLAG FAIL: A=%b B=%b RESULT=%b C=%b Z=%b N=%b V=%b",
                        A, B, Result, carry, zero, negative, overflow);
                end else begin
                    flag_passed = flag_passed + 1;
                end

            end
        end
        
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin

                A = i;
                B = j;

                for (k = 2; k <= 10; k = k + 1) begin

                    sel = k;

                    case (sel)
                        4'b0010: expected = A & B;
                        4'b0011: expected = A | B;
                        4'b0100: expected = A ^ B;
                        4'b0101: expected = ($signed(A) < $signed(B)) ? 4'b0001 : 4'b0000;
                        4'b0110: expected = (A < B) ? 4'b0001 : 4'b0000;
                        4'b0111: expected = ~A;
                        4'b1000: expected = A << 1;
                        4'b1001: expected = A >> 1;
                        4'b1010: expected = A;
                        default: expected = 4'b0000;
                    endcase

                    expected_carry = 1'b0;
                    expected_overflow = 1'b0;
                    expected_zero = (expected == 4'b0000);
                    expected_negative = expected[3];

                    #1;

                    if ((carry !== expected_carry) ||
                        (zero !== expected_zero) ||
                        (negative !== expected_negative) ||
                        (overflow !== expected_overflow)) begin

                        flag_failed = flag_failed + 1;

                        $display("NON-ARITH FLAG FAIL: SEL=%b A=%b B=%b RESULT=%b C=%b Z=%b N=%b V=%b",
                            sel, A, B, Result, carry, zero,negative, overflow);
                        
                    end else begin
                        flag_passed = flag_passed + 1;
                    end

                end
            end
        end
        
        A = 4'h5;
        B = 4'h3;
        sel = 4'b1111;
        #1;

        if ((carry !== 1'b0) ||
            (zero !== 1'b1) ||
            (negative !== 1'b0) ||
            (overflow !== 1'b0)) begin

            $display("FAIL INVALID FLAGS: C=%b Z=%b N=%b V=%b", carry, zero, negative, overflow);
            flag_failed = flag_failed + 1;
        end else begin
            flag_passed = flag_passed + 1;
            $display("INVALID SELECTOR FLAGS PASSED");
        end

        $display("------------------------------------");
        $display("ALU VERIFICATION SUMMARY");
        $display("Result checks passed: %0d", passed);
        $display("Result checks failed: %0d", failed);
        $display("Flag cases passed: %0d", flag_passed);
        $display("Flag cases failed: %0d", flag_failed);
        $display("------------------------------------");

        if ((failed == 0) && (flag_failed == 0))
            $display("ALL TESTS PASSED");
        else
            $display("SOME TESTS FAILED");

        $finish;

    end

endmodule
