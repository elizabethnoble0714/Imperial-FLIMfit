//=========================================================================
//
// Copyright (C) 2013 Imperial College London.
// All rights reserved.
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along
// with this program; if not, write to the Free Software Foundation, Inc.,
// 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
//
// This software tool was developed with support from the UK 
// Engineering and Physical Sciences Council 
// through  a studentship from the Institute of Chemical Biology 
// and The Wellcome Trust through a grant entitled 
// "The Open Microscopy Environment: Image Informatics for Biological Sciences" (Ref: 095931).
//
// Author : Sean Warren
//
//=========================================================================

#ifndef _FLIMGLOBALFIT_
#define _FLIMGLOBALFIT_

#define _CRTDBG_MAPALLOC  

#include "FlagDefinitions.h"
#include <stdint.h>

#ifdef _WINDOWS
#define FITDLL_API __declspec(dllexport)
#else
#define FITDLL_API 
#endif

#ifdef __cplusplus
extern "C" {
#endif

typedef unsigned short uint16_t;

FITDLL_API int FLIMGlobalGetUniqueID();
FITDLL_API void FLIMGlobalRelinquishID(int id);

/* =============================================
 * SetupGlobalFit
 * =============================================
 *
 * Setup a global fit controller
 *
 *
 * INPUT PARAMETERS
 * ---------------------------
 * c_idx                   Controller index to request fit
 * global_algorithm 
 * image_irf
 * n_irf                   Number of points in IRF
 * t_irf                   [n_irf] array of time points for IRF measurements
 * irf                     [n_irf] array of irf measurements
 * pulse_pileup            reseved for future use
 * t0_image                
 * n_exp                   Number of exponential species to fit
 * n_fix                   Number of exponential species which have fixed tau values
 * n_decay_group
 * decay_group             [n_exp]
 * tau_min                 [n_exp]
 * tau_max                 [n_exp]
 * estimate_initial_tau    
 * tau_guess               [n_exp] array of initial estimates for tau values. First n_fix will be treated as fixed.
 * fit_beta
 * fixed_beta
 * fit_t0                  Reserved for future use. Set to zero.
 * t0_guess                Initial guess for t0 (zero timepoint). Fixed if fit_t0 = false 
 * fit_offset              Indicates whether to fit an offset. Possible values: {FIX, FIT_LOCALLY, FIT_GLOBALLY}
 * offset_guess            Inital guess for offset
 * fit_scatter             Indicates whether to fit a 'scatter' component. Possible values: {FIX, FIT_LOCALLY, FIT_GLOBALLY}
 * scatter_guess           Initial guess for scatter contribution 


 * mask[]                  [n_group, n_px, n_t] array indicating which which region each pixel belongs to. 
                           Zero indicates the pixel is excluded from any fit 
 * n_t                     Number of timepoints in each measurement
 * t[]                     [n_t] array of gate/bin times in ps

 
 * tau_guess[]             [n_exp] array of initial estimates for tau values. First n_fix will be treated as fixed.
 * fit_fret                Reserved for future use. Set to zero
 * E_guess                Reserved for future use. Set to zero

 * pulsetrain_correction   Indicates whether to account for incomplete decays
 * t_rep                   Repetition rate of laser,  used for pulse train correction. Ignored if pulsetrain_correction = false
 * ref_reconvolution       Indicates whether to use reference reconvolution, i.e. if the IRF was taken using a fluorophore
 * ref_lifetime            Lifetime of reference fluorophore. Ignored if ref_reconvolution = false
 * algorithm               Indicate whether to use Levenberg�Marquardt or Gauss-Newton update rule. In general LM should be used,
                           GN may provide more reliable results for single exponential fits with very few gates.
                              0 LM  Use Levenberg�Marquardt update rule
                              1 GN  Use Gauss-Newton update rule

 *
 * CONFIGURATION PARAMETERS
 * ----- 
 * n_thread     Number of threads to use when fitting. Should be twice the number of processors
 * run_async    Indicates whether the function should run asyncronously 
 * use_callback Indicates whether the program should periodicaly call 'callback' with a status update 
 *              Note that the function will be called from a different thread to the main program
 * callback     If running asyncronously will be called periodically with current group, iteration and chi2
 *              Fitting will stop if zero returned. Not called if NULL, progress may be monitored by calling FLIMGlobalGetFitStatus
 *              Expected function prototype is int callback(int n_group, int n_thread, int *group, 
 *                                                          int *n_completed, int *iter, float *chi2, double progress)
 *              All arrays are of size n_thread.
 *        
 *
 * RETURN VALUE
 * -----
 * 0     Success
 * ...
 */

FITDLL_API int SetupGlobalFit(int c_idx, int global_algorithm, int image_irf,
                              int n_irf, double t_irf[], double irf[], double pulse_pileup, double t0_image[],
                              int n_exp, int n_fix, int n_decay_group, int decay_group[], double tau_min[], double tau_max[], 
                              int estimate_initial_tau, double tau_guess[],
                              int fit_beta, double fixed_beta[],
                              int fit_t0, double t0_guess, 
                              int fit_offset, double offset_guess, 
                              int fit_scatter, double scatter_guess,
                              int fit_tvb, double tvb_guess, double tvb_profile[],
                              int n_fret, int n_fret_fix, int inc_donor, double E_guess[],
                              int pulsetrain_correction, double t_rep,
                              int ref_reconvolution, double ref_lifetime_guess, 
                              int algorithm, int weighting, int calculate_errors, double conf_interval,
                              int n_thread, int runAsync, int use_callback, int (*callback)());

FITDLL_API int SetupGlobalPolarisationFit(int c_idx, int global_algorithm, int image_irf,
                             int n_irf, double t_irf[], double irf[], double pulse_pileup, double t0_image[],
                             int n_exp, int n_fix, 
                             double tau_min[], double tau_max[], 
                             int estimate_initial_tau, double tau_guess[],
                             int fit_beta, double fixed_beta[],
                             int n_theta, int n_theta_fix, int inc_rinf, double theta_guess[],
                             int fit_t0, double t0_guess,
                             int fit_offset, double offset_guess, 
                             int fit_scatter, double scatter_guess,
                             int fit_tvb, double tvb_guess, double tvb_profile[],
                             int pulsetrain_correction, double t_rep,
                             int ref_reconvolution, double ref_lifetime_guess, 
                             int algorithm, int weighting, int calculate_errors, double conf_interval,
                             int n_thread, int runAsync, int use_callback, int (*callback)());

FITDLL_API int SetDataParams(int c_idx, int n_im, int n_x, int n_y, int n_chan, int n_t_full, double t[], double t_int[], int t_skip[], int n_t,
                             int data_type, int* use_im, uint8_t *mask, int threshold, int limit, double counts_per_photon, int global_mode, int smoothing_factor, int use_autosampling);

FITDLL_API int SetDataFloat(int c_idx, float* data);
FITDLL_API int SetDataUInt16(int c_idx, uint16_t* data);
FITDLL_API int SetDataFile(int c_idx, char* data_file, int data_class, int data_skip);

FITDLL_API int SetAcceptor(int c_idx, float* acceptor);


FITDLL_API int SetBackgroundImage(int c_idx, float* background_image);
FITDLL_API int SetBackgroundValue(int c_idx, float background_value);
FITDLL_API int SetBackgroundTVImage(int c_idx, float* tvb_profile, float* tvb_I_map, float const_background);

FITDLL_API int StartFit(int c_idx);

FITDLL_API const char** GetOutputParamNames(int c_idx, int* n_output_params);

FITDLL_API int GetTotalNumOutputRegions(int c_idx);

FITDLL_API int GetImageStats(int c_idx, int* n_regions, int* image, int* regions, int* region_size, float* success, int* iterations, float* stats);

FITDLL_API int GetParameterImage(int c_idx, int im, int param, uint8_t ret_mask[], float image_data[]);




/* =============================================
 * FLIMGlobalGetFitStatus
 * =============================================
 *
 * Returns the status of an asyncronous fitting process
 *
 * OUTPUT PARAMETERS (memory must be allocated on entry)
 * ---------------------------
 * group[]       Indicates which group each thread is currently processing
 * n_completed[] Number of groups each thread has completed
 * iter[]        Current iteration of group each thread is processing
 * chi2[]        Current Chi^2 value of group each thread is processing
 * progress      Fractional overall progress
 *
 * RETURN VALUE
 * ---------------------------
 * 0             Success, incomplete
 * 1             Success, fitting completed
 * ERR_NOT_INIT  Not initialised

 */
FITDLL_API int FLIMGetFitStatus(int c_idx, int *group, int *n_completed, int *iter, double *chi2, double *progress);


/* =============================================
 * FLIMGlobalTerminateFit
 * =============================================
 *
 * Termiate an asyncronous fitting process
 *
 * RETURN VALUE
 * ---------------------------
 * 0            Success
 * ERR_NOT_INIT Not initalised
 *
 */
FITDLL_API int FLIMGlobalTerminateFit(int c_idx);


/* =============================================
 * FLIMGlobalGetFit
 * =============================================
 *
 * Returns fitted decays at arbitary time points. 
 * Must be called after FLIMGlobalFit has completed.
 *
 * INPUT PARAMETERS
 * ---------------------------
 * c_idx       Controller index to request fit
 * im          Image index of requested fit
 * n_t         Number of timepoints required
 * t[]         [n_t] array of timepoints required
 * n_fit       Number of pixels requested
 * fit_mask[]  [n_px] array, mask indicating pixels to return
 *
 * OUTPUT PARAMETERS (memory must be allocated on entry)
 * ---------------------------
 * fit[]       [n_t, n_fit] array of fitted decays. Failed pixels return NaN
 * n_valid     Number of valid fits returned
 */
FITDLL_API int FLIMGlobalGetFit(int c_idx, int im, int n_t, double t[], int n_fit, int fit_mask[], double fit[], int* n_valid);

/* =============================================
 * FLIMGlobalClearFit
 * =============================================
 *
 * Clear fitted data saved from a call to FLIMGlobalFit
 *
 */
FITDLL_API int FLIMGlobalClearFit(int c_idx);


#ifdef __cplusplus
}
#endif
#endif
