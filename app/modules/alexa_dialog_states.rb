module AlexaDialogStates
  STARTED = "started".freeze
  IN_PROGRESS = "in_progress".freeze
  COMPLETED = "completed".freeze

  def self.all
    [
      AlexaDialogStates::STARTED,
      AlexaDialogStates::IN_PROGRESS,
      AlexaDialogStates::COMPLETED
    ]
  end
end
