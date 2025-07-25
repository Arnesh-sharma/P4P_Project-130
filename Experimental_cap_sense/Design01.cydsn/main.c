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

    /* Place your initialization/startup code here (e.g. MyInst_Start()) */

    PGA_Inv_1_Start();
    Comp_1_Start();
    VDAC8_1_Start();
    VDAC8_1_SetValue(127);
    
   
    IDAC8_1_SetValue(80);
    IDAC8_1_SetValue(160);
    IDAC8_1_Start();
    IDAC8_2_Start();
    
    
    for(;;)
    {
        /* Place your application code here. */
    }
}

/* [] END OF FILE */
