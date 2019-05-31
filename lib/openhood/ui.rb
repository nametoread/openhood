require "key"
require "device"

require "time"

module Openhood
	class UI
		def run
			mode = getMode
			effect = getEffect
			file = getFile
			secret = mode == "DES3" ? getSecret(24, 8) : getSecret

			result = Device.run(mode, effect, secret, file)

			store(result)
		end

		class << self
			def getMode
				print "aes / cam / des / seed: "
				
				mode = case gets.strip
				when "aes" then "AES128"
				when "cam" then "CAMELLIA128"
				when "des" then "DES3"
				when "seed" then "SEED"
				else abort("i didn't quite catch that.")
				end

				mode
			end

			def getEffect
				print "encrypt / decrypt: "
				effect = gets.strip

				unless effect != "encrypt" ^ effect != "decrypt"
					effect
				else
					abort("what?")
				end
			end

			def getFile
				print "path to file: "
				path = gets.strip

				abort("can't find this one") unless File.exist?(path)

				data = File.binread(path)
			end

			def getSecret(a = 16, b = 16)
				print "phrase: "
				phrase = gets.strip
				
				Key.generate(phrase, a, b)
			end

			def store(data)
				#Time.now.getlocal.iso8601
				name = Time.now.getlocal.strftime("shot-%H%M%S.dat")
				File.binwrite(name, data)
	
				puts "saved to: #{name}"
			end
		end
	end
end