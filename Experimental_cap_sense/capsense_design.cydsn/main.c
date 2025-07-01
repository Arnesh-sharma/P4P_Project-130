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

//CY_ISR(Schmitt_Output_Handler) {
    // Toggle LED
//    LED_Write(~LED_Read());
//    Schmitt_Output_ClearInterrupt();
//}

int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */

    /* Place your initialization/startup code here (e.g. MyInst_Start()) */
    //isr_schmitt_StartEx(Schmitt_Output_Handler);
    VDAC8_1_Start();
    //VDAC8_1_SetValue(127);
    
   
    //IDAC8_1_SetValue(80);
    //IDAC8_1_SetValue(78);
    IDAC8_1_Start();
    IDAC8_2_Start();
    
    //Opamp_1_Start();
    Opamp_2_Start();
    
    for(;;)
    {
        /* Place your application code here. */
        //LED_Write(1);
    }
}

/* [] END OF FILE */
