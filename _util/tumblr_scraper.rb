require 'rubygems'
require 'httparty'

# ||= for testing in case it's already been set previously in the session
# only an issue since tumblr keeps dying
@posts ||= HTTParty.get('http://t.yelyah.com/api/read?filter=none&type=audio&num=5')['tumblr']['posts']['post']

@posts.each do |post|
  
  ### FILE NAME ###
  filename_date = Date.parse(post['date']).to_s
  
  if post['id3_title']
    title = post['id3_title']
  else
    title = 'untitled'
  end
  
  # swap dashes for spaces in the filename
  # gsub is global sub
  filename_title = title.gsub(" ", "-")
  
  filename = filename_date + "-" + filename_title + ".md"
  puts filename
  
  f = File.new('/tmp/_posts/'+filename, "w")
  
  
  # YAML Front Matter
  f.puts "---"
  f.puts "layout: song"
  f.puts "category: music"
  
  ### title ###
  # determined earlier
  f.puts "title: " + title
  
  ### tags ###
  # check here for empty tags
  if post['tag'].nil?
    f.puts "tags: [none]"
  else
    f.puts "tags: [" + post['tag'].join(', ') + "]"
  end
  
  ### date ###
  
  ### tumblr mp3 embed ###
  tumblr_audio_file = post['audio_player'].match(/audio_file=(.+)&/)[1]
  f.puts "tumblr_audio_file: " + tumblr_audio_file
  
  f.puts "tumblr_url: " + post['url']
  
  f.puts "tumblr_date: " + post['date']
  
  f.puts "tumblr_type: " + post['type']
  
  # check for blank captions, it's happened once
  if post['audio_caption'].nil?
    post['audio_caption'] = ""
  end
  
  # the following checks for something like:
  # yelyah - "solo piano 20101201" piano improv
  if post['audio_caption'].match(/^yelyah/)
    tumblr_teaser = post['audio_caption'].split("\n")[0]
    f.puts "tumblr_teaser: " + tumblr_teaser
    
  end
  
  # end YAML Front Matter
  f.puts "---"
  
  # THE POST ITSELF
  if tumblr_teaser
    f.puts post['audio_caption'].split("\n")[2..-1] # print from line 3 to the end
  else
    f.puts post['audio_caption']
  end
  
  f.close
  
end;0

