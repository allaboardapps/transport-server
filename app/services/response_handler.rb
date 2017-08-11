class ResponseHandler
  def self.process(request)
    intent = request[:intent]
    state = request[:state]

    if state == AlexaDialogStates::IN_PROGRESS
      content = request[:content]
    elsif state == AlexaDialogStates::COMPLETED
      content = PhraseBuilder.create(request)
    end

    {
      intent: intent,
      state: state,
      content: content
    }
  end
end
