/**************************************************************************/
/*                                                                        */
/*       Copyright (c) Microsoft Corporation. All rights reserved.        */
/*                                                                        */
/*       This software is licensed under the Microsoft Software License   */
/*       Terms for Microsoft Azure RTOS. Full text of the license can be  */
/*       found in the LICENSE file at https://aka.ms/AzureRTOS_EULA       */
/*       and in the root directory of this software.                      */
/*                                                                        */
/**************************************************************************/


/**************************************************************************/
/**************************************************************************/
/**                                                                       */
/** ThreadX Component                                                     */
/**                                                                       */
/**   Thread                                                              */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/


#define UserLocal       $4,2
#define C0_Status       $12

    .text
    .set        noreorder
/**************************************************************************/
/*                                                                        */
/*  FUNCTION                                               RELEASE        */
/*                                                                        */
/*    _tx_thread_smp_current_thread_get             MIPS32_interAptiv/GNU */
/*                                                           6.x          */
/*  AUTHOR                                                                */
/*                                                                        */
/*    Scott Larson, Microsoft Corporation                                 */
/*                                                                        */
/*  DESCRIPTION                                                           */
/*                                                                        */
/*    This function is gets the current thread of the calling core.       */
/*                                                                        */
/*  INPUT                                                                 */
/*                                                                        */
/*    None                                                                */
/*                                                                        */
/*  OUTPUT                                                                */
/*                                                                        */
/*    None                                                                */
/*                                                                        */
/*  CALLS                                                                 */
/*                                                                        */
/*    None                                                                */
/*                                                                        */
/*  CALLED BY                                                             */
/*                                                                        */
/*    ThreadX Components                                                  */
/*                                                                        */
/*  RELEASE HISTORY                                                       */
/*                                                                        */
/*    DATE              NAME                      DESCRIPTION             */
/*                                                                        */
/*  xx-xx-xxxx      Scott Larson            Initial Version 6.x           */
/*                                                                        */
/**************************************************************************/
    .globl  _tx_thread_smp_current_thread_get
_tx_thread_smp_current_thread_get:
    di      $10                                 # Disable interrupts
    ehb                                         #
    mfc0    $25, UserLocal                      # Pickup VPE ID
    la      $12, _tx_thread_current_ptr         # Pickup the current thread pointer
    sll     $25, $25, 2                         # Build index based on VPE number
    addu    $12, $12, $25                       # Build address of current thread pointer for this VPE
    lw      $2, ($12)                           # Pickup current thread pointer
    mtc0    $10, C0_Status                      # Restore interrupt posture
    jr.hb   $31                                 # Return to caller
    nop                                         # Delay slot
