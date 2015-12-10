require_relative 'code'

class Parser
  
  def initialize(assembly_instructions)
  	@assembly_instructions = assembly_instructions
  	@machine_instructions = []
  	@codex= Code.new()
  end
  #Function which parses each line of assembly instruction
  def parse
  	#for each line of assembly, check if A or C instruction
  	@assembly_instructions.each do |instruction|
  	  if command_type(instruction) == :a_command
  	  	@machine_instructions << assemble_a_command(instruction)
  	  elsif command_type(instruction) == :c_command
  	  	@machine_instructions << assemble_c_command(instruction)
  	  elsif command_type(instruction) == :l_command
  	  	@machine_instructions << assemble_l_command(instruction)
  	  #if it is a full on label, insert nil
  	  else
  	  	@machine_instructions << nil
  	  end
  	end
  	@machine_instructions
  end# of parse

  #function which assembles A instructions and inserts
  def assemble_a_command(instruction)
  	command = "0"
  	command << constant(instruction[1..-1])
  end# of a_command
  #function returns binary of value
  def constant(value)
  	"%015b" % value
  end
  
  #dest=comp;jump
  #function which assembles C instructions and inserts binary
  def assemble_c_command(instruction)
    if instruction[1] == ';'
      return "111" + @codex.comp(nil) + @codex.dest(instruction.split('=').first) + @codex.jump(instruction.split(';')[-1])
    else
    	#p "dest: #{instruction.split('=').first} " + "comp: #{instruction.split('=')[-1]} " + "jump: #{nil}"
      return "111" + @codex.comp(instruction.split('=')[-1]) + @codex.dest(instruction.split('=').first) + @codex.jump(nil)
    end
    #{}"1110000000000000"
  end# of c_command

  #function which assembles label instructions and inserts binary
  def assembler_l_command(instruction)
  end


  #function which returns symbolic ruby for A, C or L instr.
  def command_type(instruction)
  	if instruction.start_with?("@") && instruction[1].is_a? Integer
  	  :a_command
  	elsif instruction.start_with?("@") && instruction[1].is_a? String
  	  :l_command
  	else
  	  :c_command
  	end
  end# of command_type

end# end of class