require 'rubygems'
require 'rest_client'
require 'yaml'

base_path = "/Users/hayley/Dropbox/_music/"

#TODO
# su.pr or bit.ly integration and post that link at the end of the post

def getmeafile
  puts "what's your file? "
  @file = gets.chomp
end
  
getmeafile until @file && File.file?(@file)

file_contents = File.new(@file, 'rb').read()

# the below is ripped from the jekyll source
if file_contents =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
  post_body = file_contents[($1.size + $2.size)..-1]
  yaml_data = YAML.load($1)
end

title = yaml_data['title'] || File.basename(@file, ".md").split('-')[3..-1].join(' ')
teaser = yaml_data['teaser']

caption = "yelyah - \"#{title}\" #{teaser}\n\n#{post_body}"

audio_filename = title << ".mp3"

audio_file = File.join(base_path, audio_filename)

if !@tumblr_email
  print "what is your tumblr email address? "
  @tumblr_email = gets.chomp
end

if !@tumblr_password
  print "what is your password? "
  @tumblr_password = gets.chomp
end

# PRINT CONFIRMATION HERE

begin
  RestClient.post("http://www.tumblr.com/api/write", {
    :email => @tumblr_email,
    :password => @tumblr_password,
    :type => "audio",
    :data => File.new(audio_file),
    :caption => caption,
    :format => "markdown",
    :tags => yaml_data['tags'].join(','),
    })
rescue => e
  puts e.response
  if e.response == "You've exceeded your daily audio upload limit."
    puts "here'd be a good place to post an externally hosted mp3 instead"
  end
end



  #rescue => e
  #  puts e.response
  #  if e.response == "You've exceeded your daily audio upload limit."
  #    puts "here'd be a good place to post an externally hosted mp3 instead"
  #  end




# the rest is what I had originally, left here since it never got committed
#
__END__
### INSANE
#post_type = !yaml_data['tumblr_type'].nil? ? yaml_data['tumblr_type'] : 'monkey'
#puts post_type
#post_type = yaml_data['tumblr_type'].nil? ? 'monkey' : yaml_data['tumblr_type']
#puts post_type
#post_type = yaml_data['tumblr_type'] ? yaml_data['tumblr_type'] : 'monkey'
#puts post_type
#post_type = yaml_data['tumblr_type'] || 'monkey'
#puts post_type
### I LEAVE IT HERE BECAUSE I HAVE NO SHAME


# things that should be determined via the yaml front matter
post_type = yaml_data['tumblr_type'] || 'audio'
#post_external_mp3 = yaml_data['mp3']

#title = yaml_data['tumblr_teaser'] || ''
post_caption = "#{yaml_data['title']}\n\n#{post_body}"


title = yaml_data['title'].nil? ? "" : yaml_data['title']

puts title


# you can set the email/password in your session and it will just use that if it's assigned
if !@tumblr_email
  print "what is your tumblr email address? "
  @tumblr_email = gets.chomp
end

if !@tumblr_password
  print "what is your password? "
  @tumblr_password = gets.chomp
end

#local_variables.each do |var|
  #puts "#{var} is #{var.class} and is equal to #{eval(var).inspect}"
#  puts "#{var}:\t\t #{eval(var).inspect}"
#end

__END__
begin
  RestClient.post 'http://www.tumblr.com/api/write',
    :email        => tumblr_email,
    :password     => tumblr_password,
    :type         => 'audio',
    :caption      => 'test caption',
    :data         => File.new('/Users/hayley/noisy_macbook.mp3', 'rb')
rescue => e
  puts e.response
  if e.response == "You've exceeded your daily audio upload limit."
    # backup post
    begin
      RestClient.post 'http://www.tumblr.com/api/write',
        :email        => tumblr_email,
        :password     => tumblr_password,
        :type         => post_type,
        :caption      => post_caption,
        # next one can't be specified as a symbol since hyphens/dashes are apparently invalid
        "externally-hosted-url" => yaml_data['mp3']
        # 'http://media.yelyah.com/mp3/yelyah-the_tumblr_is_down_20101206.mp3'
    rescue => e
      puts e.response
    end
  end
end

