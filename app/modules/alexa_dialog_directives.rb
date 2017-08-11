module AlexaDialogDirectives
  DELEGATE = "Dialog.Delegate".freeze
  ELICIT_SLOT = "Dialog.ElicitSlot".freeze
  CONFIRM_SLOT = "Dialog.ConfirmSlot".freeze
  CONFIRM_INTENT = "Dialog.ConfirmIntent".freeze

  def self.all
    [
      AlexaDialogSteps::DELEGATE,
      AlexaDialogSteps::ELICIT_SLOT,
      AlexaDialogSteps::CONFIRM_SLOT,
      AlexaDialogSteps::CONFIRM_INTENT
    ]
  end
end
