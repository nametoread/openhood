require "openhood/bridge"

require "time"

module Openhood
	class Clui
		def initialize
			@@mode = askMode
			result = Bridge::calculateAndSave(@@mode, askEffect, askSecret, askFile)
			puts "saved to: #{result}"
		end

		def askMode
			print "aes / cam / des / seed: "				
			Bridge::getMode(gets.strip)
		end

		def askEffect
			print "en/de[crypt]: "
			Bridge::getEffect(gets.strip)	
		end

		def askFile
			print "path to file: "
			Bridge::getFile(gets.strip)
		end

		def askSecret
			print "phrase: "
			Bridge::getSecret(@@mode, gets.strip)
		end
	end
end