# @todo should autoload everything in model directory
module Hydra::Model;end
Dir[File.join(File.dirname(__FILE__), "model", "*.rb")].each {|f| require f}
