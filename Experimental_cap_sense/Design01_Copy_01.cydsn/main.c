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
  
    VDAC8_1_Start();
    VDAC8_1_SetValue(83);
    
   
    IDAC8_1_SetValue(8);
    IDAC8_1_SetValue(16);
    IDAC8_1_Start();
    IDAC8_2_Start();
    
    
    for(;;)
    {
        /* Place your application code here. */
    }
}

/* [] END OF FILE */
