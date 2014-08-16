#!/usr/bin/ruby -w
exit if ARGV.length == 1
p ARGV.length
p ARGV[0]
infile = ARGV[0]
#while gets
#    print  $_
#end
sum = 0
File.open(infile,"r") do |file|
    while line= file.gets
        sum += Integer(line);
    end
end
p sum
