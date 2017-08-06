class ResponseHandler
  def self.process(processed_request)
    dialog_state = processed_request[:state]

    if dialog_state == AlexaDialogStates::IN_PROGRESS
      {
        state: AlexaDialogStates::COMPLETED,
        content: processed_request[:content]
      }
    elsif dialog_state == AlexaDialogStates::COMPLETED
      ssml = PhraseBuilder.create(processed_request)

      {
        state: AlexaDialogStates::COMPLETED,
        content: ssml
      }
    end
  end
end
