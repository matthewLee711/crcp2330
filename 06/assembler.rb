#! usr/bin/env ruby

def args_valid?
  ARGV[0] && ARGV[0].end_with?(".asm") && ARGV.length == 1
end

def is_readable?(path)
  File.readable?(path)
end

#unless the args are valid, quit program
unless args_valid?
  abort("Usage: ./assembler.rb Prog.asm")
end

asm_filename = ARGV[0]

#unless the file is readable
unless is_readable?(asm_filename)
  abort("#{asm_filename} is not found or unreadable") 
end

puts "The contents of #{asm_filename}"
asm_file = File.open(asm_filename)
puts asm_file.read

