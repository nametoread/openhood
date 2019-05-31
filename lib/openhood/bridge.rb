require "openhood/device"
require "openhood/key"

module Openhood
	# TODO: replace aborts with exceptions
	class Bridge
		class << self
			def getMode(input)
				case input
				when "aes" then "AES128"
				when "cam" then "CAMELLIA128"
				when "des" then "DES3"
				when "seed" then "SEED"

				else abort("invalid mode.")
				end
			end

			def getEffect(input)
				unless (input != "en") and (input != "de")
					input + "crypt"
				else
					abort("invalid operation code.")
				end
			end

			def getFile(input)
				# TODO: change name of file to path
				abort("can't find this one") unless File.exist?(input)
				File.binread(input)
			end

			def getSecret(mode, input)
				if mode == "DES3"
					a = 24
					b = 8
				else
					a = b = 16
				end
				
				Key.generate(input, a, b)
			end

			def calculateAndSave(mode, effect, secret, file)
				result = Device.run(mode, effect, secret, file)
				
				#Time.now.getlocal.iso8601
				name = Time.now.getlocal.strftime("shot-%H%M%S.dat")
				File.binwrite(name, result)
				name
			end
		end
	end
end