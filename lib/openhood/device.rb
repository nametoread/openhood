require "openssl"

module Openhood
	class Device
		def self.run(mode, effect, secret, data)
			cipher = OpenSSL::Cipher.new(mode)

			cipher.send(effect.to_sym)

			cipher.key = secret[:key]
			cipher.iv = secret[:iv]

			cipher.update(data) + cipher.final
		end
	end
end