class Emailer
  @queue = :emailer_queue

  def self.perform(user_id)
    user = User.find(user_id)
    puts "found user going to send email to #{user.email}"
    sleep(5)
    uri = URI.parse("http://localhost:9292/faye")
    msg = '{"channel": "#CHANNELID#", "data": "email sent"}'.gsub(/#CHANNELID#/,user_id.to_s)
    puts "message: #{msg}"
    Net::HTTP.post_form(uri, :message => msg)
  end

end
