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

#open asm_filename and write to hack_file and pass to assembler
#open asm_filename and assign it to asm_file
File.open(asm_filename) do |asm_file|
  asm_basename = File.basename(asm_filename, '.asm')#remove .asm
  path = File.split(asm_filename)[0]
  hack_filename = "#{path}/#{asm_basename}.hack"
  File.open(hack_filename, 'w') do |hack_file|
    assembler = Assembler.new(asm_file, hack_file)
    assembler.assemble!
  end
end

