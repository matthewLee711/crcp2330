#! usr/bin/env ruby

require_relative 'parser'

class Assembler
  #instantiate assembler
  def initialize(asm_file, hack_file)
    #create member variables 
    @asm_file = asm_file
    @hack_file = hack_file
    #instantiate parser object and pass it array
    @parser = Parser.new(instructions_from_file)
  end
  
  #Function which performs assembler 
  def assemble!
    #write each binary instruction to hack file
    @parser.parse.each {|instruction| @hack_file << instruction << "\n" }
  end# of assemble

  #Function which extracts info ands stores in array
  def instructions_from_file
    #lines stores text into an array
    lines = @asm_file.readlines
    #iterator, for each element in "line" array,
    #replace lines that start with "//" in place of ''
    #remove return keys
    lines.each { |line| line.gsub! /\/\/.*/, ''; line.strip! }
    #delete all lines with empty string
    lines.delete("")
    return lines #return line specifically
  end# of function

end# of Assembler class

#MAIN
#Function tests if argument being passed is valid
def args_valid?
  ARGV[0] && ARGV[0].end_with?(".asm") && ARGV.length == 1
end
#function tests if file is readable
def is_readable?(path)
  File.readable?(path)
end

#encapsulate
#Function which creates a file to write to
def hack_filename(asm_filename)
  asm_basename = File.basename(asm_filename, '.asm')#remove .asm
  path = File.split(asm_filename)[0]
  #return string path
  "#{path}/#{asm_basename}.hack"
end

#Conditionals which makes calls to functions which test if valid file
#unless the args are valid, quit program
unless args_valid?
  abort("Usage: ./assembler.rb Prog.asm")
end

#first argument is stored into "asm_filename"
asm_filename = ARGV[0]

#unless the file is readable
unless is_readable?(asm_filename)
  abort("#{asm_filename} is not found or unreadable") 
end

#open asm_filename and write to hack_file and pass to assembler
#open asm_filename and assign it to asm_file
File.open(asm_filename, 'r') do |asm_file|
  #create path and write to hack_file
  File.open(hack_filename(asm_filename), 'w') do |hack_file|
    #instantiate assembler which will take in files
    assembler = Assembler.new(asm_file, hack_file)
    assembler.assemble!
  end
end

