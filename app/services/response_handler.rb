class ResponseHandler
  def self.process(processed_request)
    intent = processed_request[:intent]
    dialog_state = processed_request[:state]

    if dialog_state == AlexaDialogStates::IN_PROGRESS
      content = processed_request[:content]
    elsif dialog_state == AlexaDialogStates::COMPLETED
      content = PhraseBuilder.create(processed_request)
    end

    {
      intent: intent,
      state: dialog_state,
      content: content
    }
  end
end
