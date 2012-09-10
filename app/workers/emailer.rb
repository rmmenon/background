class Emailer
  @queue = :emailer_queue

  def self.perform(parameters)
    puts "parameters: #{parameters}"
    user_id = parameters["user_id"]
    channel = parameters["channel"]
    user = User.find(user_id)
    puts "found user going to send email to #{user.email}"
    sleep(1)
    uri = URI.parse("http://localhost:9292/faye")
    msg = {"channel"=> "/messages/#{user_id}", "data"=> "email sent"}
    Net::HTTP.post_form(uri, :message => msg.to_json)
  end

end
