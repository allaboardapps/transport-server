module AlexaDialogDirectives
  STARTED = "started".freeze
  IN_PROGRESS = "in_progress".freeze
  COMPLETED = "completed".freeze

  def self.all
    [
      AlexaDialogDirectives::STARTED,
      AlexaDialogDirectives::IN_PROGRESS,
      AlexaDialogDirectives::COMPLETED
    ]
  end
end
