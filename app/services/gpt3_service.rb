class Gpt3Service
  include HTTParty

  attr_reader :api_url, :options, :model, :message

  def initialize(message, model = 'gpt-3.5-turbo')
    api_key = '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'
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}"
      }
    }
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @model = model
    @message = message
  end

  def call
    body = {
      model: @model,
      messages: [{ role: 'user', content: message }]
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 90)
    raise response['error']['message'] unless response.code == 200

    response['choices'][0]['message']['content']
  end

  class << self
    def call(message, model = 'gpt-3.5-turbo')
      new(message, model).call
    end
  end
end