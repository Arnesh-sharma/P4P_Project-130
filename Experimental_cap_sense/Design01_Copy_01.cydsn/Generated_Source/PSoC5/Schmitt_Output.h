/*******************************************************************************
* File Name: Schmitt_Output.h  
* Version 2.20
*
* Description:
*  This file contains Pin function prototypes and register defines
*
* Note:
*
********************************************************************************
* Copyright 2008-2015, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
*******************************************************************************/

#if !defined(CY_PINS_Schmitt_Output_H) /* Pins Schmitt_Output_H */
#define CY_PINS_Schmitt_Output_H

#include "cytypes.h"
#include "cyfitter.h"
#include "cypins.h"
#include "Schmitt_Output_aliases.h"

/* APIs are not generated for P15[7:6] */
#if !(CY_PSOC5A &&\
	 Schmitt_Output__PORT == 15 && ((Schmitt_Output__MASK & 0xC0) != 0))


/***************************************
*        Function Prototypes             
***************************************/    

/**
* \addtogroup group_general
* @{
*/
void    Schmitt_Output_Write(uint8 value);
void    Schmitt_Output_SetDriveMode(uint8 mode);
uint8   Schmitt_Output_ReadDataReg(void);
uint8   Schmitt_Output_Read(void);
void    Schmitt_Output_SetInterruptMode(uint16 position, uint16 mode);
uint8   Schmitt_Output_ClearInterrupt(void);
/** @} general */

/***************************************
*           API Constants        
***************************************/
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup driveMode Drive mode constants
     * \brief Constants to be passed as "mode" parameter in the Schmitt_Output_SetDriveMode() function.
     *  @{
     */
        #define Schmitt_Output_DM_ALG_HIZ         PIN_DM_ALG_HIZ
        #define Schmitt_Output_DM_DIG_HIZ         PIN_DM_DIG_HIZ
        #define Schmitt_Output_DM_RES_UP          PIN_DM_RES_UP
        #define Schmitt_Output_DM_RES_DWN         PIN_DM_RES_DWN
        #define Schmitt_Output_DM_OD_LO           PIN_DM_OD_LO
        #define Schmitt_Output_DM_OD_HI           PIN_DM_OD_HI
        #define Schmitt_Output_DM_STRONG          PIN_DM_STRONG
        #define Schmitt_Output_DM_RES_UPDWN       PIN_DM_RES_UPDWN
    /** @} driveMode */
/** @} group_constants */
    
/* Digital Port Constants */
#define Schmitt_Output_MASK               Schmitt_Output__MASK
#define Schmitt_Output_SHIFT              Schmitt_Output__SHIFT
#define Schmitt_Output_WIDTH              1u

/* Interrupt constants */
#if defined(Schmitt_Output__INTSTAT)
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup intrMode Interrupt constants
     * \brief Constants to be passed as "mode" parameter in Schmitt_Output_SetInterruptMode() function.
     *  @{
     */
        #define Schmitt_Output_INTR_NONE      (uint16)(0x0000u)
        #define Schmitt_Output_INTR_RISING    (uint16)(0x0001u)
        #define Schmitt_Output_INTR_FALLING   (uint16)(0x0002u)
        #define Schmitt_Output_INTR_BOTH      (uint16)(0x0003u) 
    /** @} intrMode */
/** @} group_constants */

    #define Schmitt_Output_INTR_MASK      (0x01u) 
#endif /* (Schmitt_Output__INTSTAT) */


/***************************************
*             Registers        
***************************************/

/* Main Port Registers */
/* Pin State */
#define Schmitt_Output_PS                     (* (reg8 *) Schmitt_Output__PS)
/* Data Register */
#define Schmitt_Output_DR                     (* (reg8 *) Schmitt_Output__DR)
/* Port Number */
#define Schmitt_Output_PRT_NUM                (* (reg8 *) Schmitt_Output__PRT) 
/* Connect to Analog Globals */                                                  
#define Schmitt_Output_AG                     (* (reg8 *) Schmitt_Output__AG)                       
/* Analog MUX bux enable */
#define Schmitt_Output_AMUX                   (* (reg8 *) Schmitt_Output__AMUX) 
/* Bidirectional Enable */                                                        
#define Schmitt_Output_BIE                    (* (reg8 *) Schmitt_Output__BIE)
/* Bit-mask for Aliased Register Access */
#define Schmitt_Output_BIT_MASK               (* (reg8 *) Schmitt_Output__BIT_MASK)
/* Bypass Enable */
#define Schmitt_Output_BYP                    (* (reg8 *) Schmitt_Output__BYP)
/* Port wide control signals */                                                   
#define Schmitt_Output_CTL                    (* (reg8 *) Schmitt_Output__CTL)
/* Drive Modes */
#define Schmitt_Output_DM0                    (* (reg8 *) Schmitt_Output__DM0) 
#define Schmitt_Output_DM1                    (* (reg8 *) Schmitt_Output__DM1)
#define Schmitt_Output_DM2                    (* (reg8 *) Schmitt_Output__DM2) 
/* Input Buffer Disable Override */
#define Schmitt_Output_INP_DIS                (* (reg8 *) Schmitt_Output__INP_DIS)
/* LCD Common or Segment Drive */
#define Schmitt_Output_LCD_COM_SEG            (* (reg8 *) Schmitt_Output__LCD_COM_SEG)
/* Enable Segment LCD */
#define Schmitt_Output_LCD_EN                 (* (reg8 *) Schmitt_Output__LCD_EN)
/* Slew Rate Control */
#define Schmitt_Output_SLW                    (* (reg8 *) Schmitt_Output__SLW)

/* DSI Port Registers */
/* Global DSI Select Register */
#define Schmitt_Output_PRTDSI__CAPS_SEL       (* (reg8 *) Schmitt_Output__PRTDSI__CAPS_SEL) 
/* Double Sync Enable */
#define Schmitt_Output_PRTDSI__DBL_SYNC_IN    (* (reg8 *) Schmitt_Output__PRTDSI__DBL_SYNC_IN) 
/* Output Enable Select Drive Strength */
#define Schmitt_Output_PRTDSI__OE_SEL0        (* (reg8 *) Schmitt_Output__PRTDSI__OE_SEL0) 
#define Schmitt_Output_PRTDSI__OE_SEL1        (* (reg8 *) Schmitt_Output__PRTDSI__OE_SEL1) 
/* Port Pin Output Select Registers */
#define Schmitt_Output_PRTDSI__OUT_SEL0       (* (reg8 *) Schmitt_Output__PRTDSI__OUT_SEL0) 
#define Schmitt_Output_PRTDSI__OUT_SEL1       (* (reg8 *) Schmitt_Output__PRTDSI__OUT_SEL1) 
/* Sync Output Enable Registers */
#define Schmitt_Output_PRTDSI__SYNC_OUT       (* (reg8 *) Schmitt_Output__PRTDSI__SYNC_OUT) 

/* SIO registers */
#if defined(Schmitt_Output__SIO_CFG)
    #define Schmitt_Output_SIO_HYST_EN        (* (reg8 *) Schmitt_Output__SIO_HYST_EN)
    #define Schmitt_Output_SIO_REG_HIFREQ     (* (reg8 *) Schmitt_Output__SIO_REG_HIFREQ)
    #define Schmitt_Output_SIO_CFG            (* (reg8 *) Schmitt_Output__SIO_CFG)
    #define Schmitt_Output_SIO_DIFF           (* (reg8 *) Schmitt_Output__SIO_DIFF)
#endif /* (Schmitt_Output__SIO_CFG) */

/* Interrupt Registers */
#if defined(Schmitt_Output__INTSTAT)
    #define Schmitt_Output_INTSTAT            (* (reg8 *) Schmitt_Output__INTSTAT)
    #define Schmitt_Output_SNAP               (* (reg8 *) Schmitt_Output__SNAP)
    
	#define Schmitt_Output_0_INTTYPE_REG 		(* (reg8 *) Schmitt_Output__0__INTTYPE)
#endif /* (Schmitt_Output__INTSTAT) */

#endif /* CY_PSOC5A... */

#endif /*  CY_PINS_Schmitt_Output_H */


/* [] END OF FILE */
