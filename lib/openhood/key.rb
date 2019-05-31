require "openssl"

module Openhood
	class Key
		def self.generate(phrase, a, b)
			md5 = OpenSSL::Digest::MD5.new
			digest = md5.hexdigest(phrase)

			{
				key: digest.slice!(0, a),
				iv: digest.slice!(0, b)
			}
		end
	end
end