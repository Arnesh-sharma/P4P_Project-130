/*******************************************************************************
* File Name: vcs.h  
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

#if !defined(CY_PINS_vcs_H) /* Pins vcs_H */
#define CY_PINS_vcs_H

#include "cytypes.h"
#include "cyfitter.h"
#include "cypins.h"
#include "vcs_aliases.h"

/* APIs are not generated for P15[7:6] */
#if !(CY_PSOC5A &&\
	 vcs__PORT == 15 && ((vcs__MASK & 0xC0) != 0))


/***************************************
*        Function Prototypes             
***************************************/    

/**
* \addtogroup group_general
* @{
*/
void    vcs_Write(uint8 value);
void    vcs_SetDriveMode(uint8 mode);
uint8   vcs_ReadDataReg(void);
uint8   vcs_Read(void);
void    vcs_SetInterruptMode(uint16 position, uint16 mode);
uint8   vcs_ClearInterrupt(void);
/** @} general */

/***************************************
*           API Constants        
***************************************/
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup driveMode Drive mode constants
     * \brief Constants to be passed as "mode" parameter in the vcs_SetDriveMode() function.
     *  @{
     */
        #define vcs_DM_ALG_HIZ         PIN_DM_ALG_HIZ
        #define vcs_DM_DIG_HIZ         PIN_DM_DIG_HIZ
        #define vcs_DM_RES_UP          PIN_DM_RES_UP
        #define vcs_DM_RES_DWN         PIN_DM_RES_DWN
        #define vcs_DM_OD_LO           PIN_DM_OD_LO
        #define vcs_DM_OD_HI           PIN_DM_OD_HI
        #define vcs_DM_STRONG          PIN_DM_STRONG
        #define vcs_DM_RES_UPDWN       PIN_DM_RES_UPDWN
    /** @} driveMode */
/** @} group_constants */
    
/* Digital Port Constants */
#define vcs_MASK               vcs__MASK
#define vcs_SHIFT              vcs__SHIFT
#define vcs_WIDTH              1u

/* Interrupt constants */
#if defined(vcs__INTSTAT)
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup intrMode Interrupt constants
     * \brief Constants to be passed as "mode" parameter in vcs_SetInterruptMode() function.
     *  @{
     */
        #define vcs_INTR_NONE      (uint16)(0x0000u)
        #define vcs_INTR_RISING    (uint16)(0x0001u)
        #define vcs_INTR_FALLING   (uint16)(0x0002u)
        #define vcs_INTR_BOTH      (uint16)(0x0003u) 
    /** @} intrMode */
/** @} group_constants */

    #define vcs_INTR_MASK      (0x01u) 
#endif /* (vcs__INTSTAT) */


/***************************************
*             Registers        
***************************************/

/* Main Port Registers */
/* Pin State */
#define vcs_PS                     (* (reg8 *) vcs__PS)
/* Data Register */
#define vcs_DR                     (* (reg8 *) vcs__DR)
/* Port Number */
#define vcs_PRT_NUM                (* (reg8 *) vcs__PRT) 
/* Connect to Analog Globals */                                                  
#define vcs_AG                     (* (reg8 *) vcs__AG)                       
/* Analog MUX bux enable */
#define vcs_AMUX                   (* (reg8 *) vcs__AMUX) 
/* Bidirectional Enable */                                                        
#define vcs_BIE                    (* (reg8 *) vcs__BIE)
/* Bit-mask for Aliased Register Access */
#define vcs_BIT_MASK               (* (reg8 *) vcs__BIT_MASK)
/* Bypass Enable */
#define vcs_BYP                    (* (reg8 *) vcs__BYP)
/* Port wide control signals */                                                   
#define vcs_CTL                    (* (reg8 *) vcs__CTL)
/* Drive Modes */
#define vcs_DM0                    (* (reg8 *) vcs__DM0) 
#define vcs_DM1                    (* (reg8 *) vcs__DM1)
#define vcs_DM2                    (* (reg8 *) vcs__DM2) 
/* Input Buffer Disable Override */
#define vcs_INP_DIS                (* (reg8 *) vcs__INP_DIS)
/* LCD Common or Segment Drive */
#define vcs_LCD_COM_SEG            (* (reg8 *) vcs__LCD_COM_SEG)
/* Enable Segment LCD */
#define vcs_LCD_EN                 (* (reg8 *) vcs__LCD_EN)
/* Slew Rate Control */
#define vcs_SLW                    (* (reg8 *) vcs__SLW)

/* DSI Port Registers */
/* Global DSI Select Register */
#define vcs_PRTDSI__CAPS_SEL       (* (reg8 *) vcs__PRTDSI__CAPS_SEL) 
/* Double Sync Enable */
#define vcs_PRTDSI__DBL_SYNC_IN    (* (reg8 *) vcs__PRTDSI__DBL_SYNC_IN) 
/* Output Enable Select Drive Strength */
#define vcs_PRTDSI__OE_SEL0        (* (reg8 *) vcs__PRTDSI__OE_SEL0) 
#define vcs_PRTDSI__OE_SEL1        (* (reg8 *) vcs__PRTDSI__OE_SEL1) 
/* Port Pin Output Select Registers */
#define vcs_PRTDSI__OUT_SEL0       (* (reg8 *) vcs__PRTDSI__OUT_SEL0) 
#define vcs_PRTDSI__OUT_SEL1       (* (reg8 *) vcs__PRTDSI__OUT_SEL1) 
/* Sync Output Enable Registers */
#define vcs_PRTDSI__SYNC_OUT       (* (reg8 *) vcs__PRTDSI__SYNC_OUT) 

/* SIO registers */
#if defined(vcs__SIO_CFG)
    #define vcs_SIO_HYST_EN        (* (reg8 *) vcs__SIO_HYST_EN)
    #define vcs_SIO_REG_HIFREQ     (* (reg8 *) vcs__SIO_REG_HIFREQ)
    #define vcs_SIO_CFG            (* (reg8 *) vcs__SIO_CFG)
    #define vcs_SIO_DIFF           (* (reg8 *) vcs__SIO_DIFF)
#endif /* (vcs__SIO_CFG) */

/* Interrupt Registers */
#if defined(vcs__INTSTAT)
    #define vcs_INTSTAT            (* (reg8 *) vcs__INTSTAT)
    #define vcs_SNAP               (* (reg8 *) vcs__SNAP)
    
	#define vcs_0_INTTYPE_REG 		(* (reg8 *) vcs__0__INTTYPE)
#endif /* (vcs__INTSTAT) */

#endif /* CY_PSOC5A... */

#endif /*  CY_PINS_vcs_H */


/* [] END OF FILE */
