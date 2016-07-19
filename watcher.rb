require 'filewatcher'

puts `rake assets:compile`

FileWatcher.new(["assets/*.*", "assets/**/*.*", "assets/**/**/*.*"]).watch do |filename|
  puts "Changed " + filename
  `rake assets:clean` # remove old assets
  puts `rake assets:compile`
end