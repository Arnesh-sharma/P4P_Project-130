/*******************************************************************************
* File Name: pw.h  
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

#if !defined(CY_PINS_pw_H) /* Pins pw_H */
#define CY_PINS_pw_H

#include "cytypes.h"
#include "cyfitter.h"
#include "cypins.h"
#include "pw_aliases.h"

/* APIs are not generated for P15[7:6] */
#if !(CY_PSOC5A &&\
	 pw__PORT == 15 && ((pw__MASK & 0xC0) != 0))


/***************************************
*        Function Prototypes             
***************************************/    

/**
* \addtogroup group_general
* @{
*/
void    pw_Write(uint8 value);
void    pw_SetDriveMode(uint8 mode);
uint8   pw_ReadDataReg(void);
uint8   pw_Read(void);
void    pw_SetInterruptMode(uint16 position, uint16 mode);
uint8   pw_ClearInterrupt(void);
/** @} general */

/***************************************
*           API Constants        
***************************************/
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup driveMode Drive mode constants
     * \brief Constants to be passed as "mode" parameter in the pw_SetDriveMode() function.
     *  @{
     */
        #define pw_DM_ALG_HIZ         PIN_DM_ALG_HIZ
        #define pw_DM_DIG_HIZ         PIN_DM_DIG_HIZ
        #define pw_DM_RES_UP          PIN_DM_RES_UP
        #define pw_DM_RES_DWN         PIN_DM_RES_DWN
        #define pw_DM_OD_LO           PIN_DM_OD_LO
        #define pw_DM_OD_HI           PIN_DM_OD_HI
        #define pw_DM_STRONG          PIN_DM_STRONG
        #define pw_DM_RES_UPDWN       PIN_DM_RES_UPDWN
    /** @} driveMode */
/** @} group_constants */
    
/* Digital Port Constants */
#define pw_MASK               pw__MASK
#define pw_SHIFT              pw__SHIFT
#define pw_WIDTH              1u

/* Interrupt constants */
#if defined(pw__INTSTAT)
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup intrMode Interrupt constants
     * \brief Constants to be passed as "mode" parameter in pw_SetInterruptMode() function.
     *  @{
     */
        #define pw_INTR_NONE      (uint16)(0x0000u)
        #define pw_INTR_RISING    (uint16)(0x0001u)
        #define pw_INTR_FALLING   (uint16)(0x0002u)
        #define pw_INTR_BOTH      (uint16)(0x0003u) 
    /** @} intrMode */
/** @} group_constants */

    #define pw_INTR_MASK      (0x01u) 
#endif /* (pw__INTSTAT) */


/***************************************
*             Registers        
***************************************/

/* Main Port Registers */
/* Pin State */
#define pw_PS                     (* (reg8 *) pw__PS)
/* Data Register */
#define pw_DR                     (* (reg8 *) pw__DR)
/* Port Number */
#define pw_PRT_NUM                (* (reg8 *) pw__PRT) 
/* Connect to Analog Globals */                                                  
#define pw_AG                     (* (reg8 *) pw__AG)                       
/* Analog MUX bux enable */
#define pw_AMUX                   (* (reg8 *) pw__AMUX) 
/* Bidirectional Enable */                                                        
#define pw_BIE                    (* (reg8 *) pw__BIE)
/* Bit-mask for Aliased Register Access */
#define pw_BIT_MASK               (* (reg8 *) pw__BIT_MASK)
/* Bypass Enable */
#define pw_BYP                    (* (reg8 *) pw__BYP)
/* Port wide control signals */                                                   
#define pw_CTL                    (* (reg8 *) pw__CTL)
/* Drive Modes */
#define pw_DM0                    (* (reg8 *) pw__DM0) 
#define pw_DM1                    (* (reg8 *) pw__DM1)
#define pw_DM2                    (* (reg8 *) pw__DM2) 
/* Input Buffer Disable Override */
#define pw_INP_DIS                (* (reg8 *) pw__INP_DIS)
/* LCD Common or Segment Drive */
#define pw_LCD_COM_SEG            (* (reg8 *) pw__LCD_COM_SEG)
/* Enable Segment LCD */
#define pw_LCD_EN                 (* (reg8 *) pw__LCD_EN)
/* Slew Rate Control */
#define pw_SLW                    (* (reg8 *) pw__SLW)

/* DSI Port Registers */
/* Global DSI Select Register */
#define pw_PRTDSI__CAPS_SEL       (* (reg8 *) pw__PRTDSI__CAPS_SEL) 
/* Double Sync Enable */
#define pw_PRTDSI__DBL_SYNC_IN    (* (reg8 *) pw__PRTDSI__DBL_SYNC_IN) 
/* Output Enable Select Drive Strength */
#define pw_PRTDSI__OE_SEL0        (* (reg8 *) pw__PRTDSI__OE_SEL0) 
#define pw_PRTDSI__OE_SEL1        (* (reg8 *) pw__PRTDSI__OE_SEL1) 
/* Port Pin Output Select Registers */
#define pw_PRTDSI__OUT_SEL0       (* (reg8 *) pw__PRTDSI__OUT_SEL0) 
#define pw_PRTDSI__OUT_SEL1       (* (reg8 *) pw__PRTDSI__OUT_SEL1) 
/* Sync Output Enable Registers */
#define pw_PRTDSI__SYNC_OUT       (* (reg8 *) pw__PRTDSI__SYNC_OUT) 

/* SIO registers */
#if defined(pw__SIO_CFG)
    #define pw_SIO_HYST_EN        (* (reg8 *) pw__SIO_HYST_EN)
    #define pw_SIO_REG_HIFREQ     (* (reg8 *) pw__SIO_REG_HIFREQ)
    #define pw_SIO_CFG            (* (reg8 *) pw__SIO_CFG)
    #define pw_SIO_DIFF           (* (reg8 *) pw__SIO_DIFF)
#endif /* (pw__SIO_CFG) */

/* Interrupt Registers */
#if defined(pw__INTSTAT)
    #define pw_INTSTAT            (* (reg8 *) pw__INTSTAT)
    #define pw_SNAP               (* (reg8 *) pw__SNAP)
    
	#define pw_0_INTTYPE_REG 		(* (reg8 *) pw__0__INTTYPE)
#endif /* (pw__INTSTAT) */

#endif /* CY_PSOC5A... */

#endif /*  CY_PINS_pw_H */


/* [] END OF FILE */
