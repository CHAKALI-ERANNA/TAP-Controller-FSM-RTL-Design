`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module TAP_FSM( input TMS, TCK, TRST

    );
    parameter Test_Logic_Reset = 4'd0;
    parameter Run_Test_Idle = 4'd1;
    parameter Select_DR_Scan = 4'd2;
    parameter Capture_DR = 4'd3;
    parameter Shift_DR = 4'd4;
    parameter Exit1_DR = 4'd5;
    parameter Pause_DR = 4'd6;
    parameter Exit2_DR = 4'd7;
    parameter Update_DR = 4'd8;
    parameter Select_IR_Scan = 4'd9;
    parameter Capture_IR = 4'd10;
    parameter Shift_IR = 4'd11;
    parameter Exit1_IR = 4'd12;
    parameter Pause_IR = 4'd13;
    parameter Exit2_IR = 4'd14;
    parameter Update_IR = 4'd15;
    
    reg [3:0]cur_state,nxt_state;
    
    // state updation
    always@(posedge TCK)
    begin
        if(TRST)
            cur_state <= Test_Logic_Reset;
        else
            cur_state <= nxt_state;
    end
    
    // state transition
    always@(cur_state, TMS)
    begin
         case(cur_state)
         Test_Logic_Reset : begin
                                if(TMS)
                                    nxt_state <= Test_Logic_Reset;
                                else
                                    nxt_state <= Run_Test_Idle;
                            end
                            
         Run_Test_Idle : begin
                            if(TMS)
                                nxt_state <= Select_DR_Scan;
                            else
                                nxt_state <= Run_Test_Idle;
                        end
         Select_DR_Scan : begin
                             if(TMS)
                                nxt_state <= Select_IR_Scan;
                             else
                                nxt_state <= Capture_DR;
                          end
         Capture_DR : begin
                        if(TMS)
                            nxt_state <= Exit1_DR;
                        else
                            nxt_state <= Shift_DR;
                      end
         Shift_DR : begin
                        if(TMS)
                            nxt_state <= Exit1_DR;
                        else
                            nxt_state <= Shift_DR;
                    end
         Exit1_DR : begin
                        if(TMS)
                            nxt_state <= Update_DR;
                        else
                            nxt_state <= Pause_DR;
                    end
         Pause_DR : begin
                        if(TMS)
                            nxt_state <= Exit2_DR;
                        else
                            nxt_state <= Pause_DR;
                    end
         Exit2_DR : begin
                        if(TMS)
                            nxt_state <= Update_DR;
                        else
                            nxt_state <= Shift_DR;
                    end
         Update_DR : begin
                        if(TMS)
                            nxt_state <= Select_DR_Scan;
                        else
                            nxt_state <= Run_Test_Idle;
                     end
         
         Select_IR_Scan : begin
                            if(TMS)
                                nxt_state <= Test_Logic_Reset;
                            else
                                nxt_state <= Capture_IR;
                          end
         Capture_IR : begin
                        if(TMS)
                            nxt_state <= Exit1_IR;
                        else
                            nxt_state <= Shift_IR;
                      end
         Shift_IR : begin
                        if(TMS)
                            nxt_state <= Exit1_IR;
                        else
                            nxt_state <= Shift_IR;
                    end
         Exit1_IR : begin
                        if(TMS)
                            nxt_state <= Update_IR;
                        else
                            nxt_state <= Pause_IR;
                    end
         Pause_IR : begin
                        if(TMS)
                            nxt_state <= Exit2_IR;
                        else
                            nxt_state <= Pause_IR;
                    end
         Exit2_IR : begin
                        if(TMS)
                            nxt_state <= Update_IR;
                        else
                            nxt_state <= Shift_IR;
                    end
        Update_IR : begin
                        if(TMS)
                            nxt_state <= Select_DR_Scan;
                        else
                            nxt_state <= Run_Test_Idle;
                    end
        default : nxt_state <= Test_Logic_Reset;
    endcase
    end
endmodule
