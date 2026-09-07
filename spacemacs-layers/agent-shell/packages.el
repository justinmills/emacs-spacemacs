;;; packages.el --- agent-shell layer packages file for Spacemacs.  -*- lexical-binding: t; -*-
;;
;; Author: Justin Mills <?@?.com>

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `agent-shell-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `agent-shell/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `agent-shell/pre-init-PACKAGE' and/or
;;   `agent-shell/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:


(defconst agent-shell-packages
  '(agent-shell)
  "The list of Lisp packages required by the agent-shell layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


(defun agent-shell/init-agent-shell ()
  (use-package agent-shell
    :defer t
    :ensure-system-package
    ;; This will ensure we have all of the things we want to hook agent-shell up to set up as part
    ;; of the package initialization.
    (
     (claude . "brew install claude-code")
     ;; this project has been moved here in case it stops working in the future
     ;; @agentclientprotocol/claude-agent-acp
     ;; (claude-agent-acp . "npm install -g @zed-industries/claude-agent-acp")
     (claude-agent-acp . "npm install -g @agentclientprotocol/claude-agent-acp")
     )
    :init
    ;; Initialize variables before agent-shell is loaded
    (setq agent-shell-anthropic-default-model-id "anthropic/claude-sonnet-4.6")
    ;;(setq agent-shell-opencode-default-model-id "github-copilot/claude-sonnet-4.6")
    (setq agent-shell-opencode-default-model-id "amazon-bedrock/us.anthropic.claude-sonnet-4-6")
    ;; (setq agent-shell-opencode-default-model-id "amazon-bedrock/amazon.nova-pro-v1:0")
    ;; Initialize variables after agent-shell is loaded
    ;; Key binding to launch agent shell
    (spacemacs/set-leader-keys "$as" 'agent-shell)
    :config
    )
  )
