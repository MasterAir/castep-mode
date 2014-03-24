;; castep-mode-el -- Major mode for editing/viewing CASTEP input files.

;; Author : Daniel Jones <daniel.jones@materials.ox.ac.uk>
;; Created : 24th February 2014
;; Keywords : CASTEP major-mode

;; Copyright (C) 2014 Daniel Jones <daniel.jones@materials.ox.ac.uk>

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

(defvar castep-mode-hook nil)
(defvar castep-mode-map
  (let ((castep-mode-map (make-keymap)))
    ;; Key mappings should go here. 
    ;; 'newline-and-insert is an example and binds to \C-j the default binding.
    (define-key castep-mode-map "\C-j" 'newline-and-indent)
    castep-mode-map)
  "Keymap for CASTEP major mode")

;; Autoload castep-mode when we open .cell or .param files.
(add-to-list 'auto-mode-alist '("\\.cell\\'" . castep-mode))
(add-to-list 'auto-mode-alist '("\\.param\\'" . castep-mode))

;; Set up keyword highlighting, make it case insensitive.

(setq font-lock-keywords-case-fold-search t)

(defconst castep-font-lock-keywords-1
  (list
   ; %block and %endblock should get builtin colouring.
   '("\\<\\(?:%\\(?:\\(?:end\\)?block\\)\\)\\>" . font-lock-builtin-face)
   ; Generated using emacs' regexp-opt and a list of cell file keywords from castep --help
   '("\\<\\(ATOMIC_INIT\\|BS_KPOINT\\(?:S_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\|PATH\\(?:_SPACING\\)?\\)\\|_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\|PATH\\(?:_SPACING\\)?\\)\\)\\|C\\(?:ELL_\\(?:CONSTRAINTS\\|NOISE\\)\\|HEMICAL_POTENTIAL\\)\\|E\\(?:LNES_KPOINT_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\)\\|XTERNAL_\\(?:EFIELD\\|PRESSURE\\)\\)\\|FIX_\\(?:ALL_\\(?:CELL\\|IONS\\)\\|COM\\|VOL\\)\\|HUBBARD_\\(?:ALPHA\\|U\\)\\|IONIC_\\(?:\\(?:CONSTRAINT\\|VELOCITIE\\)S\\)\\|JCOUPLING_SITE\\|KPOINT\\(?:S_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\)\\|_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\)\\)\\|LATTICE_\\(?:ABC\\|CART\\)\\|MAGRES_KPOINT_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\|PATH\\(?:_SPACING\\)?\\)\\|NONLINEAR_CONSTRAINTS\\|OPTICS_KPOINT\\(?:S_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\)\\|_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\)\\)\\|P\\(?:HONON_\\(?:FINE_KPOINT_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\|PATH\\(?:_SPACING\\)?\\)\\|GAMMA_DIRECTIONS\\|KPOINT\\(?:S_\\(?:LIST\\|PATH\\(?:_SPACING\\)?\\)\\|_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\|PATH\\(?:_SPACING\\)?\\)\\)\\|SUPERCELL_MATRIX\\)\\|OSITIONS_\\(?:ABS\\(?:_\\(?:INTERMEDIATE\\|PRODUCT\\)\\)?\\|FRAC\\(?:_\\(?:INTERMEDIATE\\|PRODUCT\\)\\)?\\|NOISE\\)\\)\\|QUANTI\\(?:[SZ]ATION_AXIS\\)\\|S\\(?:EDC_CUSTOM_PARAMS\\|NAP_TO_SYMMETRY\\|PEC\\(?:IES_\\(?:GAMMA\\|LCAO_STATES\\|MASS\\|POT\\|Q\\)\\|TRAL_KPOINT\\(?:S_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\|PATH\\(?:_SPACING\\)?\\)\\|_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\|PATH\\(?:_SPACING\\)?\\)\\)\\)\\|UPERCELL_\\(?:KPOINT\\(?:S_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\)\\|_\\(?:LIST\\|MP_\\(?:GRID\\|OFFSET\\|SPACING\\)\\)\\)\\|MATRIX\\)\\|YMMETRY_\\(?:GENERATE\\|OPS\\|TOL\\)\\)\\)\\>" . font-lock-variable-name-face)

'("\\<\\(B\\(?:A\\(?:CKUP_INTERVAL\\|SIS_\\(?:DE_DLOGE\\|PRECISION\\)\\)\\|ORN_CHARGE_SUM_RULE\\|S_\\(?:EIGENVALUE_TOL\\|MAX_\\(?:CG_STEPS\\|ITER\\)\\|N\\(?:\\(?:EXTRA_\\)?BANDS\\)\\|PERC_EXTRA_BANDS\\|RE_EST_K_SCRN\\|WRITE_EIGENVALUES\\|XC_FUNCTIONAL\\)\\)\\|C\\(?:ALC\\(?:ULATE_\\(?:BORN_CHARGES\\|DENSDIFF\\|ELF\\|HIRSHFELD\\|RAMAN\\|STRESS\\)\\|_\\(?:FULL_EX_POT\\|MOLECULAR_DIPOLE\\)\\)\\|H\\(?:ARGE\\(?:_UNIT\\)?\\|ECKPOINT\\)\\|ML_\\(?:FILENAME\\|OUTPUT\\)\\|O\\(?:MMENT\\|NTINUATION\\)\\|UT_OFF_ENERGY\\)\\|D\\(?:ATA_DISTRIBUTION\\|EVEL_CODE\\|IPOLE_\\(?:CORRECTION\\|DIR\\|UNIT\\)\\)\\|E\\(?:F\\(?:ERMI_TOL\\|IELD_\\(?:C\\(?:ALC_ION_PERMITTIVITY\\|ONVERGENCE_WIN\\)\\|DFPT_METHOD\\|ENERGY_TOL\\|FREQ_SPACING\\|IGNORE_MOLEC_MODES\\|MAX_C\\(?:\\(?:G_STEP\\|YCLE\\)S\\)\\|OSCILLATOR_Q\\|UNIT\\)\\)\\|L\\(?:EC\\(?:TRONIC_MINIMIZER\\|_\\(?:CONVERGENCE_WIN\\|DUMP_FILE\\|E\\(?:\\(?:IGENVALUE\\|NERGY\\)_TOL\\)\\|FORCE_TOL\\|METHOD\\|RESTORE_FILE\\|TEMP\\)\\)\\|NES_\\(?:EIGENVALUE_TOL\\|N\\(?:\\(?:EXTRA_\\)?BANDS\\)\\|PERC_EXTRA_BANDS\\|XC_FUNCTIONAL\\)\\)\\|N\\(?:\\(?:ERG\\|TROP\\)Y_UNIT\\)\\|XC\\(?:\\(?:HANGE_REFLECT_KPT\\|ITED_STATE_SCISSOR\\)S\\)\\)\\|F\\(?:FT_MAX_PRIME_FACTOR\\|I\\(?:N\\(?:E_G\\(?:MAX\\|RID_SCALE\\)\\|ITE_BASIS_\\(?:CORR\\|NPOINTS\\|SPACING\\)\\)\\|X\\(?:ED_NPW\\|_OCCUPANCY\\)\\)\\|\\(?:ORCE\\(?:_CONSTANT\\)?\\|REQUENCY\\)_UNIT\\)\\|G\\(?:A_\\(?:BULK_SLICE\\|FIXED_N\\|M\\(?:AX_GENS\\|UTATE_\\(?:AMP\\|RATE\\)\\)\\|POP_SIZE\\)\\|EOM_\\(?:CONVERGENCE_WIN\\|DISP_TOL\\|ENERGY_TOL\\|F\\(?:ORCE_TOL\\|REQUENCY_EST\\)\\|L\\(?:BFGS_MAX_UPDATES\\|INMIN_TOL\\)\\|M\\(?:AX_ITER\\|ETHOD\\|ODULUS_EST\\)\\|S\\(?:PIN_FIX\\|TRESS_TOL\\)\\|TPSD_I\\(?:\\(?:NIT_STEPSIZ\\|TERCHANG\\)E\\)\\|USE_LINMIN\\)\\|RID_SCALE\\)\\|I\\(?:MPOSE_TRS\\|\\(?:NV_LENGTH_UNI\\|PRIN\\|R_INTENSITY_UNI\\)T\\)\\|K_SCRN_\\(?:AVERAGING_SCHEME\\|DEN_FUNCTION\\)\\|LENGTH_UNIT\\|M\\(?:A\\(?:GRES_\\(?:CONV\\(?:ERGENCE_WIN\\|_TOL\\)\\|JCOUPLING_TASK\\|M\\(?:AX_\\(?:\\(?:CG_STEP\\|SC_CYCLE\\)S\\)\\|ETHOD\\)\\|TASK\\|WRITE_RESPONSE\\|XC_FUNCTIONAL\\)\\|SS_UNIT\\|X_\\(?:\\(?:CG_STEP\\|DIIS_STEP\\|S\\(?:CF_CYCLE\\|D_STEP\\)\\)S\\)\\)\\|D_\\(?:BAROSTAT\\|CELL_T\\|D\\(?:AMPING_\\(?:RESET\\|SCHEME\\)\\|ELTA_T\\)\\|E\\(?:LEC_\\(?:CONVERGENCE_WIN\\|\\(?:E\\(?:IGENVALUE\\|NERGY\\)\\|FORCE\\)_TOL\\)\\|NSEMBLE\\|QM_\\(?:CELL_T\\|ION_T\\|METHOD\\|T\\)\\|XTRAP\\(?:_FIT\\)?\\)\\|ION_T\\|LANGEVIN_T\\|N\\(?:HC_LENGTH\\|OSE_T\\|UM_\\(?:BEADS\\|ITER\\)\\)\\|OPT_DAMPED_DELTA_T\\|PATHINT_\\(?:INIT\\|NUM_STAGES\\|STAGING\\)\\|SAMPLE_ITER\\|T\\(?:EMPERATURE\\|HERMOSTAT\\)\\|USE_P\\(?:ATHINT\\|LUMED\\)\\)\\|E\\(?:SSAGE_SIZE\\|TALS_METHOD\\)\\|IX\\(?:ING_SCHEME\\|_\\(?:C\\(?:HARGE_\\(?:AMP\\|GMAX\\)\\|UT_OFF_ENERGY\\)\\|HISTORY_LENGTH\\|METRIC_Q\\|SPIN_\\(?:AMP\\|GMAX\\)\\)\\)\\)\\|N\\(?:BANDS\\|DOWN\\|E\\(?:\\(?:LECTRON\\|XTRA_BAND\\)S\\)\\|LXC_\\(?:CALC_FULL_EX_POT\\|DIV_CORR_\\(?:NPTS_STEP\\|ON\\|S_WIDTH\\|TOL\\)\\|EXCHANGE_\\(?:FRACTION\\|REFLECT_KPTS\\|SCREENING\\)\\|IMPOSE_TRS\\|K_SCRN_\\(?:AVERAGING_SCHEME\\|DEN_FUNCTION\\)\\|P\\(?:AGE_EX_POT\\|PD_\\(?:INTEGRAL\\|SIZE_[XYZ]\\)\\)\\|RE_EST_K_SCRN\\)\\|SPINS\\|U\\(?:M_\\(?:BACKUP_ITER\\|DUMP_CYCLES\\|FARMS\\|OCC_CYCLES\\|PROC_IN_SMP\\(?:_FINE\\)?\\)\\|P\\)\\)\\|OPT\\(?:ICS_\\(?:N\\(?:\\(?:EXTRA_\\)?BANDS\\)\\|PERC_EXTRA_BANDS\\|XC_FUNCTIONAL\\)\\|_STRATEGY\\(?:_BIAS\\)?\\)\\|P\\(?:AGE_\\(?:EX_POT\\|WVFNS\\)\\|DOS_CALCULATE_WEIGHTS\\|ERC_EXTRA_BANDS\\|HONON_\\(?:C\\(?:ALC\\(?:ULATE_DOS\\|_LO_TO_SPLITTING\\)\\|ON\\(?:ST_BASIS\\|VERGENCE_WIN\\)\\)\\|D\\(?:FPT_METHOD\\|OS_\\(?:LIMIT\\|SPACING\\)\\)\\|ENERGY_TOL\\|F\\(?:IN\\(?:E_\\(?:\\(?:CUTOFF_\\)?METHOD\\)\\|ITE_DISP\\)\\|ORCE_CONSTANT_\\(?:CUT\\(?:OFF\\|_SCALE\\)\\|ELLIPSOID\\)\\)\\|M\\(?:AX_C\\(?:\\(?:G_STEP\\|YCLE\\)S\\)\\|ETHOD\\)\\|PRECONDITIONER\\|SUM_RULE\\(?:_METHOD\\)?\\|USE_KPOINT_SYMMETRY\\|WRITE_\\(?:DYNAMICAL\\|FORCE_CONSTANTS\\)\\)\\|OPN_\\(?:BOND_CUTOFF\\|CALCULATE\\)\\|PD_\\(?:INTEGRAL\\|SIZE_[XYZ]\\)\\|R\\(?:ESSURE_UNIT\\|INT_\\(?:CLOCK\\|MEMORY_USAGE\\)\\)\\|SPOT_\\(?:\\(?:BETA_PHI\\|NONLOCAL\\)_TYPE\\)\\)\\|R\\(?:A\\(?:MAN_RANGE_\\(?:HIGH\\|LOW\\)\\|ND_SEED\\)\\|E\\(?:USE\\|_EST_K_SCRN\\)\\|UN_TIME\\)\\|S\\(?:E\\(?:CONDD_METHOD\\|DC_\\(?:APPLY\\|D_\\(?:G06\\|\\(?:JCH\\|T\\)S\\)\\|LAMBDA_OBS\\|N_OBS\\|S\\(?:6_\\(?:G06\\|JCHS\\)\\|CHEME\\|R_\\(?:\\(?:JCH\\|T\\)S\\)\\)\\)\\)\\|MEARING_\\(?:SCHEME\\|WIDTH\\)\\|P\\(?:ECTRAL_\\(?:EIGENVALUE_TOL\\|MAX_\\(?:\\(?:STEPS_PER_\\)?ITER\\)\\|N\\(?:\\(?:EXTRA_\\)?BANDS\\)\\|PERC_EXTRA_BANDS\\|RE_EST_K_SCRN\\|T\\(?:ASK\\|HEORY\\)\\|WRITE_EIGENVALUES\\|XC_FUNCTIONAL\\)\\|IN\\(?:_\\(?:FIX\\|POLARI\\(?:[SZ]ED\\)\\)\\)?\\)\\|TOP\\)\\|T\\(?:ASK\\|DDFT_\\(?:APPROXIMATION\\|CONVERGENCE_WIN\\|EIGENVALUE_\\(?:METHOD\\|TOL\\)\\|M\\(?:AX_ITER\\|ETHOD\\)\\|N\\(?:\\(?:EXTRA\\|UM\\)_STATES\\)\\|SELECTED_STATE\\|XC_FUNCTIONAL\\)\\|HERMO_\\(?:CALCULATE_HELMHOLTZ\\|T_\\(?:NPOINTS\\|S\\(?:PACING\\|T\\(?:ART\\|OP\\)\\)\\)\\)\\|IME_UNIT\\|SSEARCH_\\(?:CG_MAX_ITER\\|DISP_TOL\\|ENERGY_TOL\\|FORCE_TOL\\|LSTQST_PROTOCOL\\|M\\(?:AX_PATH_POINTS\\|ETHOD\\)\\|QST_MAX_ITER\\)\\)\\|V\\(?:\\(?:ELOCITY\\|OLUME\\)_UNIT\\)\\|W\\(?:ANNIER_\\(?:ION_\\(?:C\\(?:MOMENTS\\|UT\\(?:_\\(?:FRACTION\\|TOL\\)\\)?\\)\\|MOMENTS\\|RMAX\\)\\|M\\(?:AX_SD_STEPS\\|IN_ALGOR\\)\\|PRINT_CUBE\\|RESTART\\|S\\(?:D_STEP\\|PREAD_T\\(?:OL\\|YPE\\)\\)\\)\\|RITE_\\(?:BIB\\|C\\(?:\\(?:ELL\\|IF\\)_STRUCTURE\\)\\|FORMATTED_\\(?:DENSITY\\|ELF\\|POTENTIAL\\)\\|ORBITALS\\)\\)\\|XC_\\(?:FUNCTIONAL\\|VXC_DERIV_EPSILON\\)\\)\\>" . font-lock-variable-name-face)
  "Keywords for highlighting in castep-mode"
)
)

(defvar castep-font-lock-keywords castep-font-lock-keywords-1
  "Default highlighting for castep-mode")

(defvar castep-mode-syntax-table
  (let ((castep-mode-syntax-table (make-syntax-table)))
  
  ; Make underscores be part of words
  (modify-syntax-entry ?_ "w" castep-mode-syntax-table)

  ; Comment styles are all single character, single line and include a bunch of characters.
  (modify-syntax-entry ?! "<" castep-mode-syntax-table)
  (modify-syntax-entry ?# "<" castep-mode-syntax-table)
  (modify-syntax-entry ?\; "<" castep-mode-syntax-table)

  (modify-syntax-entry ?\n ">" castep-mode-syntax-table)
  castep-mode-syntax-table)
  "Syntax table for castep-mode" )

;; No code for auto-indentation yet.

;; Call castep help


;; Want to define where to look for CASTEP on this machine and mechanism to call castep --help word-at-point
;(defvar castep-exe 'castep)

;(defun castep-help-all ()
;  (interactive)
;  (let (this-command (concat castep-exe '-help all'))
;  (shell-command this-command)))


;; Function to enter this mode.
(defun castep-mode ()
  "Major mode for editing CASTEP input files"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table castep-mode-syntax-table)
  (use-local-map castep-mode-map)
  ; Set case-fold to true, ignore case when colouring castep files
  (set (make-local-variable 'font-lock-defaults) 
       '(castep-font-lock-keywords nil t))
  (setq major-mode 'castep-mode)
  (setq mode-name 'CASTEP)
  (run-hooks 'castep-mode-hook))

(provide 'castep-mode)
