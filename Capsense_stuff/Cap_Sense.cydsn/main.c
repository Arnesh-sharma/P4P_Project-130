/* ========================================
 *
 * Copyright YOUR COMPANY, THE YEAR
 * All Rights Reserved
 * UNPUBLISHED, LICENSED SOFTWARE.
 *
 * CONFIDENTIAL AND PROPRIETARY INFORMATION
 * WHICH IS THE PROPERTY OF your company.
 *
 * ========================================
*/
#include "project.h"


int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */
    CapSense_1_Start(); 
    
    CapSense_1_InitializeAllBaselines(); 
    


    /* Place your initialization/startup code here (e.g. MyInst_Start()) */

    for(;;)
    {
        /* Place your application code here. */
        
        //Update baselines 
        CapSense_1_UpdateEnabledBaselines(); 
        
        //scan the sensors 
        CapSense_1_ScanEnabledWidgets(); 
        
        while(CapSense_1_IsBusy() != 0){
            //loop until readings are donezo
        }
        
      
    }
}


void CapSense_diplay(void){
    
    if(CapSense_1_CheckIsWidgetActive(CapSense_1_SENSOR_BUTTON0__BTN)){
        LED_Write(1); 
    }else{
        LED_Write(0); 
    }
}



/* [] END OF FILE */
