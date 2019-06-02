require "test_helper"

class OpenhoodTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Openhood::VERSION
	end
	
	def run_mode(mode, a, b)
		target = __FILE__
		secret = ::Openhood::Key.generate('password', a, b)

		encrypted = ::Openhood::Device.run(mode, 'encrypt', secret, target)
		decrypted = ::Openhood::Device.run(mode, 'decrypt', secret, encrypted)

		File.binread(target) == File.binread(decrypted)
	end

	def test_check_if_aes_is_working
		run_mode('AES128', 16, 16)
	end

	def test_check_if_cam_is_working
		run_mode('CAMELLIA128', 16, 16)
	end

	def test_check_if_des_is_working
		run_mode('DES3', 24, 8)
	end

	def test_check_if_seed_is_working
		run_mode('SEED', 16, 16)
	end

end
