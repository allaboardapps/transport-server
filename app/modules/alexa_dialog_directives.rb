module AlexaDialogDirectives
  DELEGATE = "Dialog.Delegate".freeze
  ELICIT_SLOT = "Dialog.ElicitSlot".freeze
  CONFIRM_SLOT = "Dialog.ConfirmSlot".freeze
  CONFIRM_INTENT = "Dialog.ConfirmIntent".freeze

  def self.all
    [
      AlexaDialogDirectives::DELEGATE,
      AlexaDialogDirectives::ELICIT_SLOT,
      AlexaDialogDirectives::CONFIRM_SLOT,
      AlexaDialogDirectives::CONFIRM_INTENT
    ]
  end
end
