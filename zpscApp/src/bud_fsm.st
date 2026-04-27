/* Sequencer to control the PSC IOC startup Back-Up Dipole.*/


program bud_fsm ("M0=lab{1}, M1=Chan1")



/* ============================================================
   Options
   ------------------------------------------------------------
   +r : Reentrant (allows multiple instances)
   -c : Do not wait for all assigned PVs to connect at startup
   ============================================================ */
   
%%#define PRINTF seqLog
%%#define RES_M 0.000077
%%#define RES_H 0.000020
   
option +r;
option -c;

double fabs(double);


double DAC; 
assign DAC to "{M0}Chan1:DAC_SetPt-SP"; 
monitor DAC; 

double DAC_rdbck; 
assign DAC_rdbck to "{M0}{M1}:DAC-I"; 
monitor DAC_rdbck; 

double dac_adc_ofst; 
assign dac_adc_ofst to "{M0}{M1}:DAC-Offset-SP";  
monitor dac_adc_ofst; 

short ch1_Park; 
assign ch1_Park to "{M0}Chan1:DigOut_Park-SP";
monitor ch1_Park;

short ch2_Park; 
assign ch2_Park to "{M0}Chan2:DigOut_Park-SP";
monitor ch2_Park;

short ch3_Park; 
assign ch3_Park to "{M0}Chan3:DigOut_Park-SP";
monitor ch3_Park;

short ch4_Park; 
assign ch4_Park to "{M0}Chan3:DigOut_Park-SP";
monitor ch4_Park;

/*Will need to be updated for channel to channel unipolar/bipolar operation */
short Polarity; 
assign Polarity to "{M0}Polarity-Mode"; 
monitor Polarity; 

short flt_mask; 
assign flt_mask to "{M0}{M1}:FaultMask:B12-SP"; 
monitor flt_mask; 

short flt_clr; 
assign flt_clr to "{M0}{M1}:FaultClear-SP"; 
monitor flt_clr; 

short ps_on_off; 
assign ps_on_off to "{M0}{M1}:PSOnOff-SP"; 
monitor ps_on_off; 

short ps_on_off_sts; 
assign ps_on_off_sts to "{M0}{M1}:PSOnOff-STS"; 
monitor ps_on_off_sts; 

short ps_on_sts_bip; 
assign ps_on_sts_bip to "{M0}{M1}:DigIn-I.B0"; 
monitor ps_on_sts_bip; 

short ps_on_sts_uni; 
assign ps_on_sts_uni to "{M0}{M1}:DigIn-I.B1"; 
monitor ps_on_sts_uni; 

short ch1_on1_cmd; 
assign ch1_on1_cmd to "{M0}Chan1:DigOut_ON1-SP"; 

short ch1_en_cmd; 
assign ch1_en_cmd to "{M0}Chan1:DigOut_ON2-SP";
monitor ch1_en_cmd; 

short ch2_en_cmd; 
assign ch2_en_cmd to "{M0}Chan2:DigOut_ON2-SP";
monitor ch2_en_cmd; 

short ch3_en_cmd; 
assign ch3_en_cmd to "{M0}Chan3:DigOut_ON2-SP";
monitor ch3_en_cmd; 

short ch4_en_cmd; 
assign ch4_en_cmd to "{M0}Chan4:DigOut_ON2-SP";
monitor ch4_en_cmd; 

short sum_fault; 
assign sum_fault to "{M0}{M1}:FaultsLat-I"; 
monitor sum_fault; 

short autozero; 
assign autozero to "{M0}{M1}:AutoZero-SP"; 
monitor autozero; 

short zero_dccts; 
assign zero_dccts to "{M0}{M1}:Zero_DCCTs-SP"; 
monitor zero_dccts; 

double dcct1_adc; 
assign dcct1_adc to "{M0}{M1}:DCCT1-I";
monitor dcct1_adc; 

double dcct1_ofst; 
assign dcct1_ofst to "{M0}{M1}:DCCT1-Offset-SP"; 
monitor dcct1_ofst; 

double dcct2_adc; 
assign dcct2_adc to "{M0}{M1}:DCCT2-I";
monitor dcct2_adc; 

double dcct2_ofst; 
assign dcct2_ofst to "{M0}{M1}:DCCT2-Offset-SP"; 
monitor dcct2_ofst; 

short mode; 
assign mode to "{M0}{M1}:DAC_OpMode-SP";
monitor mode;  

double error_adc; 
assign error_adc to "{M0}{M1}:Error-I"; 
monitor error_adc; 

double dac_ofst; 
assign dac_ofst to "{M0}{M1}:DACSetPt-Offset-SP";  
monitor dac_ofst; 

double scale_factor; 
assign scale_factor to "{M0}{M1}:SF:DAC_DCCTs-I";
monitor scale_factor;  

short res; 
assign res to "{M0}Resolution-Mode"; 
monitor res; 

short avg_mode; 
assign avg_mode to "{M0}{M1}:AveMode-SP"; 
monitor avg_mode; 

short atzo_sts; 
assign atzo_sts to "{M0}{M1}:AutoZero-STS"; 
monitor atzo_sts; 

/* stringout to display status or progress. */
string Chan_seq_messages;  
assign Chan_seq_messages to "{M0}{M1}_seq_messages";

string atzo_messages; 
assign atzo_messages to "{M0}{M1}_atzo_messages"; 

string atzo_dbg1_messages; 
assign atzo_dbg1_messages to "{M0}{M1}_atzo_dbg1_messages"; 

string atzo_dbg2_messages; 
assign atzo_dbg2_messages to "{M0}{M1}_atzo_dbg2_messages"; 

string atzo_dbg3_messages; 
assign atzo_dbg3_messages to "{M0}{M1}_atzo_dbg3_messages"; 

int from_faulted_state; 
double error_old; 
double error_new; 
unsigned int up; 
int timeout_count; 
int check_count; 
int up_vote; 
int down_vote; 

    /*******************************/
   /*    Initialization Phase     */
  /*******************************/
ss OFF_ON_FSM {

    state INIT_1 {
    	when(){
    	  flt_mask = 1; 
    	  pvPut(flt_mask); 
    	  DAC = 0; 
    	  pvPut(DAC); 
          ps_on_off_sts = 0;
          pvPut(ps_on_off_sts);
          ch1_Park = 1;
          pvPut(ch1_Park);
          ch2_Park = 1;
          pvPut(ch2_Park);
          ch3_Park = 1;
          pvPut(ch3_Park);
          //ch4_Park = 1;
          //pvPut(ch4_Park);
    	  ch1_on1_cmd = 0; 
	  pvPut(ch1_on1_cmd);  
          ch1_en_cmd = 1; 
          pvPut(ch1_en_cmd);  
          ch2_en_cmd = 1; 
          pvPut(ch2_en_cmd);  
          ch3_en_cmd = 1; 
          pvPut(ch3_en_cmd); 
          ch4_en_cmd = 1; 
          pvPut(ch4_en_cmd); 
    	  printf("Initializing OFF_ON_FSM...\n");
          sprintf(Chan_seq_messages, "WAIT...1");
          pvPut(Chan_seq_messages);
    	} state INIT_2
    }
    state INIT_2 {
    	when(delay(3)) {
          ch1_en_cmd = 1; 
          pvPut(ch1_en_cmd);  
          ch2_en_cmd = 1; 
          pvPut(ch2_en_cmd);  
          ch3_en_cmd = 1; 
          pvPut(ch3_en_cmd); 
          ch4_en_cmd = 1; 
          pvPut(ch4_en_cmd); 
          flt_mask = 0; 
    	  pvPut(flt_mask); 
    	  printf("Initializing OFF_ON_FSM...\n");
          sprintf(Chan_seq_messages, "WAIT...2");
          pvPut(Chan_seq_messages);
    	} state INIT_3
    }
    state INIT_3 {
    	when(delay(2)) {
          flt_mask = 1; 
    	  pvPut(flt_mask); 
    	  printf("Initializing OFF_ON_FSM...\n");
          sprintf(Chan_seq_messages, "WAIT...3");
       	  pvPut(Chan_seq_messages);
    	} state INIT_4
    }
    state INIT_4 {
    	when(delay(2)) {
          flt_clr = 1; 
    	  pvPut(flt_clr); 
    	  printf("Initializing OFF_ON_FSM...\n");
          sprintf(Chan_seq_messages, "Clearing Faults");
       	  pvPut(Chan_seq_messages);
    	} state INIT_5
    }
    state INIT_5 {
    	when(delay(5)) {
          flt_clr = 0; 
    	  pvPut(flt_clr); 
    	  printf("Initializing OFF_ON_FSM...\n");
          //sprintf(Chan_seq_messages, "Clear Done");
       	  pvPut(Chan_seq_messages);
    	} state IDLE
    }
    
    /*******************************/
   /* Sequencer for Bipolar PSC   */
  /*******************************/
    state IDLE {
       when(autozero ==1) {
       		atzo_sts = 1; 
       		pvPut(atzo_sts); 
       		sprintf(atzo_messages, "Zeroing DCCT Offsets");
       	    	pvPut(atzo_messages);
       	    	avg_mode = 1; 
       	    	pvPut(avg_mode); 
       	    	dcct1_ofst = 0;
       	    	pvPut(dcct1_ofst); 
       	    	dcct2_ofst = 0; 
       	    	pvPut(dcct2_ofst);
       	    	dac_ofst = 0; 
       	    	pvPut(dac_ofst);  
       	    	dac_adc_ofst = 0; 
       	    	pvPut(dac_adc_ofst);       	    	
       	    } state READBACK_DCCT1_ADC_OFFSET
        when(ps_on_off == 1) {
		ch1_Park = 1; 
		pvPut(ch1_Park); 
		ch2_Park = 1; 
		pvPut(ch2_Park); 
		ch3_Park = 1; 
		pvPut(ch3_Park); 
		//ch4_Park = 1; 
		//pvPut(ch4_Park); 
		DAC = 0.000; 
		pvPut(DAC); 
		ps_on_off_sts = 0;
            	pvPut(ps_on_off_sts); 
            	sprintf(Chan_seq_messages, "Zeroing DAC");
       	    	pvPut(Chan_seq_messages);
       	    } state SET_DAC_TO_ZERO_ON
       	when(ps_on_off == 0) {
       		sprintf(atzo_messages, "IDLE");
       	    	pvPut(atzo_messages);
       	    	atzo_sts = 0; 
    		ps_on_off_sts = 1;
        	pvPut(ps_on_off_sts);        	    	
       		pvPut(atzo_sts); 
	        sprintf(Chan_seq_messages, "PS OFF");
       	    	pvPut(Chan_seq_messages);
        } state HALT1
    }
   
   /*     
    state CHECK_IF_SYSTEM_WAS_FAULTED {
    	when(from_faulted_state == 0){
    		ps_on_off_sts = 1;
        	pvPut(ps_on_off_sts); 
    	    } state HALT1
    }
    */
    
    //Tight loop was taking up CPU usage.  This delay made a major difference.
    state HALT1 {
    	when(delay(0.2)) {
    	} state IDLE
    }
    	
    state SET_DAC_TO_ZERO_ON {
		when ((DAC_rdbck < 0.1) && (DAC_rdbck > -0.1)) {
	        	sprintf(Chan_seq_messages, "Zeroing DAC");
	        	pvPut(Chan_seq_messages);  
	        	DAC = 0.000; 
            		pvPut(DAC); 						
		} state CLEAR_FAULTS
		
		// Timeout transition: Condition not met within 5.0 seconds 
        	
        	when (delay(60)) {
            		sprintf(Chan_seq_messages, "TIMEOUT!");
            		pvPut(Chan_seq_messages);
        	} state CLEAR_FAULTS
        	
    }    
    
    state CLEAR_FAULTS {
		when (delay(2)) {
			sprintf(Chan_seq_messages, "Clearing Faults");
			pvPut(Chan_seq_messages); 
			flt_clr = 1; 
			pvPut(flt_clr); 
			ch1_en_cmd = 1; 
          		pvPut(ch1_en_cmd);  
          		ch2_en_cmd = 1; 
          		pvPut(ch2_en_cmd);  
          		ch3_en_cmd = 1; 
          		pvPut(ch3_en_cmd); 
          		ch4_en_cmd = 1; 
          		pvPut(ch4_en_cmd); 						
		} state WAIT_TO_CLEAR
	}
	state WAIT_TO_CLEAR {
		when (delay(5)) {
			sprintf(Chan_seq_messages, "Clearing Faults");
			pvPut(Chan_seq_messages); 
			flt_clr = 0; 
			pvPut(flt_clr); 						
		} state POWER_ON
	}	
    	state POWER_ON {
    		when(delay(2)){
    	   		ch1_on1_cmd = 1; 
	   		pvPut(ch1_on1_cmd); 
	   		sprintf(Chan_seq_messages, "Powering ON");
	   		pvPut(Chan_seq_messages); 
    		} state PARK_OFF1
    	}		
	state PARK_OFF1 {
		when (delay(3)) {
			sprintf(Chan_seq_messages, "Park OFF 3,2");
			pvPut(Chan_seq_messages); 
			ch2_Park = 0; 
			pvPut(ch2_Park); 
			ch3_Park = 0; 
			pvPut(ch3_Park); 
		} state SMALL_SETPOINT 
	}
	state SMALL_SETPOINT{
		when (delay(1)) {
			DAC = 0.1; 
			pvPut(DAC); 
		} state PARK_OFF2
	}
	state PARK_OFF2{
		when (delay(2)){
			sprintf(Chan_seq_messages, "Park OFF 1");
			pvPut(Chan_seq_messages);
			ch1_Park = 0; 
			pvPut(ch1_Park); 
		} state DONE
	}
	state RETRY_ON {
		when (ps_on_off==0) {
			ps_on_off_sts = 2; 
			pvPut(ps_on_off_sts); 
			ch1_on1_cmd = 0; 
			pvPut(ch1_on1_cmd); 
			sprintf(Chan_seq_messages, "Faulted..Try Again");
        		pvPut(Chan_seq_messages);
        	    } state RETRY_IDLE
       }
       state RETRY_IDLE {
        	when (ps_on_off==1) {
        		ps_on_off_sts = 2; 
			pvPut(ps_on_off_sts);
			ch1_on1_cmd = 0; 
			pvPut(ch1_on1_cmd); 
        		sprintf(Chan_seq_messages, "Faulted..Try Again");
        		pvPut(Chan_seq_messages);
        	    } state INIT_1 
	}
	state DONE {
		when (delay(1)) {
			sprintf(Chan_seq_messages, " PS Ready!");
			pvPut(Chan_seq_messages); 	
			ps_on_off_sts = 1;	
			pvPut(ps_on_off_sts); 				
		} state READY
	}
	state READY {
		when (ps_on_off==1) {
			sprintf(Chan_seq_messages, "Zeroing DAC");
        	   	pvPut(Chan_seq_messages);
        	   	DAC =0.00; 
        	   	pvPut(DAC); 
        	   	ps_on_off_sts = 0;
        	   	pvPut(ps_on_off_sts); 
		} state SET_DAC_TO_ZERO_OFF

		when(ps_on_off==0) {
        	   	ps_on_off_sts = 1;
        	   	pvPut(ps_on_off_sts); 
			sprintf(Chan_seq_messages, " PS Ready!");
        	   	pvPut(Chan_seq_messages);
		} state CHECK_FAULT
	}
	state CHECK_FAULT {
		when(sum_fault == 0){
		} state HALT2
		when(sum_fault > 0) {
			ps_on_off_sts = 2; 
			pvPut(ps_on_off_sts); 
			sprintf(Chan_seq_messages, "Faulted..Try Again"); 
		} state RETRY_ON
	}
    	//Tight loop was taking up CPU usage.  This delay made a major difference.
    	state HALT2 {
    		when(delay(0.2)) {
    		} state READY
    	} 
	state SET_DAC_TO_ZERO_OFF {
		when ((DAC_rdbck < 0.05) && (DAC_rdbck > -0.05)) {
			sprintf(Chan_seq_messages, "Turning OFF");
			pvPut(Chan_seq_messages);  						
		} state POWER_OFF1
	}
	state POWER_OFF1 {
		when (delay(2)) {
			sprintf(Chan_seq_messages, "Park 1");
			pvPut(Chan_seq_messages); 	
			ch1_Park = 1; 
			pvPut(ch1_Park); 					
		} state POWER_OFF2
	}
	state POWER_OFF2 {
		when (delay(2)) {
			sprintf(Chan_seq_messages, "Park 2,3");
			pvPut(Chan_seq_messages); 
			ch2_Park = 1; 
			pvPut(ch2_Park); 
			ch3_Park = 1; 
			pvPut(ch3_Park); 
		} state POWER_OFF3
	}
	state POWER_OFF3 {
		when (delay(1)) {
			sprintf(Chan_seq_messages, "Power OFF");
			pvPut(Chan_seq_messages); 
			ch1_on1_cmd = 0; 
			pvPut(ch1_on1_cmd); 
		} state COMPLETE
	}
	state COMPLETE {
		when (delay(1)) {
			sprintf(Chan_seq_messages, "Power OFF");
			pvPut(Chan_seq_messages); 
			ps_on_off_sts = 1;
			pvPut(ps_on_off_sts); 				
		} state IDLE
	}

    /*******************************/
   /* Auto-Zero Procedure*/
  /*******************************/
	state READBACK_DCCT1_ADC_OFFSET{
		when(delay(4)) {
			pvGet(dcct1_adc);
			dcct1_ofst = -1*dcct1_adc; 
        	   	pvPut(dcct1_ofst);
            		sprintf(atzo_messages, "%f Offset",dcct1_adc);
       	    		pvPut(atzo_messages);
		} state WAIT1
	}
	state WAIT1{
		when(delay(4)) {
		} state CHECK_DCCT1
	}
	state CHECK_DCCT1 {
		when(dcct1_adc < fabs(0.001)){
		       sprintf(atzo_messages, "DCCT1 GOOD");
       	    	       pvPut(atzo_messages);
		} state READBACK_DCCT2_ADC_OFFSET
		when(dcct1_adc > fabs(0.001)){
		       sprintf(atzo_messages, "DCCT1 RETRY");
       	    	       pvPut(atzo_messages);
		} state READBACK_DCCT1_ADC_OFFSET
	}
	state READBACK_DCCT2_ADC_OFFSET{
		when() {
			pvGet(dcct2_adc);
			dcct2_ofst = -1*dcct2_adc; 
        	   	pvPut(dcct2_ofst);
            		sprintf(atzo_messages, "%f Offset",dcct2_adc);
       	    		pvPut(atzo_messages);
		} state WAIT2
	}
	state WAIT2{
		when(delay(3)) {
		} state CHECK_DCCT2
	}
	state CHECK_DCCT2 {
		when(dcct2_adc < fabs(0.001)){
		       sprintf(atzo_messages, "DCCT2 GOOD");
       	    	       pvPut(atzo_messages);
		} state JUMP_MODE
		when(dcct2_adc > fabs(0.001)){
		       sprintf(atzo_messages, "DCCT2 RETRY");
       	    	       pvPut(atzo_messages);
		} state READBACK_DCCT2_ADC_OFFSET
	}
	state JUMP_MODE {
		when() {
		   mode = 3; 
		   pvPut(mode);
		   avg_mode = 2; 
       	           pvPut(avg_mode);  
		   sprintf(atzo_messages, "DAC ADJUSTMENT");
       	    	   pvPut(atzo_messages);	   
		} state WAIT3
	}
	state WAIT3{
		//when(delay(3)){ 
		when() {
		   timeout_count = 0; 
		   pvGet(error_adc);
		   error_old = fabs(error_adc); 
		} state INCREMENT_UP
	}
	state INCREMENT_UP {
		when(fabs(error_adc) < 0.015){
			pvPut(dac_ofst); 
			mode = 0; 
		   	pvPut(mode);
       	    	   	atzo_sts = 0; 
       			pvPut(atzo_sts); 
			sprintf(atzo_messages, "COMPLETE");
       	    	   	pvPut(atzo_messages);	
			} state READBACK_DAC_ADC_OFFSET
		when(fabs(error_adc) > 0.01) {
			up = 1; 
       	    	   	if(res == 0){
       	    	   		dac_ofst = dac_ofst + (RES_M*scale_factor); 
       	    	   	}else{

       	    	   		dac_ofst = dac_ofst + (RES_H*scale_factor); 
			}
			timeout_count = timeout_count +1; 
			pvPut(dac_ofst); 
			sprintf(atzo_messages, "GOING UP");
       	    	   	pvPut(atzo_messages);
			} state WAIT4
		} 
	state INCREMENT_DOWN {
		when(fabs(error_adc) < 0.015){
			pvPut(dac_ofst); 
			mode = 0; 
		   	pvPut(mode);
			timeout_count = 0; 
			mode = 0; 
			atzo_sts = 0; 
			pvPut(atzo_sts); 
			pvPut(mode); 
			sprintf(atzo_messages, "COMPLETE");
       	    	   	pvPut(atzo_messages);	
		} state READBACK_DAC_ADC_OFFSET
		when(fabs(error_adc) > 0.01) {
			timeout_count = timeout_count +1; 
       	    	   	if(res == 0){
       	    	   		dac_ofst = dac_ofst - (RES_M*scale_factor); 
       	    	   	}else{
       	    	   		dac_ofst = dac_ofst - (RES_H*scale_factor) ; 

			}
			pvPut(dac_ofst); 
			sprintf(atzo_messages, "GOING DOWN");
       	    	   	pvPut(atzo_messages);	
			} state WAIT4
		} 		
	state WAIT4 {
		when(delay(1)) {
			pvGet(error_adc); 
			error_new = fabs(error_adc); 	
			sprintf(atzo_messages, "WAIT.. ");
       	    	   	pvPut(atzo_messages);	
		} state WAIT5
	}
	state WAIT5 {
		when(delay(2)) {
			sprintf(atzo_messages, "WAIT....");
       	    	   	pvPut(atzo_messages);	
		} state VOTE_CHECK
	}
	state VOTE_CHECK {
		when(check_count == 3) {
		} state WAIT8
		when(check_count < 3) {
		   if(error_new < error_old) {
		   	down_vote = down_vote +1; 
		   }else{
		   	up_vote = up_vote +1; 
		   }		
		   check_count = check_count +1; 
		   sprintf(atzo_messages, "WAIT....");
       	    	   pvPut(atzo_messages);
		   sprintf(atzo_dbg1_messages, "OLD = %f",error_old);
       	    	   pvPut(atzo_dbg1_messages);     
		   sprintf(atzo_dbg2_messages, "NEW = %f",error_new);
       	    	   pvPut(atzo_dbg2_messages);      
		   sprintf(atzo_dbg3_messages, "up=%d down=%d",up_vote,down_vote);
       	    	   pvPut(atzo_dbg3_messages);    	    	   
		} state RECHECK_ERROR_ADC
	}
	state RECHECK_ERROR_ADC {
		//when(delay(1)) {
		when() {
		    pvGet(error_adc); 
		    error_new = fabs(error_adc); 
		} state VOTE_CHECK	
	} 
	state WAIT8 {
		when(delay(1)) {
		//when() {
		error_old = error_new; 
		} state CHECK_NEW_ERROR
	}
	state CHECK_NEW_ERROR {
		when(timeout_count > 50) {
			pvPut(dac_ofst); 
			timeout_count = 0; 
			atzo_sts = 0; 
			mode = 0; 
		   	pvPut(mode);
			pvPut(atzo_sts); 
			sprintf(atzo_messages, "NON-CONVERGENT!");
       	    	   	pvPut(atzo_messages);
		} state READBACK_DAC_ADC_OFFSET
		when(up_vote > down_vote) {
       	    	   	check_count =0; 
       	    	   	up_vote = 0; 
       	    	   	down_vote = 0; 
			if(up ==1){
				up =0; 
			}else{
			     up =1; 
			}; 
			error_old = error_new; 		
		} state WAIT7
		when(down_vote > up_vote) {
			check_count = 0; 
			up_vote = 0; 
			down_vote = 0; 
			up = up; 
			error_old = error_new;
		} state WAIT7
	}
	state WAIT7 {
		//when(delay(1)){
		when() {
		error_new = fabs(pvGet(error_adc));
		} state UP_DOWN
	}
	state UP_DOWN {
		when(up >0) {
			sprintf(atzo_messages, "ZERO CHECK");
       	    	   	pvPut(atzo_messages);
		} state INCREMENT_UP
		when(up ==0) {
			sprintf(atzo_messages, "ZERO CHECK");
       	    	   	pvPut(atzo_messages);
		} state INCREMENT_DOWN
	}
	state READBACK_DAC_ADC_OFFSET {
		when(delay(1)){
		pvGet(DAC_rdbck); 
		dac_adc_ofst = DAC_rdbck; 
		pvPut(dac_adc_ofst); 
       	    	avg_mode = 1; 
       	    	pvPut(avg_mode); 
		} state IDLE
	}
}
	
    /*******************************/
   /* Sequencer for Unipolar PSC  */
  /*******************************/
/*
    state UNIPOLAR_IDLE {
        when(delay(1.0)) {
            printf("Set %s to 1\n", pvName(Park));
            sprintf(Chan_seq_messages, "IDLE 2CH");
       	    pvPut(Chan_seq_messages);
        } state UNIPOLAR_IDLE
    }
*/


