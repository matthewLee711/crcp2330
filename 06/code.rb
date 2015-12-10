require_relative 'parser'

#Code class which creates c-instruction binary
class Code
  	#mnemonic is passed to 
	def initialize
	end

  	#hash table for "dest" look up
  	#nil = '' as well?
	DEST = {
		nil=> '000',
		'M'=> '001',
		'D'=> '010',
		'MD'=> '011',
		'A'=> '100',
		'AM'=> '110',
		'AMD'=> '111'
	}
	#hash table for "comp" look up if a=0
	COMP = {
		nil=> '0000000', '0'=> '0101010', '1'=> '0111111', '-1'=> '0111010', 'D'=> '0001100',
		'A'=> '0110000', '!D'=> '0001101', '!A'=> '0110001', '-D'=> '0001111',
		'-A'=> '0110011', 'D+1'=> '0011111',
		'A+1'=> '0110111', 'D-1'=> '0001110', 'A-1'=> '0110010', 'D+A'=> '0000010',
		'D-A'=> '0010011', 'A-D'=> '0000111', 'D&A'=> '0000000', 'D|A'=> '0010101',
		#M when a=1
		'M'=> '1110000', '!M'=> '1110001', '-M'=> '1110011', 'M+1'=> '1110111',
		'M-1'=> '1110010', 'D+M'=> '1000010', 'D-M'=> '1010011', 'M-D'=> '1000111',
		'D&M'=> '1000000', 'D|M'=> '1010101'
	}
	#hash table for "jump" look up
	JUMP = {
		nil=> '000',
		'JGT'=> '001',
		'JEQ'=> '010',
		'JGE'=> '011',
		'JLT'=> '100',
		'JNE'=> '101',
		'JLE'=> '110',
		'JMP'=> '111'
	}

  #Function which translates C-instruction
  #dest=comp;jump
  #calculates dest component
  def dest(mnemonic)
  	DEST[mnemonic]
  end
  #finds comp component
  def comp(mnemonic)
    COMP[mnemonic]
  end
  #finds jump component
  def jump(mnemonic)
  	JUMP[mnemonic]
  end


end