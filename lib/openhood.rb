require "openhood/version"
require "openhood/ui"

module Openhood
	class Error < StandardError; end
end

Openhood::UI.run()
